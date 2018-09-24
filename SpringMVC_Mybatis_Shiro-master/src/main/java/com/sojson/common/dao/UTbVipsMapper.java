package com.sojson.common.dao;

import com.sojson.common.model.TbDealer;
import com.sojson.common.model.TbVips;

public interface UTbVipsMapper {

    int insert(TbVips record);

    int update(TbVips record);

    void delete(String id);
}