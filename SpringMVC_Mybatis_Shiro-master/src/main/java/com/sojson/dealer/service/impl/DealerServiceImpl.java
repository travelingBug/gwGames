package com.sojson.dealer.service.impl;

import com.sojson.common.ExportHeader;
import com.sojson.common.IConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbDealerCardMapper;
import com.sojson.common.dao.UTbDealerMapper;
import com.sojson.common.dao.UTbVipRecordMapper;
import com.sojson.common.dao.UTbVipsMapper;
import com.sojson.common.model.TbDealCard;
import com.sojson.common.dao.UTbVipsMapper;
import com.sojson.common.model.TbDealer;
import com.sojson.common.model.TbVipRecord;
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

    @Autowired
    UTbVipsMapper uTbVipsMapper;

    @Autowired
    UTbDealerCardMapper uTbDealerCardMapper;

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
        String pwd = StringUtils.getRandom(6);
        userEntity.setPswd(pwd);
//        userEntity.setPswd("123456");
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
        SendMsgUtil.sendDealerMsg(entity.getPhone(),entity.getSeatNum(), entity.getLoginName(), pwd);

        /**
         * 用户注册链接
         */
        String url = IConfig.get("real_url")+"/static/wx/index.html?t=7&inviteNum="+inviteNum;
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
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"代理商信息错误！");
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
            fileInfo.add("代理商观众统计.xlsx");//下载文件名
            fileInfo.add(path+fileName);//错误文件路径
            msg.setData(fileInfo);
        } catch (IOException e) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"生成EXCEL异常，请稍后再试！");
        }

        return msg;

    }

    private List<Object[]> changeDealerVip2Array(List<DealerCountVo> DealerCountVos){
        List<Object[]> dataList = new ArrayList<Object[]>();
        int i = 1;
        for (DealerCountVo dealerCountVo : DealerCountVos) {
            Object[] dataline = new Object[ExportHeader.DEALER_COUNT_HEAD.length];
            dataline[0] = i;
            dataline[1] = dealerCountVo.getName();
            dataline[2] =  String.valueOf(dealerCountVo.getVipCount());
            dataline[3] = String.valueOf(dealerCountVo.getVipACount());
            dataline[4] = String.valueOf(dealerCountVo.getVipAMoneyCount());
            dataline[5] = String.valueOf(dealerCountVo.getVipBCount());
            dataline[6] = String.valueOf(dealerCountVo.getVipBMoneyCount());
            dataline[7] = String.valueOf(dealerCountVo.getVipCCount());
            dataline[8] = String.valueOf(dealerCountVo.getVipCMoneyCount());
            dataline[9] = String.valueOf(dealerCountVo.getVipMoneyCount());
            dataList.add(dataline);
            i ++ ;
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

        //时间查询条件
        Map<String,Object> paramDate = new HashMap<String,Object>();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //判断时间条件
        long bgnTimeVal = 0;
        long endTimeVal = 0;
        try {
            if (StringUtils.isNotBlank(param.get("bgnTime"))) {
                Date bgnTime = formatter.parse(param.get("bgnTime").toString());
                bgnTimeVal = bgnTime.getTime();
                paramDate.put("bgnTime",bgnTime);
            }
            if (StringUtils.isNotBlank(param.get("endTime"))) {
                Date endTime = formatter.parse(param.get("endTime").toString());
                endTimeVal = endTime.getTime();
                paramDate.put("endTime",endTime);
            } else {
                endTimeVal = new Date().getTime();
            }

        }catch (Exception e){
            logger.error(e);
            return null;
        }
        //查询出所有的经销商
        Map<String,Object> dealerParam = new HashMap<String,Object>();
        dealerParam.put("fname",param.get("name"));
        dealerParam.put("fgroupName",param.get("groupName"));
        List<TbDealer> dealers = uTbDealerMapper.findDealerIds(dealerParam);
        //将经销商进行分组
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
        //查询出所有的VIP
        List<TbVips> vips = uTbVipsMapper.findVipByDealerId(new HashMap<String,Object>());

        //查询出时间范围内所有的购票记录
        List<TbVipRecord> vipRecords = uTbVipRecordMapper.findRecordByParam(paramDate);

        //统计经销商的数据 key是userId,value是数据
        Map<String,DealerCountVo> result = new HashMap<String,DealerCountVo>();

        //总计数据
        DealerCountVo total = new DealerCountVo();
        total.setName("总计");
        total.setdGroup("");
        for (TbDealer tbDealer : dealers) {
            //获取对应的经销商ID
            String userId = dealerReal.get(tbDealer.getInviteNum());
            if (StringUtils.isNotBlank(userId)) {
                if (result.get(userId) == null) {
                    DealerCountVo vo = new DealerCountVo();
                    result.put(userId, new DealerCountVo());
                }
                DealerCountVo dealerCountVo = result.get(userId);
                //如果是父类。就设置名称
                if (StringUtils.isBlank(tbDealer.getParentId()) || IConstant.parentId.equals(tbDealer.getParentId())) {
                    dealerCountVo.setName(tbDealer.getName());
                    dealerCountVo.setdGroup(tbDealer.getdGroup());
                }
                //统计会员个数
                for (TbVips vip : vips) {
                    if (vip.getInviteCode().equals(tbDealer.getInviteNum())) {

                        //只统计时间范围内新增的VIP个数
                        if (vip.getCrtTime().getTime() >= bgnTimeVal
                                && vip.getCrtTime().getTime() <= endTimeVal) {

//                                if (vip.getLevel().intValue() == IConstant.VIP_LEVEL.VIP_A.v) {
//                                    dealerCountVo.setVipACount(dealerCountVo.getVipACount() + 1);
//                                } else if (vip.getLevel().intValue() == IConstant.VIP_LEVEL.VIP_B.v) {
//                                    dealerCountVo.setVipBCount(dealerCountVo.getVipBCount() + 1);
//                                } else if (vip.getLevel().intValue() == IConstant.VIP_LEVEL.VIP_C.v) {
//                                    dealerCountVo.setVipCCount(dealerCountVo.getVipCCount() + 1);
//                                }

                                dealerCountVo.setVipCount(dealerCountVo.getVipCount() + 1);
                                total.setVipCount(total.getVipCount() + 1);

                        }



                        //统计会员充值金额
                        for (TbVipRecord vipRecord : vipRecords) {
                            if (vipRecord.getVipId().intValue() == vip.getId().intValue()) {
                                Double money = Double.parseDouble(vipRecord.getAmount());
                                if (vipRecord.getLevel() == IConstant.VIP_LEVEL.VIP_A.v) {
                                    dealerCountVo.setVipAMoneyCount(new BigDecimal(dealerCountVo.getVipAMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                                    dealerCountVo.setVipACount(dealerCountVo.getVipACount() + 1);
                                    total.setVipAMoneyCount(new BigDecimal(total.getVipAMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                                    total.setVipACount(total.getVipACount() + 1);
                                } else if (vipRecord.getLevel() == IConstant.VIP_LEVEL.VIP_B.v) {
                                    dealerCountVo.setVipBMoneyCount(new BigDecimal(dealerCountVo.getVipBMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                                    dealerCountVo.setVipBCount(dealerCountVo.getVipBCount() + 1);
                                    total.setVipBMoneyCount(new BigDecimal(total.getVipBMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                                    total.setVipBCount(total.getVipBCount() + 1);
                                } else if (vipRecord.getLevel() == IConstant.VIP_LEVEL.VIP_C.v) {
                                    dealerCountVo.setVipCMoneyCount(new BigDecimal(dealerCountVo.getVipCMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                                    dealerCountVo.setVipCCount(dealerCountVo.getVipCCount() + 1);
                                    total.setVipCMoneyCount(new BigDecimal(total.getVipCMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                                    total.setVipCCount(total.getVipCCount() + 1);
                                }
                                dealerCountVo.setVipMoneyCount(new BigDecimal(dealerCountVo.getVipMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                                total.setVipMoneyCount(new BigDecimal(total.getVipMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());

                            }
                        }
                    }
                }
            }

        }

        List<DealerCountVo> dealerCounts = new ArrayList<DealerCountVo>();
        dealerCounts.addAll(result.values());
        dealerCounts.add(total);
        return dealerCounts;
    }


    /**
     * 统计经销商的会员数
     * @param param
     * @return
     */
    @Override
    public List<DealerCountVo> countDealerVipById(Map<String,Object> param){
        //时间查询条件
        Map<String,Object> paramDate = new HashMap<String,Object>();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //判断时间条件
        long bgnTimeVal = 0;
        long endTimeVal = 0;
        try {
            if (StringUtils.isNotBlank(param.get("bgnTime"))) {
                Date bgnTime = formatter.parse(param.get("bgnTime").toString());
                bgnTimeVal = bgnTime.getTime();
                paramDate.put("bgnTime",bgnTime);
            }
            if (StringUtils.isNotBlank(param.get("endTime"))) {
                Date endTime = formatter.parse(param.get("endTime").toString());
                endTimeVal = endTime.getTime();
                paramDate.put("endTimeVal",endTime);
            } else {
                endTimeVal = new Date().getTime();
            }

        }catch (Exception e){
            logger.error(e);
            return null;
        }
        //查询出所有的经销商
        Map<String,Object> dealerParam = new HashMap<String,Object>();
        dealerParam.put("name",param.get("name"));
        dealerParam.put("groupName",param.get("groupName"));
        String type = uTbDealerMapper.queryUserRoles(TokenManager.getUserId().toString());
        if(type.indexOf(",888888,") >= 0 || type.indexOf(",100004,") >= 0  || type.indexOf(",100005,") >= 0  || type.indexOf(",100006,") >= 0  || type.indexOf(",999999,") >= 0){
            //管理员权限查询所有
        } else {
            dealerParam.put("dealerId",TokenManager.getUserId());
            paramDate.put("dealerId",TokenManager.getUserId());
        }
        List<TbDealer> dealers = uTbDealerMapper.findDealerIds(dealerParam);



        //查询出所有的VIP inviteCode
        List<TbVips> vips = uTbVipsMapper.findVipByDealerId(dealerParam);

        //查询出时间范围内所有的购票记录
        List<TbVipRecord> vipRecords = uTbVipRecordMapper.findRecordByParam(paramDate);

        //统计经销商的数据 key是userId,value是数据
        Map<String,DealerCountVo> result = new HashMap<String,DealerCountVo>();

        //总计数据
        DealerCountVo total = new DealerCountVo();
        total.setName("总计");
        total.setdGroup("");

        for (TbDealer tbDealer : dealers) {
            //获取对应的经销商ID
            String userId = tbDealer.getUserId().toString();
            if (StringUtils.isNotBlank(userId)) {
                if (result.get(userId) == null) {
                    DealerCountVo vo = new DealerCountVo();
                    result.put(userId, new DealerCountVo());
                }
                DealerCountVo dealerCountVo = result.get(userId);
                dealerCountVo.setName(tbDealer.getName());
                dealerCountVo.setdGroup(tbDealer.getdGroup());
                //统计会员个数
                for (TbVips vip : vips) {
                    if (vip.getInviteCode().equals(tbDealer.getInviteNum())) {

                        //只统计时间范围内新增的VIP个数
                        if (vip.getCrtTime().getTime() >= bgnTimeVal
                                && vip.getCrtTime().getTime() <= endTimeVal) {

//                            if (vip.getLevel().intValue() == IConstant.VIP_LEVEL.VIP_A.v) {
//                                dealerCountVo.setVipACount(dealerCountVo.getVipACount() + 1);
//                            } else if (vip.getLevel().intValue() == IConstant.VIP_LEVEL.VIP_B.v) {
//                                dealerCountVo.setVipBCount(dealerCountVo.getVipBCount() + 1);
//                            } else if (vip.getLevel().intValue() == IConstant.VIP_LEVEL.VIP_C.v) {
//                                dealerCountVo.setVipCCount(dealerCountVo.getVipCCount() + 1);
//                            }

                            dealerCountVo.setVipCount(dealerCountVo.getVipCount() + 1);
                            total.setVipCount(total.getVipCount() + 1);

                        }



                        //统计会员充值金额
                        for (TbVipRecord vipRecord : vipRecords) {
                            if (vipRecord.getVipId().intValue() == vip.getId().intValue()) {
                                Double money = Double.parseDouble(vipRecord.getAmount());
                                if (vipRecord.getLevel() == IConstant.VIP_LEVEL.VIP_A.v) {
                                    dealerCountVo.setVipAMoneyCount(new BigDecimal(dealerCountVo.getVipAMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                                    dealerCountVo.setVipACount(dealerCountVo.getVipACount() + 1);
                                    total.setVipAMoneyCount(new BigDecimal(total.getVipAMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                                    total.setVipACount(total.getVipACount() + 1);
                                } else if (vipRecord.getLevel() == IConstant.VIP_LEVEL.VIP_B.v) {
                                    dealerCountVo.setVipBMoneyCount(new BigDecimal(dealerCountVo.getVipBMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                                    dealerCountVo.setVipBCount(dealerCountVo.getVipBCount() + 1);
                                    total.setVipBMoneyCount(new BigDecimal(total.getVipBMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                                    total.setVipBCount(total.getVipBCount() + 1);
                                } else if (vipRecord.getLevel() == IConstant.VIP_LEVEL.VIP_C.v) {
                                    dealerCountVo.setVipCMoneyCount(new BigDecimal(dealerCountVo.getVipCMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                                    dealerCountVo.setVipCCount(dealerCountVo.getVipCCount() + 1);
                                    total.setVipCMoneyCount(new BigDecimal(total.getVipCMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                                    total.setVipCCount(total.getVipCCount() + 1);
                                }
                                dealerCountVo.setVipMoneyCount(new BigDecimal(dealerCountVo.getVipMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
                                total.setVipMoneyCount(new BigDecimal(total.getVipMoneyCount() + money).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());

                            }
                        }
                    }
                }
            }

        }

        List<DealerCountVo> dealerCounts = new ArrayList<DealerCountVo>();
        dealerCounts.addAll(result.values());
        dealerCounts.add(total);
        return dealerCounts;

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
            fileInfo.add("员工观众统计.xlsx");//下载文件名
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
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "未查询到代理商");
        }
        String url = IConfig.get("real_url")+"/static/vips/register.jsp?seatNum=" + dealer.getSeatNum()+"&inviteNum="+dealer.getInviteNum();
        String mobileUrl = IConfig.get("real_url")+"/static/mobile/index.html?seatNum=" + dealer.getSeatNum()+"&inviteNum="+dealer.getInviteNum();
        String[] strArray={url,"2"};

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "查询成功！", strArray);

    }

    @Override
    public ResultMessage queryPlayerSignup(String userId) {
        TbDealer dealer = uTbDealerMapper.findDealerByUserId(TokenManager.getUserId());
        if(null == dealer){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "未查询到代理商");
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

    @Override
    public ResultMessage queryEmployeeList(String inviteCode) {
        ResultMessage msg = new ResultMessage();
        List<TbDealer> list = uTbDealerMapper.queryEmployeeList(inviteCode);
        if(list !=null && list.size()>0){
            msg.setData(list);
            msg.setLevel(ResultMessage.MSG_LEVEL.SUCC.v);
        }

        return msg;
    }

    @Override
    public ResultMessage updateVipBelong(TbVips entity) {
        ResultMessage msg = new ResultMessage();
        entity.setModTime(new Date()); //设置修改时间
        uTbVipsMapper.updateVipBelong(entity);

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Override
    public ResultMessage queryBankCard(String dealerId) {
        Map<String,String> map = new HashMap<String,String>();
        map.put("dealerId", dealerId);
        TbDealCard entity = uTbDealerCardMapper.findCard(map);
        if(entity != null){
            return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"查询成功" , entity);
        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"查询失败");
    }

    @Override
    public ResultMessage addDealerBankCard(TbDealCard entity) {
        uTbDealerCardMapper.insert(entity);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"绑定银行卡成功");
    }

    @Transactional(readOnly = false)
    @Override
    public ResultMessage updateDealerBankCard(TbDealCard entity) {
        uTbDealerCardMapper.updateDealerCard(entity);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"绑定银行卡成功");
    }

    @Override
    public ResultMessage queryDealerList() {
        ResultMessage msg = new ResultMessage();
        List<TbDealer> list = uTbDealerMapper.queryDealerList();
        if(list !=null && list.size()>0){
            msg.setData(list);
            msg.setLevel(ResultMessage.MSG_LEVEL.SUCC.v);
        }

        return msg;
    }


}
