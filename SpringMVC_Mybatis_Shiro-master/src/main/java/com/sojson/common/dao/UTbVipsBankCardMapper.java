package com.sojson.common.dao;


import com.sojson.common.model.TbVipsCard;

import java.util.List;

public interface UTbVipsBankCardMapper {

    int insert(TbVipsCard entity);

    void delete(String id);

    List<TbVipsCard> findList(String phone);
}