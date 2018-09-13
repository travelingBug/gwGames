package com.sojson.common.dao;

import com.sojson.common.model.TbGainsInfo;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.TbPlayerDto;

import java.util.List;

public interface UTbGainsInfoMapper {

    /**
     * 批量插入
     * @param list
     * @return
     */
    int insertBatch(List<TbGainsInfo> list);
}