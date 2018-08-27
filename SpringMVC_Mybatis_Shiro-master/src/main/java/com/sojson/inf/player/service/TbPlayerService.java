package com.sojson.inf.player.service;

import com.sojson.common.ResultMessage;
import com.sojson.inf.player.model.dto.TbPlayerDto;

public interface TbPlayerService {

	public ResultMessage insert(TbPlayerDto entity);

	public ResultMessage updateByPrimaryKeySelective(TbPlayerDto record);

}
