package com.sojson.common.dao;


import com.sojson.common.model.TbVipsCard;

import java.util.List;
import java.util.Map;

public interface UTbVipsBankCardMapper {

    int insert(TbVipsCard entity);

    void delete(String cardNo);

    List<TbVipsCard> findList(Map<String,String> params);
}