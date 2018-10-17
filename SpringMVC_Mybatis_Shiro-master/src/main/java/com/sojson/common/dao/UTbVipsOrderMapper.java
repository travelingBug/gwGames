package com.sojson.common.dao;


import com.sojson.common.model.TbVipsCard;
import com.sojson.common.model.TbVipsOrder;

import java.util.List;
import java.util.Map;

public interface UTbVipsOrderMapper {

    int insert(TbVipsOrder entity);

    List<TbVipsOrder> findList(Map<String, String> params);
}