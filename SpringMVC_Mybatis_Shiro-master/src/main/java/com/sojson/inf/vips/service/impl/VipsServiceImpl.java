package com.sojson.inf.vips.service.impl;

import com.sojson.common.IConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbVipsMapper;
import com.sojson.common.model.TbVips;
import com.sojson.common.utils.MathUtil;
import com.sojson.common.utils.RedisUtil;
import com.sojson.common.utils.StringUtils;
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
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

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

    protected Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

    RedisUtil redisUtil = RedisUtil.getRedis();

    @SuppressWarnings("unchecked")

    @Override
    public Pagination<TbVips> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }

    @Override
    public ResultMessage update(TbVips entity) {
        //数据验证
        ResultMessage msg = beforeUpdateVaild(entity);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
            entity.setModTime(new Date()); //设置修改时间
            uTbVipsMapper.update(entity);
        }
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
            entity.setLevel(IConstant.VIP_LEVEL.VIP_0.v);
            //插入会员信息
            uTbVipsMapper.insert(entity);
            msg.setMessageText("注册成功！");
            //删除redies缓存
            redisUtil.delete(entity.getPhone());

            redisUtil.save(req.getSession().getId(), entity.getPhone());
        }else{
            msg.setLevel(ResultMessage.MSG_LEVEL.FAIL.v);
            msg.setMessageText("注册失败！");
        }

        return new ResultMessage(msg.getLevel(), msg.getMessageText(), req.getSession().getId());
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
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "登录成功！", req.getSession().getId());
    }

    private ResultMessage beforeUpdateVaild(TbVips entity){
        //修改ID验证
        if (StringUtils.isBlank(entity.getId())) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"会员信息错误！");
        }

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

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
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"会员昵称必填且不能超过20个字符！");
        }

        //验证电话号码
        if (StringUtils.isEmpty(dto.getPhone())
                || dto.getPhone().length() > 20) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"手机号码必填且不能超过20个字符！");
        }

        //验证短信验证码

        String code = redisUtil.get(dto.getPhone());
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


}