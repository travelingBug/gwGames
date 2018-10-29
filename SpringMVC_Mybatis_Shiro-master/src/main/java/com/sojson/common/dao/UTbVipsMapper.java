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

    int updateLevelByEndTIme(Object param);

    String getSurplusMin(String phone);

    String getSurplusMin2(String phone);

    List<TbVips> findVipsAdmin(Map<String, Object> map);

    int findVipsAdminCount(Map<String, Object> map);
}