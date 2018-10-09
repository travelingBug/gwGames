package com.sojson.common.dao;

import com.sojson.common.model.TbStopDate;
import com.sojson.common.model.TbStopDateHis;
import com.sojson.common.model.URole;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface UTbStopDateMapper {
    List<TbStopDate> findAll();

    int update(TbStopDate tbStopDate);

    int insertHis(TbStopDateHis tbStopDateHis);
	
}