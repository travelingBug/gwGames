package com.sojson.inf.player.service.impl;

import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbPlayerMapper;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.inf.player.model.dto.TbPlayerDto;
import com.sojson.inf.player.service.TbPlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TbPlayerServiceImpl extends BaseMybatisDao<UTbPlayerMapper> implements TbPlayerService {
	@Autowired
	UTbPlayerMapper uTbPlayerMapper;


	@Override
	public ResultMessage insert(TbPlayerDto entity) {
		uTbPlayerMapper.insert(entity);
		return new ResultMessage();
	}

	@Override
	public ResultMessage updateByPrimaryKeySelective(TbPlayerDto entity) {
		uTbPlayerMapper.updateByPrimaryKeySelective(entity);
		return new ResultMessage();
	}

}
