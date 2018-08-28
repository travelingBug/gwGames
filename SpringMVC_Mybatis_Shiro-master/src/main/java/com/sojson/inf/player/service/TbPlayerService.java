package com.sojson.inf.player.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.TbPlayerDto;

public interface TbPlayerService {

	public ResultMessage insert(TbPlayerDto dto);

	public ResultMessage updateByPrimaryKeySelective(TbPlayer record);

}
