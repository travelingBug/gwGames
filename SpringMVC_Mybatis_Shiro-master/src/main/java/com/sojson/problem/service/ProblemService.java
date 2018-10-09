package com.sojson.problem.service;


import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbProblem;
import com.sojson.core.mybatis.page.Pagination;

import java.util.Map;

/**
 * 常见问题
 */
public interface ProblemService {

    /**
     * 常见问题数据列表
     * @param resultMap
     * @param pageNo
     * @param pageSize
     * @return
     */
    Pagination<TbProblem> findByPage(Map<String, Object> resultMap, Integer pageNo,
                                     Integer pageSize);

    public ResultMessage add(TbProblem tbProblem);


    public TbProblem findById(String id);


    public ResultMessage update(TbProblem tbProblem);


    public ResultMessage deleteById(String id);
}
