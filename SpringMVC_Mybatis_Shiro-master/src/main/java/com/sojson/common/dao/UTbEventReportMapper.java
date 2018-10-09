package com.sojson.common.dao;

import com.sojson.common.model.TbEventReport;

public interface UTbEventReportMapper {


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
    TbEventReport findById(String id);

    /**
     * 删除
     * @param id
     * @return
     */
    int deleteById(String id);

}