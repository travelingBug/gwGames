package com.sojson.common.dao;

import com.sojson.common.model.TbPlayer;

public interface UTbPlayerMapper {

    int insert(TbPlayer record);

    int updateByPrimaryKeySelective(TbPlayer record);

}