package com.sojson.common.dao;

import com.sojson.common.model.TbStopDate;
import com.sojson.common.model.TbStopDateHis;
import com.sojson.common.model.URole;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface UTbStopDateMapper {
    List<TbStopDate> findAll(Map<String,Object> param);

    int update(TbStopDate tbStopDate);

    int insert(TbStopDate tbStopDate);

    /**
     * 删除
     * @param id
     * @return
     */
    int deleteById(Long id);
	
}