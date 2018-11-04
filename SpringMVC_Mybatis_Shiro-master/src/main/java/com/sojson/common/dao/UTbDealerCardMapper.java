package com.sojson.common.dao;


import com.sojson.common.model.TbDealCard;
import com.sojson.common.model.TbVipsCard;

import java.util.List;
import java.util.Map;

public interface UTbDealerCardMapper {

    int insert(TbDealCard entity);

    void updateDealerCard(TbDealCard entity);

    TbDealCard findCard(Map<String, String> params);
}