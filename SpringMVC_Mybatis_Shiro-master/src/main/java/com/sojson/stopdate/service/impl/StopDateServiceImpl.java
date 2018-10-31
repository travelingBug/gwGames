package com.sojson.stopdate.service.impl;

import com.sojson.common.IConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbPlayerMapper;
import com.sojson.common.dao.UTbStopDateMapper;
import com.sojson.common.dao.UTbVipsMapper;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.TbStopDate;
import com.sojson.common.model.TbStopDateHis;
import com.sojson.common.model.TbVips;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.core.shiro.token.manager.TokenManager;
import com.sojson.player.service.PlayerService;
import com.sojson.stopdate.service.StopDateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2018/8/27.
 */
@Service
public class StopDateServiceImpl extends BaseMybatisDao<UTbStopDateMapper> implements StopDateService {

    @Autowired
    UTbStopDateMapper uTbStopDateMapper;

    @Resource
    UTbVipsMapper uTbVipsMapper;


    @Override
    public List<TbStopDate> findStopDate() {
        List<TbStopDate> vos = uTbStopDateMapper.findAll(new HashMap<String,Object>());
        return vos;
    }

    @Override
    public ResultMessage insert(TbStopDate tbStopDate){
        tbStopDate.setUserId(TokenManager.getUserId());
        tbStopDate.setUserName(TokenManager.getNickname());
        tbStopDate.setCrtTime(new Date());
        uTbStopDateMapper.insert(tbStopDate);

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"添加成功!");
    }

    @Override
    public ResultMessage deleteById(Long id){
        uTbStopDateMapper.deleteById(id);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"删除成功!");
    }

    @Override
    public Pagination<TbVips> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }
}
