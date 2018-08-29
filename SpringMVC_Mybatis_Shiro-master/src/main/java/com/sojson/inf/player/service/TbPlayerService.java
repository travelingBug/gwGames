package com.sojson.inf.player.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.TbPlayerDto;

import java.util.List;
import java.util.Map;

public interface TbPlayerService {

	public ResultMessage insert(TbPlayerDto dto);

	public ResultMessage updateByPrimaryKeySelective(TbPlayer record);

	/**
	 * 根据查询条件获取到参赛选手信息
	 * @param dto 查询条件
	 * @return
	 */
	public List<TbPlayer> findAllNoPage(TbPlayerDto dto);
}
