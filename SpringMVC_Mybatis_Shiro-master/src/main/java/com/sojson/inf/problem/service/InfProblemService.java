package com.sojson.inf.problem.service;


import com.sojson.common.model.TbEventReport;
import com.sojson.common.model.TbProblem;
import com.sojson.common.model.vo.TbEventReportVo;
import com.sojson.common.model.vo.TbProblemVo;
import com.sojson.core.mybatis.page.Pagination;

/**
 * 赛事报道
 */
public interface InfProblemService {

    /**
     * 赛事报道数据列表
     * @param pageNo
     * @param pageSize
     * @return
     */
    Pagination<TbProblem> findByPage(Integer pageNo,
                                     Integer pageSize);

    public TbProblemVo findById(String id);

}
