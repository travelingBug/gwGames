package com.sojson.common.dao;


import com.sojson.common.model.TbTopByMonth;
import com.sojson.common.model.TbVipFollowPlayer;

import java.util.List;
import java.util.Map;

public interface UTbTopByMonthMapper {

    List<TbTopByMonth> findAll(Object param);

    public int insert(TbVipFollowPlayer player);

    /**
     * 批量插入
     * @param list
     * @return
     */
    int insertBatch(List<TbTopByMonth> list);

    /**
     * 获取月份的统计
     * @return
     */
    List<String> getMonths();
}