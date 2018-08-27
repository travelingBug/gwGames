package com.sojson.player.service.impl;

import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbPlayerMapper;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.player.service.PlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Map;

/**
 * Created by lx on 2018/8/27.
 */
@Service
public class PlayerServiceImpl extends BaseMybatisDao<UTbPlayerMapper> implements PlayerService{

    @Autowired
    UTbPlayerMapper uTbPlayerMapper;
    /**
     * 根据会员ID修改会员信息
     * @param entity 会员信息
     * @return
     */
    @Override
    public ResultMessage updateByPrimaryKeySelective(TbPlayer entity) {
        //数据验证
        ResultMessage msg = beforeUpdateVaild(entity);
        if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
            entity.setModTime(new Date()); //设置修改时间
            uTbPlayerMapper.updateByPrimaryKeySelective(entity);
            msg.setMessageText("修改成功！");
        }
        return new ResultMessage();
    }

    private ResultMessage beforeUpdateVaild(TbPlayer entity){
        //修改ID验证
        if (StringUtils.isBlank(entity.getId())) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"参赛人员信息错误！");
        }

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @SuppressWarnings("unchecked")
    @Override
    public Pagination<TbPlayer> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }
}
