package com.sojson.common.dao;

import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.TbPlayerDto;

import java.util.List;
import java.util.Map;

public interface UTbPlayerMapper {

    int insert(TbPlayer record);

    int updateByPrimaryKeySelective(TbPlayer record);

    List<TbPlayer> findAllNoPage(TbPlayerDto dto);

    List<TbPlayer> findAll(TbPlayerDto dto);
}