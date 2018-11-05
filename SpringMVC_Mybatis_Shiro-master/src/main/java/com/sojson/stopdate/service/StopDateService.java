package com.sojson.stopdate.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.TbStopDate;
import com.sojson.common.model.TbVips;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.core.mybatis.page.Pagination;

import java.util.List;
import java.util.Map;

/**
 */
public interface StopDateService {

    List<TbStopDate> findStopDate();



    public ResultMessage insert(TbStopDate tbStopDate);

    public ResultMessage deleteById(Long id);

    public Pagination<TbVips> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize);
    public ResultMessage updateAudit(TbStopDate tbStopDate);
}
