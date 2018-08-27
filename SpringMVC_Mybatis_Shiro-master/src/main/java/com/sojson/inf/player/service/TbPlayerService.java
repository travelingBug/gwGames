package com.sojson.inf.player.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbPlayer;

public interface TbPlayerService {

	public ResultMessage insert(TbPlayer entity);

	public ResultMessage updateByPrimaryKeySelective(TbPlayer record);

}
