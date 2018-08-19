package com.sojson.common.dao;

import com.sojson.common.model.UUser;
import com.sojson.permission.bo.URoleBo;

import java.util.List;
import java.util.Map;


public interface UTbPlayerMapper {

    int insert(UUser record);



    int updateByPrimaryKeySelective(UUser record);


}