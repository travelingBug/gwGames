package com.sojson.common.dao;

import com.sojson.common.model.TbDealer;

import java.util.List;

public interface UTbDealerMapper {

    int insert(TbDealer record);

    int update(TbDealer record);

    void delete(String id);

    int queryDealerCount();

    String getSeatNumByUserId(String userId);

    List<TbDealer> findAll(Object param);

    TbDealer findDealerByUserId(Long userId);

    TbDealer findDealerByPhone(String telPhone);
}