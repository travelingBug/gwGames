package com.sojson.dealer.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbDealer;
import com.sojson.core.mybatis.page.Pagination;

import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
public interface DealerService {
    Pagination<TbDealer> findByPage(Map<String, Object> resultMap, Integer pageNo,
                                    Integer pageSize);

    ResultMessage update(TbDealer entity);
}
