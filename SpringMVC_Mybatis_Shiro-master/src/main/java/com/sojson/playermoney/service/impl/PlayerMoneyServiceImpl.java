package com.sojson.playermoney.service.impl;

import com.sojson.common.IConstant;
import com.sojson.common.ImportHeader;
import com.sojson.common.RegConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbPlayerMoneyMapper;
import com.sojson.common.model.TbPlayerMoney;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.PlayerTopInfo;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.common.model.vo.TbGainsInfoVo;
import com.sojson.common.model.vo.TbPlayerMoneyVo;
import com.sojson.common.utils.ExcelToBeanUtil;
import com.sojson.common.utils.ExcelUtil;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.config.IConfig;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.inf.gainsinfo.utis.GainsInfoCache;
import com.sojson.player.service.PlayerService;
import com.sojson.playermoney.service.PlayerMoneyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by lx on 2018/8/27.
 */
@Service
public class PlayerMoneyServiceImpl extends BaseMybatisDao<UTbPlayerMoneyMapper> implements PlayerMoneyService {

    @Autowired
    UTbPlayerMoneyMapper uTbPlayerMoneyMapper;

    @Resource
    PlayerService playerService;


    /**
     * 导入参赛选手数据
     * @param file 参赛选手EXCEL
     * @return
     */
    @Override
    @Transactional
    public ResultMessage importPlayerMoneyExcel(MultipartFile file) {
        ResultMessage msg = beforeImport(file);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v ) { //验证正确则继续处理后续文件操作

            //新文件名称
            String newFileName = StringUtils.getUUID32() + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
           //文件保存地址
            String path = IConfig.get("excel_file_path");
            File pathFile = new File(path);
            if(!pathFile.exists()){//目录不存在就创建
                pathFile.mkdirs();
            }
            //保存文件
            try {
                file.transferTo(new File(path + newFileName));
                ExcelToBeanParamImpl param = new ExcelToBeanParamImpl();
                param.setPlayes(playerService.findAll(new TbPlayerDto()));
                //解析Excel
                msg = ExcelToBeanUtil.changeExcelToPo(path + newFileName, ImportHeader.playerMoneyHeadReal,ImportHeader.getPlayerMoneyHeadFormat(),TbPlayerMoney.class,0,param);
                if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
                    Map<Byte, Object> result = (Map<Byte, Object>) msg.getData();
                    //导入正确的数据
                    List<TbPlayerMoney> succList = (List<TbPlayerMoney>) result.get(ResultMessage.MSG_LEVEL.SUCC.v);
                    //导入失败的数据
                    List<Object[]> failList = (List<Object[]>) result.get(ResultMessage.MSG_LEVEL.FAIL.v);
                    int succCount = 0;
                    int failCount = 0;
                    //处理正确的数据
                    if (succList.size() > 0) {
                        Date now = new Date();
                        for (TbPlayerMoney PlayerMoney : succList) {
                            PlayerMoney.setCrtTime(now);
                        }
                        uTbPlayerMoneyMapper.insertBatch(succList);
                        succCount = succList.size();
                    }
                    if (failList.size() > 0) {
                        failCount = failList.size();
                        String errorPath = IConfig.get("excel_file_error_path");
                        File errorFile = new File(errorPath);
                        if(!errorFile.exists()){//目录不存在就创建
                            errorFile.mkdirs();
                        }
                        //设置头消息
                        Object[] head =  ImportHeader.playerMoneyHeadReal.keySet().toArray();
                        Object[] errorHead = new Object[head.length + 1];
                        System.arraycopy(head, 0, errorHead, 0, head.length );
                        errorHead[head.length] = "错误原因";
                        failList.add(0,errorHead);
                        String errorFileName = StringUtils.getUUID32() + "_error" + newFileName.substring(newFileName.lastIndexOf("."));
                        ExcelUtil.writeExcel(failList,errorPath+errorFileName,"sheet1");
                        List<String> errorFileInfo = new ArrayList<String>();
                        String errorName = file.getOriginalFilename().substring(0,file.getOriginalFilename().lastIndexOf(".")) + "_error" + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
                        errorFileInfo.add(errorName);//下载文件名
                        errorFileInfo.add(errorPath+errorFileName);//错误文件路径
                        msg.setData(errorFileInfo);
                    }
                    msg.setMessageText("导入完成，共计"+(succCount+failCount)+"条数据,其中正确"+succCount+"条,错误"+failCount+"条");

                }
            } catch (IOException e) {
                LoggerUtils.error(PlayerMoneyServiceImpl.class,"文件上传失败："+e.getMessage());
               return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"文件上传失败！");
            }catch (Exception e){
                LoggerUtils.error(PlayerMoneyServiceImpl.class,"EXCEL解析失败："+e.getMessage());
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"EXCEL解析失败！");
            }

        //重新计算排名
            getTopResultForAll();

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
            Calendar cal=Calendar.getInstance();
            String currDate = formatter.format(cal.getTime());
            cal.add(Calendar.MONTH,-1);
            String preDate = formatter.format(cal.getTime());
            findTopByMonth(currDate,preDate);
        }
        return msg;
    }

    /**
     * 验证导入的文件
     * @param file
     * @return
     */
    private ResultMessage beforeImport(MultipartFile file){
        if (StringUtils.isBlank(file.getOriginalFilename())
                || !(file.getOriginalFilename().toLowerCase().endsWith(".xls") || file.getOriginalFilename().toLowerCase().endsWith(".xlsx"))) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"EXCEL文件格式错误!");
        }
        if (file.getSize() < 1) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"EXCEL文件大小错误!");
        }
        return  new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }


    @SuppressWarnings("unchecked")
    @Override
    public Pagination<TbPlayerMoneyVo> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }

    @Override
    @Transactional
    public ResultMessage update(TbPlayerMoney tbPlayerMoney){
        ResultMessage msg = beforeInDb(tbPlayerMoney);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
            tbPlayerMoney.setModTime(new Date());
            uTbPlayerMoneyMapper.updateByPrimaryKeySelective(tbPlayerMoney);
        }
        return msg;
    }

    @Override
    @Transactional
    public ResultMessage add(TbPlayerMoney tbPlayerMoney){
        ResultMessage msg = beforeInDb(tbPlayerMoney);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
            tbPlayerMoney.setCrtTime(new Date());
            uTbPlayerMoneyMapper.insert(tbPlayerMoney);
        }
        return msg;
    }


    @Override
    @Transactional
    public ResultMessage deleteById(Long id){
        uTbPlayerMoneyMapper.deleteById(id);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    private ResultMessage beforeInDb(TbPlayerMoney tbPlayerMoney){
        //操作时间
        if (tbPlayerMoney.getBusinessTime() == null){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"操作时间不能为空！");
        }


        //剩余资金
        if (StringUtils.isBlank(tbPlayerMoney.getBalanceMoney()) || !tbPlayerMoney.getBalanceMoney().toString().matches(RegConstant.moneyReg)) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"剩余资金只能为数字且最多包含2位小数！");
        }

        //总资产
        if (StringUtils.isBlank(tbPlayerMoney.getTotalMoney()) || !tbPlayerMoney.getTotalMoney().toString().matches(RegConstant.moneyReg)) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"总资产只能为数字且最多包含2位小数！");
        }

        //验证资金账户
        TbPlayerDto player  = new TbPlayerDto();
        player.setAccount(tbPlayerMoney.getAccount());
        List<TbPlayer> players = playerService.findAll(player);
        if (players == null ||  players.size() == 0) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"此资金账户没有对应参赛选手！");
        }

        //如果是新增则验证是不是重复数据
        if (tbPlayerMoney.getId() == null) {
            List<TbPlayerMoneyVo> PlayerMoneys = uTbPlayerMoneyMapper.findPlayerMoney(tbPlayerMoney);
            if (PlayerMoneys != null && PlayerMoneys.size() > 0) {
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"重复数据，请检查后再添加！");
            }

            //新增才验证资金账户
            if (tbPlayerMoney.getAccount() == null || StringUtils.isBlank(tbPlayerMoney.getAccount())) {
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"资金账户不正确！");
            }
        }

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);

    }

    /**
     * 获取总排行榜
     */
    @Override
    public void getTopResultForAll(){
        //获取所有选手的数据
        List<TbPlayerMoneyVo> topInfos = uTbPlayerMoneyMapper.findTopForAll();
        //根据身份证统计每个人的信息
        List<PlayerTopInfo> palyerTopInfos = new ArrayList<PlayerTopInfo>();
        //统计总收益的排行
        List<PlayerTopInfo> topInfosClone = new ArrayList<PlayerTopInfo>();
        //保存已经存在的重复数据
        List<String> hasAccount = new ArrayList<String>();
        for (TbPlayerMoneyVo topInfo : topInfos) {
            //剔除重复数据
            if (hasAccount.contains(topInfo.getAccount())) {
                continue;
            }
            hasAccount.add(topInfo.getAccount());
            PlayerTopInfo playerTopInfo = new PlayerTopInfo();
            playerTopInfo.setAccountName(topInfo.getAccountName());
            playerTopInfo.setAccount(topInfo.getAccount());
            playerTopInfo.setTotalMoney(topInfo.getTotalMoney());
            playerTopInfo.setCapital(topInfo.getCapital());
            //计算收益率
            double totleDou = Double.parseDouble(topInfo.getTotalMoney());
            double capital = Double.parseDouble(String.valueOf(IConstant.capital));


            BigDecimal bg = new BigDecimal((totleDou - capital) * 100/capital);
            double rate = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            playerTopInfo.setYieldRate(rate + "");
            bg = new BigDecimal(totleDou - capital);
            playerTopInfo.setYield(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() + "");
            //持仓比

            //计算剩余金额
            double buyMoney = totleDou - Double.parseDouble(String.valueOf(topInfo.getBalanceMoney()));
            bg = new BigDecimal(buyMoney * 100/totleDou);
            rate = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            playerTopInfo.setBuyForALLRate(rate + "");
            palyerTopInfos.add(playerTopInfo);
            topInfosClone.add(playerTopInfo.clone());
        }
        //按照收益率排序
        Collections.sort(palyerTopInfos,Collections.reverseOrder());
        //按照总收益排序
        Collections.sort(topInfosClone, new Comparator<PlayerTopInfo>(){
            public int compare(PlayerTopInfo p1, PlayerTopInfo p2) {
                if(Double.parseDouble(p1.getYield()) <= Double.parseDouble(p2.getYield())){
                    return 1;
                }
                return -1;
            }
        });
        for (int i = 0 ; i < palyerTopInfos.size(); i++) {
            palyerTopInfos.get(i).setRank(i+1);
            topInfosClone.get(i).setRank(i+1);
        }
        GainsInfoCache.putTopForAll(palyerTopInfos);

        GainsInfoCache.putTopForAllByMoney(topInfosClone);
    }

    /**
     * 根据时间查询排行（一般用于月排行）
     * @param currDate
     * @param preDate
     */
    @Override
    public void findTopByMonth(String currDate,String preDate){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("currDate",currDate);
		List<TbPlayerMoneyVo> cuurTopInfos = uTbPlayerMoneyMapper.findTopByMonth(param);
		param.put("currDate",preDate);
		List<TbPlayerMoneyVo> preTopInfos = uTbPlayerMoneyMapper.findTopByMonth(param);
		//根据身份证统计每个人的信息
		List<PlayerTopInfo> palyerTopMonthInfos = new ArrayList<PlayerTopInfo>();
		//保存已经存在的重复数据
		List<String> hasAccount = new ArrayList<String>();
		for (TbPlayerMoneyVo cuurTopInfo : cuurTopInfos) {
			//剔除重复数据
			if (hasAccount.contains(cuurTopInfo.getAccount())) {
				continue;
			}
			hasAccount.add(cuurTopInfo.getAccount());

			PlayerTopInfo playerTopInfo = new PlayerTopInfo();
			playerTopInfo.setAccountName(cuurTopInfo.getAccountName());
			playerTopInfo.setAccount(cuurTopInfo.getAccount());
			playerTopInfo.setTotalMoney(cuurTopInfo.getTotalMoney());
			playerTopInfo.setCapital(cuurTopInfo.getCapital()); //默认先设置本金为当前本金，（因为初始化第一个月就是用本金）

			//***********************************计算收益率
			//找到上个月最后一条记录做为本金
			for (TbPlayerMoneyVo preTopInfo : preTopInfos) {
				if (preTopInfo.getAccount().equals(cuurTopInfo.getAccount())) {
					//以上个月最后一天的资金做为本金计算收益
					playerTopInfo.setCapital(preTopInfo.getTotalMoney());
					break;
				}
			}
            //计算收益率
            double totleDou = Double.parseDouble(playerTopInfo.getTotalMoney());
            double capital = Double.parseDouble(playerTopInfo.getCapital());
            BigDecimal bg = new BigDecimal((totleDou - capital) * 100/capital);
            double rate = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            playerTopInfo.setYieldRate(rate + "");

            bg = new BigDecimal(totleDou - capital);
            playerTopInfo.setYield(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() + "");
            //持仓比

            //计算剩余金额
            double buyMoney = totleDou - Double.parseDouble(String.valueOf(cuurTopInfo.getBalanceMoney()));
            bg = new BigDecimal(buyMoney * 100/totleDou);
            rate = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            playerTopInfo.setBuyForALLRate(rate + "");

			palyerTopMonthInfos.add(playerTopInfo);
		}

        Collections.sort(palyerTopMonthInfos,Collections.reverseOrder());
        for (int i = 0 ; i < palyerTopMonthInfos.size(); i++) {
            palyerTopMonthInfos.get(i).setRank(i+1);
        }
		GainsInfoCache.putTopForMonth(palyerTopMonthInfos);
    }
}
