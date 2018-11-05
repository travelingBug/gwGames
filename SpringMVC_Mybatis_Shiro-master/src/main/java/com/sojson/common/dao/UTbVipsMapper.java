package com.sojson.common.dao;


import com.sojson.common.model.TbVipRecord;
import com.sojson.common.model.TbVips;

import java.util.List;
import java.util.Map;

public interface UTbVipsMapper {

    int insert(TbVips record);

    int update(TbVips record);

    void delete(String id);

    TbVips findUserByPhone(TbVips entity);

    byte getLevelByPhone(String phone);

    int updateEndTimeByStop();

    int updateLevelByDay();

    String getSurplusMin(String phone);

    String getSurplusMin2(String phone);

    List<TbVips> findVipsAdmin(Map<String, Object> map);

    int findVipsAdminCount(Map<String, Object> map);

    List<TbVips> findVipsDealer(Map<String, Object> map);

    int findVipsDealerCount(Map<String, Object> map);

    List<TbVips> findByPageEmployee(Map<String, Object> map);

    int findByPageEmployeeCount(Map<String, Object> map);

    int updateSurplusDay(Map<String,Object> param);

    List<TbVips> findAll(Map<String,Object> param);

    List<TbVips>  findVipByDealerId(Map<String, Object> map);
    int updateSurplusDay();

    int updateVipBelong(TbVips entity);
}