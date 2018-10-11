package com.sojson.inf.problem.service.impl;

import com.sojson.common.dao.UTbEventReportMapper;
import com.sojson.common.dao.UTbProblemMapper;
import com.sojson.common.model.TbEventReport;
import com.sojson.common.model.TbProblem;
import com.sojson.common.model.vo.TbEventReportVo;
import com.sojson.common.model.vo.TbProblemVo;
import com.sojson.common.utils.DateUtil;
import com.sojson.core.config.IConfig;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.inf.eventreport.service.EventReportService;
import com.sojson.inf.problem.service.InfProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by lx on 2018/8/27.
 */
@Service
public class InfProblemServiceImpl extends BaseMybatisDao<UTbProblemMapper> implements InfProblemService {

    @Autowired
    UTbProblemMapper uTbProblemMapper;

    @SuppressWarnings("unchecked")
    @Override
    public Pagination<TbProblem> findByPage(Integer pageNo, Integer pageSize) {
        Map<String,Object> resultMap = new HashMap<String,Object>();
        Pagination<TbProblem> page = super.findPage(resultMap, pageNo, pageSize);
        return page;
    }


    @Override
    public TbProblemVo findById(String id){
        TbProblem tbProblem =  uTbProblemMapper.findById(id);
        TbProblemVo vo = new TbProblemVo();
        vo.setCrtTime(tbProblem.getCrtTime());
        vo.setProblem(tbProblem.getProblem());
        vo.setAnswer(tbProblem.getAnswer());
        vo.setCrtTimeStr(DateUtil.dateToString(vo.getCrtTime(),DateUtil.DATETIME_PATTERN));
        return vo;
    }




}
