package com.sojson.common.dao;

import com.sojson.common.model.TbHomeConfig;

import java.util.List;

public interface UTbHomeConfigMapper {


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
    TbHomeConfig findById(String id);

    /**
     * 删除
     * @param id
     * @return
     */
    int deleteById(String id);

    List<TbHomeConfig> findAll(Object param);

}