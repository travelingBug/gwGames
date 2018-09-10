package com.sojson.dealer.service.impl;

import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbDealerMapper;
import com.sojson.common.model.TbDealer;
import com.sojson.common.model.UUser;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.dealer.service.DealerService;
import com.sojson.user.manager.UserManager;
import com.sojson.user.service.UUserService;
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
public class DealerServiceImpl extends BaseMybatisDao<UTbDealerMapper> implements DealerService {

    @Autowired
    UTbDealerMapper uTbDealerMapper;

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
        //把密码md5
        userEntity = UserManager.md5Pswd(userEntity);
        //设置有效
        userEntity.setStatus(UUser._1);
        //新增user表数据
        userEntity = userService.insert(userEntity);
        //新增经销商
        entity.setUserId(userEntity.getId());
        uTbDealerMapper.insert(entity);
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
}
