package com.sojson.inf.gainsinfo.service.impl;

import com.sojson.common.IConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbGainsInfoMapper;
import com.sojson.common.model.dto.PlayerTopInfo;
import com.sojson.common.model.vo.TbGainsInfoVo;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.gainsinfo.service.GainsInfoService;
import com.sojson.inf.gainsinfo.service.InfGainsInfoService;
import com.sojson.inf.gainsinfo.utis.GainsInfoCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.*;

@Service
public class InfGainsInfoServiceImpl extends BaseMybatisDao<UTbGainsInfoMapper> implements InfGainsInfoService{


	@Resource
	UTbGainsInfoMapper uTbGainsInfoMapper;

	@Resource
	GainsInfoService gainsInfoService;

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

	@Override
	public Collection<TbGainsInfoVo> getStrategy(String account, String endTime){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("account",account);
		param.put("endTime",endTime);
		List<TbGainsInfoVo> gainsInfoVos = uTbGainsInfoMapper.findAll(param);
		//key是股票代码
		Map<String, TbGainsInfoVo> strategyMap = new HashMap<String, TbGainsInfoVo>();
		for (TbGainsInfoVo vo : gainsInfoVos) {
			if (strategyMap.get(vo.getSharesCode()) == null) {
				strategyMap.put(vo.getSharesCode(), vo);
			} else {
				if (vo.getBusinessFlag() == IConstant.BUSINESS_FLAG.BOND_BUY.v
						|| vo.getBusinessFlag() == IConstant.BUSINESS_FLAG.FUND_BUY.v) { //买入
					strategyMap.get(vo.getSharesCode()).setVolume(strategyMap.get(vo.getSharesCode()).getVolume() + vo.getVolume());
				} else if (vo.getBusinessFlag() == IConstant.BUSINESS_FLAG.BOND_SELL.v
						|| vo.getBusinessFlag() == IConstant.BUSINESS_FLAG.FUND_SELL.v) { //卖出
					strategyMap.get(vo.getSharesCode()).setVolume(strategyMap.get(vo.getSharesCode()).getVolume() - vo.getVolume());
				}
			}
		}

		return strategyMap.values();
	}

	public Pagination<TbGainsInfoVo> getTransactionInfo(String account, String endTime,Integer pageNo, Integer pageSize){
		ResultMessage msg = new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("account",account);
		param.put("endTime",endTime);
		return gainsInfoService.findByPage(param,pageNo,pageSize);
	}
}
