package com.sojson.vips.service.impl;

import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbDealerMapper;
import com.sojson.common.dao.UTbVipsMapper;
import com.sojson.common.model.TbDealer;
import com.sojson.common.model.TbVips;
import com.sojson.common.model.UUser;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.dealer.service.DealerService;
import com.sojson.user.manager.UserManager;
import com.sojson.user.service.UUserService;
import com.sojson.vips.service.VipsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
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

    protected Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

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
    public ResultMessage insert(TbVips entity) {
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
        userEntity.setNickname(entity.getNickName());
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

//        String seatNum = "";
//        if(entity.getParentId().equals("0")) {
//            int count = uTbDealerMapper.queryDealerCount() + 1;
//            seatNum = String.format("%03d", count);
//        }else{
//            seatNum = uTbDealerMapper.getSeatNumByUserId(entity.getParentId());
//        }
//        String inviteNum = seatNum + userEntity.getId();
//
//        entity.setSeatNum(seatNum);
//        entity.setInviteNum(inviteNum);
//        uTbDealerMapper.insert(entity);
        userService.addRole2User(userEntity.getId(),entity.getRoleId());
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Override
    public ResultMessage delete(String id) {
        uTbVipsMapper.delete(id);

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    private ResultMessage beforeUpdateVaild(TbVips entity){
        //修改ID验证
        if (StringUtils.isBlank(entity.getId())) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"会员信息错误！");
        }

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

}
