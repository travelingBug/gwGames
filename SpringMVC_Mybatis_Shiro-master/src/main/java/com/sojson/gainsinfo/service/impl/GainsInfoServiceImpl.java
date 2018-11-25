package com.sojson.gainsinfo.service.impl;

import com.sojson.common.ImportHeader;
import com.sojson.common.RegConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbGainsInfoMapper;
import com.sojson.common.dao.UTbPlayerMoneyMapper;
import com.sojson.common.model.TbGainsInfo;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.TbGainsInfoDto;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.common.model.vo.PlayerTransVo;
import com.sojson.common.model.vo.TbGainsInfoVo;
import com.sojson.common.utils.*;
import com.sojson.core.config.IConfig;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.gainsinfo.service.GainsInfoService;
import com.sojson.inf.gainsinfo.utis.GainsInfoCache;
import com.sojson.player.service.PlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.sojson.common.RegConstant.moneyReg;

/**
 * Created by lx on 2018/8/27.
 */
@Service
public class GainsInfoServiceImpl extends BaseMybatisDao<UTbGainsInfoMapper> implements GainsInfoService {

    @Autowired
    UTbGainsInfoMapper uTbGainsInfoMapper;

    @Resource
    PlayerService playerService;

    @Resource
    UTbPlayerMoneyMapper uTbPlayerMoneyMapper;

    /**
     * 导入参赛选手数据
     * @param file 参赛选手EXCEL
     * @return
     */
    @Override
    @Transactional
    public ResultMessage importGainsExcel(MultipartFile file) {
        ResultMessage msg = beforeImport(file);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v ) { //验证正确则继续处理后续文件操作
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
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
                msg = ExcelToBeanUtil.changeExcelToPo(path + newFileName, ImportHeader.gainsInfoHeadReal,ImportHeader.getGainsInfoHeadFormat(),TbGainsInfo.class,0,param);
                if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
                    Map<Byte, Object> result = (Map<Byte, Object>) msg.getData();
                    //导入正确的数据
                    List<TbGainsInfo> succList = (List<TbGainsInfo>) result.get(ResultMessage.MSG_LEVEL.SUCC.v);
                    //导入失败的数据
                    List<Object[]> failList = (List<Object[]>) result.get(ResultMessage.MSG_LEVEL.FAIL.v);
                    int succCount = 0;
                    int failCount = 0;
                    //处理正确的数据
                    if (succList.size() > 0) {
                        Date now = new Date();
                        //需要被改变的网页策略
                        List<String> accounts = new ArrayList<String>();
                        for (TbGainsInfo gainsInfo : succList) {
                            gainsInfo.setCrtTime(now);
                            //判断用户策略是否被更新
                            if (sdf.format(gainsInfo.getBusinessTime()).equals(sdf.format(now))) {
                                if (!accounts.contains(gainsInfo.getAccount())) {
                                    accounts.add(gainsInfo.getAccount());
                                }
                            }
                        }
                        if (accounts != null && accounts.size() > 0) {
                            GainsInfoCache.updateNewFlag(accounts);
                        }
                        uTbGainsInfoMapper.insertBatch(succList);
                        succCount = succList.size();


                        Map<String,Object> paramObj = new HashMap<String,Object>();
                        SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM");
                        //获取当月的交易数量
                        paramObj.put("currDate",sdfDay.format(new Date()));
                        List<PlayerTransVo> playerTransVos = uTbPlayerMoneyMapper.getTransCount(paramObj);
                        GainsInfoCache.updateTransCount(playerTransVos);
                    }
                    if (failList.size() > 0) {
                        failCount = failList.size();
                        String errorPath = IConfig.get("excel_file_error_path");
                        File errorFile = new File(errorPath);
                        if(!errorFile.exists()){//目录不存在就创建
                            errorFile.mkdirs();
                        }
                        //设置头消息
                        Object[] head =  ImportHeader.gainsInfoHeadReal.keySet().toArray();
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
                LoggerUtils.error(GainsInfoServiceImpl.class,"文件上传失败："+e.getMessage());
               return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"文件上传失败！");
            }catch (Exception e){
                LoggerUtils.error(GainsInfoServiceImpl.class,"EXCEL解析失败："+e.getMessage());
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"EXCEL解析失败！");
            }

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
    public Pagination<TbGainsInfoVo> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }

    @Override
    @Transactional
    public ResultMessage update(TbGainsInfo tbGainsInfo){
        ResultMessage msg = beforeInDb(tbGainsInfo);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
            tbGainsInfo.setModTime(new Date());
            uTbGainsInfoMapper.updateByPrimaryKeySelective(tbGainsInfo);
        }
        return msg;
    }

    @Override
    @Transactional
    public ResultMessage add(TbGainsInfo tbGainsInfo){
        ResultMessage msg = beforeInDb(tbGainsInfo);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
            tbGainsInfo.setCrtTime(new Date());
            uTbGainsInfoMapper.insert(tbGainsInfo);
        }
        return msg;
    }


    @Override
    @Transactional
    public ResultMessage deleteById(Long id){
        uTbGainsInfoMapper.deleteById(id);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    private ResultMessage beforeInDb(TbGainsInfo tbGainsInfo){
        //操作时间
        if (tbGainsInfo.getBusinessTime() == null){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"操作时间不能为空！");
        }



        //股票代码
        if (StringUtils.isBlank(tbGainsInfo.getSharesCode()) || tbGainsInfo.getSharesCode().toString().length() > 20) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"股票代码格式错误！");
        }
        //股票名称
        if (StringUtils.isBlank(tbGainsInfo.getSharesName()) || tbGainsInfo.getSharesName().toString().length() > 50) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"股票名称格式错误！");
        }
        //买卖标志
        if (tbGainsInfo.getBusinessFlag() == null || !(tbGainsInfo.getBusinessFlag() <= 4 && tbGainsInfo.getBusinessFlag() >= 0)) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"买卖标志错误！");
        }
        //成交数量
        if (StringUtils.isBlank(tbGainsInfo.getVolume()) || !tbGainsInfo.getVolume().toString().matches(RegConstant.numReg)) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"成交数量格式错误！");
        }


        //成交价格
        if (StringUtils.isBlank(tbGainsInfo.getPrice()) || !tbGainsInfo.getPrice().toString().matches(RegConstant.moneyReg)) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"成交价格只能为数字且最多包含2位小数！");
        }

        //成交总金额
        if (StringUtils.isBlank(tbGainsInfo.getAmount()) || !tbGainsInfo.getAmount().toString().matches(RegConstant.moneyReg)) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"成交总金额只能为数字且最多包含2位小数！");
        }

        //验证资金账户
        TbPlayerDto player  = new TbPlayerDto();
        player.setAccount(tbGainsInfo.getAccount());
        List<TbPlayer> players = playerService.findAll(player);
        if (players == null ||  players.size() == 0) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"此身份证没有对应参赛选手！");
        }

        //如果是新增则验证是不是重复数据
        if (tbGainsInfo.getId() == null) {
            List<TbGainsInfoVo> gainsInfos = uTbGainsInfoMapper.findGainsInfo(tbGainsInfo);
            if (gainsInfos != null && gainsInfos.size() > 0) {
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"重复数据，请检查后再添加！");
            }

            //新增才验证资金账户
            if (tbGainsInfo.getAccount() == null || StringUtils.isBlank(tbGainsInfo.getAccount())) {
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"资金账户不正确！");
            }
        }

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);

    }
}
