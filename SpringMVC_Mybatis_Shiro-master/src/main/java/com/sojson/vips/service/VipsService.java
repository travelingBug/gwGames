package com.sojson.vips.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbDealer;
import com.sojson.common.model.TbVips;
import com.sojson.core.mybatis.page.Pagination;

import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
public interface VipsService {
    Pagination<TbVips> findByPage(Map<String, Object> resultMap, Integer pageNo,
                                  Integer pageSize);

    ResultMessage update(TbVips entity);

    ResultMessage insert(TbVips entity);

    ResultMessage delete(String id);
}
