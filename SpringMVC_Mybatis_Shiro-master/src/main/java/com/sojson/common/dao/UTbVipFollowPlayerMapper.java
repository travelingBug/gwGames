package com.sojson.common.dao;


import com.sojson.common.model.TbVipFollowPlayer;

import java.util.List;
import java.util.Map;

public interface UTbVipFollowPlayerMapper {

    List<TbVipFollowPlayer> findAll(Object param);

    public int deleteByVipPlayer(Map<String,Object> param);

    public int insert(TbVipFollowPlayer player);
}