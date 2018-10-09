package com.sojson.stopdate.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.TbStopDate;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.core.mybatis.page.Pagination;

import java.util.List;
import java.util.Map;

/**
 */
public interface StopDateService {

    TbStopDate findStopDate();


    ResultMessage update(TbStopDate tbStopDate);
}
