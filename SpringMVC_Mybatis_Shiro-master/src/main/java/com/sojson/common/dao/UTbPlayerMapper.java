package com.sojson.common.dao;

import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.UUser;
import com.sojson.permission.bo.URoleBo;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface UTbPlayerMapper {

    int insert(TbPlayer record);



    int updateByPrimaryKeySelective(TbPlayer record);


}