package com.sojson.inf.vips.service.impl;

import com.sojson.common.IConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbDealerMapper;
import com.sojson.common.dao.UTbStopDateMapper;
import com.sojson.common.dao.UTbVipsMapper;
import com.sojson.common.model.TbDealer;
import com.sojson.common.model.TbStopDate;
import com.sojson.common.model.TbVips;
import com.sojson.common.service.CommonService;
import com.sojson.common.utils.MathUtil;
import com.sojson.common.utils.RedisUtil;
import com.sojson.common.utils.StringUtils;
import com.sojson.common.utils.WaterMarkUtil;
import com.sojson.core.config.IConfig;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.core.shiro.token.manager.TokenManager;
import com.sojson.inf.message.service.MessageService;
import com.sojson.inf.vips.service.VipsService;
import com.sojson.user.service.UUserService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * Created by lx on 2018/9/4.
 */
@Service
public class VipsServiceImpl extends BaseMybatisDao<UTbVipsMapper> implements VipsService {

    @Autowired
    UTbVipsMapper uTbVipsMapper;

    @Resource
    UUserService userService;

    @Autowired
    MessageService messageService;

    @Autowired
    UTbStopDateMapper uTbStopDateMapper;

    @Resource
    CommonService commonService;

    @Autowired
    UTbDealerMapper uTbDealerMapper;

    protected Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

//    RedisUtil redisUtil = RedisUtil.getRedis();

    @SuppressWarnings("unchecked")

    @Override
    public Pagination<TbVips> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {

        return super.findPage(resultMap, pageNo, pageSize);
    }

    @Override
    public ResultMessage update(TbVips entity, HttpServletRequest req) throws Exception{
        //数据验证
//        ResultMessage msg = beforeUpdateVaild(entity);
//        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {

            if(!entity.getPassword().equals("")) {
                String phone = commonService.getUserPhone(req);
                entity.setPassword(md5Pswd(phone, entity.getPassword()));
                entity.setPhone(phone);
            }else{
                new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "密码不能为空");
            }

            entity.setModTime(new Date()); //设置修改时间
            uTbVipsMapper.update(entity);
//        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Override
    public void updateLevelByDay() {
        uTbVipsMapper.updateLevelByDay();
    }

