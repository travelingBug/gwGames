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

}