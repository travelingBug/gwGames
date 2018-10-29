package com.sojson.dealer.service;

import com.sojson.common.model.TbVipRecord;
import com.sojson.common.model.TbVips;
import com.sojson.core.mybatis.page.Pagination;

import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
public interface VipsListService {
    Pagination<TbVips> findByPage(Map<String, Object> resultMap, Integer pageNo,
                                  Integer pageSize);

    Pagination<TbVips> findByPageAdmin(Map<String, Object> resultMap, Integer pageNo,
                                            Integer pageSize);

}
