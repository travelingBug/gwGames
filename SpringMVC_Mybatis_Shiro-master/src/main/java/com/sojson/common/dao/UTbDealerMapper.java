package com.sojson.common.dao;

import com.sojson.common.model.TbDealer;

public interface UTbDealerMapper {

    int insert(TbDealer record);

    int update(TbDealer record);

    void delete(String id);

    int queryDealerCount();

    String getSeatNumByUserId(String userId);
}