    @Override
    public ResultMessage validatePwd(String pwd, String phone) {
        TbVips entity = new TbVips();
        entity.setPassword(md5Pswd(phone, pwd));
        entity.setPhone(phone);
        TbVips vip = uTbVipsMapper.findUserByPhone(entity);
        if(null == vip){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "密码错误！");
        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Override
    public ResultMessage validInviteCode(String inviteCode) {
        TbDealer entity = uTbDealerMapper.findDealerByInviteCode(inviteCode);
        if(entity==null){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "推荐码不存在");
        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Transactional(readOnly = false)
    @Override
    public ResultMessage updatePwd(TbVips entity, HttpServletRequest req) throws Exception {

        //验证短信验证码
        String code = RedisUtil.get(entity.getPhone());
        if (StringUtils.isBlank(code)) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"未找到对应验证码！");
        }
        String[] codeArr = code.split(",");
        if (codeArr.length != 2 || !codeArr[0].equalsIgnoreCase(entity.getVerfiCode())) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"验证码错误！");
        }

        if(!entity.getPassword().equals("")) {
            String phone = entity.getPhone();
            entity.setPassword(md5Pswd(phone, entity.getPassword()));
        }else{
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "密码不能为空");
        }

        entity.setModTime(new Date()); //设置修改时间
        uTbVipsMapper.update(entity);

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Transactional
    @Override
    public ResultMessage insert(TbVips entity, HttpServletRequest req) {
        ResultMessage msg = beforeAddVaild(entity);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
            Date date = new Date();
            entity.setDelFlag(TbVips._0);
            entity.setCrtTime(date);
            entity.setPassword(md5Pswd(entity.getPhone(), entity.getPassword()));
            entity.setLevel(IConstant.VIP_LEVEL.VIP_0.v);//插入会员信息
            uTbVipsMapper.insert(entity);
            msg.setMessageText("注册成功！");

            String watermark = entity.getInviteCode();
            watermark = watermark.substring(0,3);
            watermark = watermark + String.format("%05d", entity.getId());
            String path = IConfig.get("qrCode_path_real");
            WaterMarkUtil.markImg(path+entity.getPhone()+".png",watermark);
            //删除redies缓存
            RedisUtil.delete(entity.getPhone());
        }else{
//            msg.setData("验证错误");
        }
        String userId = IConstant.TOKEN_PRE+StringUtils.getUUID32();
        RedisUtil.save(userId, entity.getPhone()+","+entity.getNickName());
        return new ResultMessage(msg.getLevel(), msg.getMessageText(), userId);
    }

    @Override
    public ResultMessage delete(String id) {
        uTbVipsMapper.delete(id);

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Override
    public ResultMessage login(TbVips entity, HttpServletRequest req) {
        String pwd = md5Pswd(entity.getPhone(), entity.getPassword());
        entity.setPassword(pwd);

        TbVips vip = uTbVipsMapper.findUserByPhone(entity);
        if(null == vip){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "电话号码或密码错误！");
        }
        //踢出之前登录的用户，单点登录
        Map<String,String> allKey = RedisUtil.getAll();
        if (allKey != null && allKey.size() > 0) {
            for (String key : allKey.keySet()) {
                //所有的登录token是以tk:开头的
                if (key.startsWith(IConstant.TOKEN_PRE)) {
                    //判断是不是同一个手机号
                    String value = RedisUtil.get(key);
                    if (value != null && vip.getPhone().equals(value.split(",")[0])) {
                        RedisUtil.delete(key);
                    }
                }
            }
        }
        String userId = IConstant.TOKEN_PRE+StringUtils.getUUID32();
        RedisUtil.save(userId,vip.getPhone()+","+vip.getNickName());
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "登录成功！", userId);
    }

    private ResultMessage beforeUpdateVaild(TbVips entity){
        //修改ID验证
        if (StringUtils.isBlank(entity.getPhone())) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"观众信息错误！");
        }

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }
    @Override
    public ResultMessage validPhone(String telPhone){
        TbVips entity = new TbVips();
        entity.setPhone(telPhone);
        TbVips vip = uTbVipsMapper.findUserByPhone(entity);
        if(null != vip){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "电话号码已经存在！");
        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    /**
     * 保存会员前验证
     * @param dto 会员信息
     * @return ResultMessage 返回结果
     */
    private ResultMessage beforeAddVaild(TbVips dto){

        //验证用户名
        if (StringUtils.isEmpty(dto.getNickName())
                || dto.getNickName().length() > 20) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"观众昵称必填且不能超过20个字符！");
        }

        //验证电话号码
        if (StringUtils.isEmpty(dto.getPhone())
                || dto.getPhone().length() > 20) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"手机号码必填且不能超过20个字符！");
        }

        //验证短信验证码

        String code = RedisUtil.get(dto.getPhone());
        if (StringUtils.isBlank(code)) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"未找到对应验证码！");
        }
        String[] codeArr = code.split(",");
        if (codeArr.length != 2 || !codeArr[0].equalsIgnoreCase(dto.getVerfiCode())) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"验证码错误！");
        }

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    public String md5Pswd(String phone, String pwd){
        //密码为   phone + '#' + pswd，然后MD5
        pwd = String.format("%s#%s",phone,pwd);
        pwd = MathUtil.getMD5(pwd);
        return pwd;
    }


    @Override
    public ResultMessage loginOut(String token) {
        try{
            RedisUtil.delete(token);
        }catch(Exception e){

        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Override
    public TbVips queryVipsInfo(String phone) {
        TbVips entity = new TbVips();
        entity.setPhone(phone);

        TbVips vip = uTbVipsMapper.findUserByPhone(entity);
        String endTimeStr = getSurplusTime(phone);
        vip.setEndTimeStr(endTimeStr);

        return vip;
    }


    @Override
    public String getSurplusTime(String phone){
        TbVips vip = new TbVips();
        vip.setPhone(phone);
        vip = uTbVipsMapper.findUserByPhone(vip);
        Integer surplusDay = vip.getSurplusDay();
//        if (surplusDay > 22) {
//            surplusDay = 22;
//        }
        if (surplusDay == null || vip.getLevel().byteValue() == IConstant.VIP_LEVEL.VIP_0.v) {
            surplusDay = 0;
        }
        //剩余时间
        String surplusTime = "剩余观赛时间："+surplusDay+"天 ";
        return surplusTime;
    }


    @Override
    public int updateSurplusDay(Map<String,Object> param){
        return uTbVipsMapper.updateSurplusDay(param);
    }

}
