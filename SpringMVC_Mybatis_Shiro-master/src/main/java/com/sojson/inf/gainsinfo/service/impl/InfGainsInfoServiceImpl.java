package com.sojson.inf.gainsinfo.service.impl;

import com.sojson.common.IConstant;
import com.sojson.common.dao.UTbGainsInfoMapper;
import com.sojson.common.model.dto.PlayerTopInfo;
import com.sojson.common.model.vo.TbGainsInfoVo;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.inf.gainsinfo.service.InfGainsInfoService;
import com.sojson.inf.gainsinfo.utis.GainsInfoCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;

@Service
public class InfGainsInfoServiceImpl extends BaseMybatisDao<UTbGainsInfoMapper> implements InfGainsInfoService{



	@Override
	public List<PlayerTopInfo> getTopAll(int size){
		return GainsInfoCache.getTopAllForSize(size);
	}

	@Override
	public List<PlayerTopInfo> getTopMonth(int size){
		return GainsInfoCache.getTopMonthForSize(size);
	}

	@Override
	public List<PlayerTopInfo> getTopAllByMoney(int size){
		return GainsInfoCache.getTopAllByMoneyForSize(size);
	}








	public void getStrategy(String idCard){

	}
}
