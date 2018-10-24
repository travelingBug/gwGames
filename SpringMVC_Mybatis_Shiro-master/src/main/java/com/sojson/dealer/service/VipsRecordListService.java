package com.sojson.dealer.service;

import com.sojson.common.model.TbVipRecord;
import com.sojson.core.mybatis.page.Pagination;

import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
public interface VipsRecordListService {
    Pagination<TbVipRecord> findByPage(Map<String, Object> resultMap, Integer pageNo,
                                       Integer pageSize);

    Pagination<TbVipRecord> findByPageAdmin(Map<String, Object> resultMap, Integer pageNo,
                                       Integer pageSize);

    Pagination<TbVipRecord> findByPageDealer(Map<String, Object> resultMap, Integer pageNo,
                                       Integer pageSize);

    Pagination<TbVipRecord> findByPageEmployee(Map<String, Object> resultMap, Integer pageNo,
                                       Integer pageSize);

}
