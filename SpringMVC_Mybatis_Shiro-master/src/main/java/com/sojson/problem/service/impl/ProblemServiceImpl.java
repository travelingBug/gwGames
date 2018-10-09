package com.sojson.problem.service.impl;

import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbProblemMapper;
import com.sojson.common.model.TbProblem;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.problem.service.ProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.Map;

/**
 * Created by lx on 2018/8/27.
 */
@Service
public class ProblemServiceImpl extends BaseMybatisDao<UTbProblemMapper> implements ProblemService {

    @Autowired
    UTbProblemMapper uTbProblemMapper;

    @SuppressWarnings("unchecked")
    @Override
    public Pagination<TbProblem> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }

    @Override
    @Transactional
    public ResultMessage add(TbProblem tbProblem){
        tbProblem.setId(StringUtils.getUUID32());
        tbProblem.setCrtTime(new Date());
        uTbProblemMapper.insert(tbProblem);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    public TbProblem findById(String id){
        TbProblem tbProblem = uTbProblemMapper.findById(id);
        return tbProblem;
    }

    @Override
    @Transactional
    public ResultMessage update(TbProblem tbProblem){
        uTbProblemMapper.update(tbProblem);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }


    @Override
    @Transactional
    public ResultMessage deleteById(String id){
        uTbProblemMapper.deleteById(id);
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

}
