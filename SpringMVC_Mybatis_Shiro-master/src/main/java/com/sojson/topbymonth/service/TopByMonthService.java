package com.sojson.topbymonth.service;


import com.sojson.common.model.TbTopByMonth;
import com.sojson.core.mybatis.page.Pagination;

import java.util.Map;

/**
 * 月度赛
 */
public interface TopByMonthService {

    public Pagination<TbTopByMonth> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize);

    public void insertTopMonth(String currDate,String preDate);
}
