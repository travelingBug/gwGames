package com.sojson.common.dao;

import com.sojson.common.model.TbDealer;
import com.sojson.common.model.URole;

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

    TbDealer findDealerByInviteCode(String telPhone);

    TbDealer findDealerBySeatNum(String seatNum);

    String queryUserType(String userId);

    String queryMoney(String userId);

    List<TbDealer> queryEmployeeList(String inviteCode);

    List<TbDealer> queryDealerList();

    String queryDealerStatus(String userId);

    URole queryRoleByUserId(String userId);
}