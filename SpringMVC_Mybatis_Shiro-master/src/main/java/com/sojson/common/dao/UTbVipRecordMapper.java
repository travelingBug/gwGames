package com.sojson.common.dao;


import com.sojson.common.model.vo.VipRecordCount;

import java.util.List;

public interface UTbVipRecordMapper {


    List<VipRecordCount> countByCode(Object map);

    List<VipRecordCount> countByEmployee(Object map);


}