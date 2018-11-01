package com.sojson.dealer.service.impl;

import com.sojson.common.ExportHeader;
import com.sojson.common.IConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbDealerMapper;
import com.sojson.common.dao.UTbVipRecordMapper;
import com.sojson.common.model.TbDealer;
import com.sojson.common.model.TbVips;
import com.sojson.common.model.UUser;
import com.sojson.common.model.vo.DealerCountVo;
import com.sojson.common.model.vo.VipRecordCount;
import com.sojson.common.utils.ExcelUtil;
import com.sojson.common.utils.QrCodeUtil;
import com.sojson.common.utils.SendMsgUtil;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.config.IConfig;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.core.shiro.token.manager.TokenManager;
import com.sojson.dealer.service.DealerService;
import com.sojson.user.manager.UserManager;
import com.sojson.user.service.UUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by lx on 2018/9/4.
 */
@Service
public class DealerServiceImpl extends BaseMybatisDao<UTbDealerMapper> implements DealerService {

    @Autowired
    UTbDealerMapper uTbDealerMapper;

    @Autowired
    UTbVipRecordMapper uTbVipRecordMapper;

    @Resource
    UUserService userService;

    protected Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

    @SuppressWarnings("unchecked")
    @Override
    public Pagination<TbDealer> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }

    @Override
    public ResultMessage update(TbDealer entity) {
        //数据验证
        ResultMessage msg = beforeUpdateVaild(entity);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
            entity.setModTime(new Date()); //设置修改时间
            uTbDealerMapper.update(entity);
        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Transactional
    @Override
    public ResultMessage insert(TbDealer entity) {
        resultMap.put("status", 400);
        String email = entity.getLoginName();
        UUser user = userService.findUserByEmail(email);
        if(null != user){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "帐号|Email已经存在！");
        }

        UUser userEntity = new UUser();
        userEntity.setEmail(email);
        Date date = new Date();
        userEntity.setCreateTime(date);
        userEntity.setLastLoginTime(date);
        userEntity.setPswd("123456");
        userEntity.setNickname(entity.getName());
        //把密码md5
        userEntity = UserManager.md5Pswd(userEntity);
        //设置有效
        userEntity.setStatus(UUser._1);
        //新增user表数据
        userEntity = userService.insert(userEntity);
        //新增经销商
        entity.setUserId(userEntity.getId());
        entity.setDelFlag(TbDealer._0);
        entity.setCrtTime(date);

        String seatNum = "";
        if(entity.getParentId().equals("0")) {
//            int count = uTbDealerMapper.queryDealerCount() + 1;
            seatNum = entity.getSeatNum();
        }else{
            seatNum = uTbDealerMapper.getSeatNumByUserId(entity.getParentId());
        }
        String inviteNum = seatNum + userEntity.getId();

        entity.setSeatNum(seatNum);
        entity.setInviteNum(inviteNum);
        uTbDealerMapper.insert(entity);
        userService.addRole2User(userEntity.getId(),entity.getRoleId());
        SendMsgUtil.sendDealerMsg(entity.getPhone(),entity.getSeatNum(), entity.getLoginName());

        /**
         * 用户注册链接
         */
        String url = IConfig.get("url")+"/static/wx/index.html?t=7&inviteNum="+inviteNum;
        String path = IConfig.get("qrCode_path_real");
        String fileName = userEntity.getId() + ".jpg";
        QrCodeUtil.createQrCode(url, path, fileName);

        /**
         * 报名
         */
        String url1 = IConfig.get("real_url")+"/static/wx/index.html?t=5&inviteNum="+inviteNum;
        String path1 = IConfig.get("qrCode_path_real");
        String fileName1 = "p"+userEntity.getId() + ".jpg";
        QrCodeUtil.createQrCode(url1, path1, fileName1);

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Override
    public ResultMessage delete(String id) {
        uTbDealerMapper.delete(id);

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    private ResultMessage beforeUpdateVaild(TbDealer entity){
        //修改ID验证
        if (StringUtils.isBlank(entity.getId())) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"经销商信息错误！");
        }

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }


    @Override
    public ResultMessage exportExcelDealerVip(Map<String,Object> param){
        ResultMessage msg = new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"EXCEL生成成功！");
        List<DealerCountVo> DealerCountVos = countDealerVip(param);
        //文件保存地址
        String path = IConfig.get("excel_dealer_count_path");
        File pathFile = new File(path);
        if(!pathFile.exists()){//目录不存在就创建
            pathFile.mkdirs();
        }
        List<Object[]> dataList = changeDealerVip2Array(DealerCountVos);
        dataList.add(0,ExportHeader.DEALER_COUNT_HEAD);
        String fileName = StringUtils.getUUID32() + ".xlsx";
        try {
            ExcelUtil.writeCommonExcel(dataList,path+fileName,"sheet1");
            List<String> fileInfo = new ArrayList<String>();
            fileInfo.add("经销商会员统计.xlsx");//下载文件名
            fileInfo.add(path+fileName);//错误文件路径
            msg.setData(fileInfo);
        } catch (IOException e) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"生成EXCEL异常，请稍后再试！");
        }

        return msg;

    }

    private List<Object[]> changeDealerVip2Array(List<DealerCountVo> DealerCountVos){
        List<Object[]> dataList = new ArrayList<Object[]>();
        for (DealerCountVo dealerCountVo : DealerCountVos) {
            Object[] dataline = new Object[ExportHeader.DEALER_COUNT_HEAD.length];
            dataline[0] = dealerCountVo.getName();
            dataline[1] = String.valueOf(dealerCountVo.getVipACount());
            dataline[2] = String.valueOf(dealerCountVo.getVipAMoneyCount());
            dataline[3] = String.valueOf(dealerCountVo.getVipBCount());
            dataline[4] = String.valueOf(dealerCountVo.getVipBMoneyCount());
            dataline[5] = String.valueOf(dealerCountVo.getVipCCount());
            dataline[6] = String.valueOf(dealerCountVo.getVipCMoneyCount());
            dataline[7] = String.valueOf(dealerCountVo.getVipMoneyCount());
            dataList.add(dataline);
        }
        return dataList;
    }

    /**
     * 统计经销商的会员数
     * @param param
     * @return
     */
    @Override
    public List<DealerCountVo> countDealerVip(Map<String,Object> param){
        List<VipRecordCount> vipRecordCounts = uTbVipRecordMapper.countByCode(param);
        //统计会员数
        List<VipRecordCount> vipCount = uTbVipRecordMapper.countVipNum(param);

        Map<String,Object> dealerParam = new HashMap<String,Object>();
        List<TbDealer> dealers = uTbDealerMapper.findAll(dealerParam);
        //key是员工邀请码，value是父类
        Map<String,String> dealerReal = new HashMap<String,String>();
        //将员工和经销商分类
        for(TbDealer tbDealer : dealers){
            if (StringUtils.isBlank(tbDealer.getParentId()) || IConstant.parentId.equals(tbDealer.getParentId())) {
                dealerReal.put(tbDealer.getInviteNum(),tbDealer.getUserId() + "");
            } else {
                dealerReal.put(tbDealer.getInviteNum(),tbDealer.getParentId());
            }
        }
        List<DealerCountVo> dealerCounts = new ArrayList<DealerCountVo>();
        //获取统计信息
        for(TbDealer tbDealer : dealers){
            //统计经销商下的总额
            if (StringUtils.isBlank(tbDealer.getParentId()) || IConstant.parentId.equals(tbDealer.getParentId())) {
                DealerCountVo vo = new DealerCountVo();
                vo.setName(tbDealer.getName()); //名称
                //统计开通会员总额
                for (VipRecordCount vipRecordCount : vipRecordCounts){
                    if (dealerReal.get(vipRecordCount.getInvitaionCode()) != null
                            && dealerReal.get(vipRecordCount.getInvitaionCode()).equals(tbDealer.getUserId() + "")) { //判断是否要归到经销商下
                        if (vipRecordCount.getLevel() != null && vipRecordCount.getCountMoney() != null) {
                            Integer money = vipRecordCount.getCountMoney();
                            if (vipRecordCount.getLevel().intValue() == IConstant.VIP_LEVEL.VIP_A.v) {
                                vo.setVipACount(vo.getVipACount() + vipRecordCount.getCountNum());
                                vo.setVipAMoneyCount(new BigDecimal(vo.getVipAMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                            } else if (vipRecordCount.getLevel().intValue() == IConstant.VIP_LEVEL.VIP_B.v) {
                                vo.setVipBCount(vo.getVipBCount() + vipRecordCount.getCountNum());
                                vo.setVipBMoneyCount(new BigDecimal(vo.getVipBMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                            } else if (vipRecordCount.getLevel().intValue() == IConstant.VIP_LEVEL.VIP_C.v) {
                                vo.setVipCCount(vo.getVipCCount() + vipRecordCount.getCountNum());
                                vo.setVipCMoneyCount(new BigDecimal(vo.getVipCMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                            }

                            vo.setVipMoneyCount(new BigDecimal(vo.getVipMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                        }
                    }
                }

                //统计开通会员总数
                for (VipRecordCount vipRecordCount : vipCount){
                    if (dealerReal.get(vipRecordCount.getInvitaionCode()) != null
                            && dealerReal.get(vipRecordCount.getInvitaionCode()).equals(tbDealer.getUserId() + "")) { //判断是否要归到经销商下
                        vo.setVipCount(vo.getVipCount()+vipRecordCount.getCountNum());
                    }
                }
                dealerCounts.add(vo);
            }
        }

        return dealerCounts;
    }


    /**
     * 统计经销商的会员数
     * @param param
     * @return
     */
    @Override
    public List<DealerCountVo> countDealerVipById(Map<String,Object> param){
       TbDealer  tbDealer = uTbDealerMapper.findDealerByUserId(TokenManager.getUserId());
       //没有经销商。就证明是管理员，可以查看所有
       if (tbDealer != null) {
           param.put("dealerId", tbDealer.getId());
       }
       List<VipRecordCount> vipRecordCounts = uTbVipRecordMapper.countByEmployee(param);

        //key是邀请码，value是具体的值
        Map<String, DealerCountVo> map = new HashMap<String, DealerCountVo>();
        List<DealerCountVo> list = new ArrayList<DealerCountVo>();
        for (VipRecordCount vipRecordCount : vipRecordCounts){
            Integer money = vipRecordCount.getCountMoney();
            if (map.get(vipRecordCount.getInvitaionCode()) == null) {
                map.put(vipRecordCount.getInvitaionCode(),new DealerCountVo());
            }
            DealerCountVo vo = map.get(vipRecordCount.getInvitaionCode());
            vo.setName(vipRecordCount.getName());
            if (vipRecordCount.getLevel().intValue() == IConstant.VIP_LEVEL.VIP_A.v) {
                vo.setVipACount(vo.getVipACount() + vipRecordCount.getCountNum());
                vo.setVipAMoneyCount(new BigDecimal(vo.getVipAMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
            } else if (vipRecordCount.getLevel().intValue() == IConstant.VIP_LEVEL.VIP_B.v) {
                vo.setVipBCount(vo.getVipBCount() + vipRecordCount.getCountNum());
                vo.setVipBMoneyCount(new BigDecimal(vo.getVipBMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
            } else if (vipRecordCount.getLevel().intValue() == IConstant.VIP_LEVEL.VIP_C.v) {
                vo.setVipCCount(vo.getVipCCount() + vipRecordCount.getCountNum());
                vo.setVipCMoneyCount(new BigDecimal(vo.getVipCMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
            }
//            vo.setVipCount(vo.getVipCount() + 1);
            vo.setVipMoneyCount(new BigDecimal(vo.getVipMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
        }
        list.addAll(map.values());
        return list;
    }


    @Override
    public ResultMessage exportEmployee(Map<String,Object> param){
        ResultMessage msg = new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"EXCEL生成成功！");
        List<DealerCountVo> employees = countDealerVipById(param);
        //文件保存地址
        String path = IConfig.get("excel_employee_count_path");
        File pathFile = new File(path);
        if(!pathFile.exists()){//目录不存在就创建
            pathFile.mkdirs();
        }
        List<Object[]> dataList = changeDealerVip2Array(employees);
        dataList.add(0,ExportHeader.EMPLOYEE_COUNT_HEAD);
        String fileName = StringUtils.getUUID32() + ".xlsx";
        try {
            ExcelUtil.writeCommonExcel(dataList,path+fileName,"sheet1");
            List<String> fileInfo = new ArrayList<String>();
            fileInfo.add("员工会员统计.xlsx");//下载文件名
            fileInfo.add(path+fileName);//错误文件路径
            msg.setData(fileInfo);
        } catch (IOException e) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"生成EXCEL异常，请稍后再试！");
        }


        return msg;

    }

    @Override
    public ResultMessage queryLink(String userId) {
        TbDealer dealer = uTbDealerMapper.findDealerByUserId(TokenManager.getUserId());
        if(null == dealer){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "未查询到经销商");
        }
        String url = IConfig.get("url")+"/static/vips/register.jsp?seatNum=" + dealer.getSeatNum()+"&inviteNum="+dealer.getInviteNum();
        String mobileUrl = IConfig.get("url")+"/static/mobile/index.html?seatNum=" + dealer.getSeatNum()+"&inviteNum="+dealer.getInviteNum();
        String[] strArray={url,"2"};

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "查询成功！", strArray);

    }

    @Override
    public ResultMessage queryPlayerSignup(String userId) {
        TbDealer dealer = uTbDealerMapper.findDealerByUserId(TokenManager.getUserId());
        if(null == dealer){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "未查询到经销商");
        }
        String url = IConfig.get("real_url")+"/static/signup/signup.jsp?inviteNum="+dealer.getInviteNum();
        String mobileUrl = IConfig.get("real_url")+"/static/wx/index.html?t=5&inviteNum="+dealer.getInviteNum();
        String[] strArray={url,"2"};

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "查询成功！", strArray);

    }

    @Override
    public String queryMoney(String userId) {
        return uTbDealerMapper.queryMoney(userId);
    }

    @Override
    public ResultMessage validPhone(String telPhone){
        TbDealer dealer = uTbDealerMapper.findDealerByPhone(telPhone);
        if(null != dealer){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "电话号码已经存在！");
        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Override
    public ResultMessage valiSeatNum(String seatNum) {
        TbDealer dealer = uTbDealerMapper.findDealerBySeatNum(seatNum);
        if(null != dealer){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "坐席号已经存在！");
        }

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Override
    public ResultMessage querySeatNum() {
        int count = uTbDealerMapper.queryDealerCount() + 1;
        String seatNum = String.format("%03d", count);

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "",seatNum);
    }

    @Override
    public TbDealer queryByUserId(String userId) {
        return uTbDealerMapper.findDealerByUserId(Long.parseLong(userId));
    }

    @Override
    public String queryUserType(String userId) {
        return uTbDealerMapper.queryUserType(userId);
    }
}
