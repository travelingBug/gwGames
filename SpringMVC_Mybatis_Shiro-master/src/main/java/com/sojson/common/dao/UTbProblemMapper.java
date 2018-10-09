package com.sojson.common.dao;

import com.sojson.common.model.TbProblem;

public interface UTbProblemMapper {


    /**
     * 添加
     * @param report
     * @return
     */
    int insert(Object report);

    /**
     * 修改
     * @param report
     * @return
     */
    int update(Object report);

    /**
     * 查询详情
     * @param id
     * @return
     */
    TbProblem findById(String id);

    /**
     * 删除
     * @param id
     * @return
     */
    int deleteById(String id);

}