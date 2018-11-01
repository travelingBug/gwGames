package com.sojson.common.dao;


import com.sojson.common.model.TbVipRecord;
import com.sojson.common.model.vo.VipRecordCount;

import java.util.List;
import java.util.Map;

public interface UTbVipRecordMapper {


    List<VipRecordCount> countByCode(Object map);

    List<VipRecordCount> countByEmployee(Object map);

    int addRecord(TbVipRecord record);

    List<TbVipRecord> findAllRecord(Map<String,Object> map);

    List<TbVipRecord> findAll(TbVipRecord entity);

    List<TbVipRecord> findByPageAdmin(Map<String, Object> map);

    List<TbVipRecord> findByPageDealer(Map<String, Object> map);

    List<TbVipRecord> findByPageEmployee(Map<String, Object> map);

    int findByPageAdminCount(Map<String, Object> map);

    int findByPageDealerCount(Map<String, Object> map);

    int findByPageEmployeeCount(Map<String, Object> map);

    List<VipRecordCount> countVipNum(Object map);

    List<TbVipRecord> findRecordByParam(Map<String, Object> map);
}