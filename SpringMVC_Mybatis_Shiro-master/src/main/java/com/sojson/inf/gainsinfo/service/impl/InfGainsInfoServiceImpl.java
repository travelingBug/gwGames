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
public class InfGainsInfoServiceImpl extends BaseMybatisDao<UTbGainsInfoMapper> implements InfGainsInfoService {

	@Autowired
	UTbGainsInfoMapper uTbGainsInfoMapper;


	@Override
	public List<PlayerTopInfo> getTopAll(int size){
		return GainsInfoCache.getTopAllForSize(size);
	}

	@Override
	public List<PlayerTopInfo> getTopMonth(int size){
		return GainsInfoCache.getTopMonthForSize(size);
	}

	/**
	 * 获取总排行榜
	 */
	@Override
	public void getTopResultForAll(){
		//获取总榜前200排名的所有的数据
		List<TbGainsInfoVo> topInfos = uTbGainsInfoMapper.findTopForAll();
		//根据身份证统计每个人的信息
		List<PlayerTopInfo> palyerTopInfos = new ArrayList<PlayerTopInfo>();
		for (TbGainsInfoVo topInfo : topInfos) {
			PlayerTopInfo playerTopInfo = new PlayerTopInfo();
			playerTopInfo.setAccountName(topInfo.getAccountName());
			playerTopInfo.setIdCard(topInfo.getIdCard());
			playerTopInfo.setTotalMoney(topInfo.getTotalMoney());
			playerTopInfo.setCapital(String.valueOf(IConstant.capital));
			//计算收益率
			double totleDou = Double.parseDouble(topInfo.getTotalMoney());
			double capital = Double.parseDouble(String.valueOf(IConstant.capital));
			BigDecimal bg = new BigDecimal((totleDou - capital)/capital);
			int rate = (int)(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() * 100);
			playerTopInfo.setYieldRate(rate + "%");
			//持仓比

			//计算剩余金额
			double buyMoney = totleDou - Double.parseDouble(String.valueOf(topInfo.getBalanceMoney()));
			bg = new BigDecimal(buyMoney/totleDou);
			rate = (int)(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() * 100);
			playerTopInfo.setBuyForALLRate(rate + "%");
			palyerTopInfos.add(playerTopInfo);
		}
		GainsInfoCache.putTopForAll(palyerTopInfos);
	}

	@Override
	public void findTopByMonth(String currDate,String preDate){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("currDate",currDate);
		param.put("preDate",preDate);
		List<TbGainsInfoVo> topInfos = uTbGainsInfoMapper.findTopByMonth(param);
		//根据身份证统计每个人的信息
		List<PlayerTopInfo> palyerTopMonthInfos = new ArrayList<PlayerTopInfo>();
		for (TbGainsInfoVo topInfo : topInfos) {
			PlayerTopInfo playerTopInfo = new PlayerTopInfo();
			playerTopInfo.setAccountName(topInfo.getAccountName());
			playerTopInfo.setIdCard(topInfo.getIdCard());
			playerTopInfo.setTotalMoney(topInfo.getTotalMoney());
			playerTopInfo.setCapital(topInfo.getCapital());

			//计算收益率
			double getMoney = Double.parseDouble(topInfo.getGetMoney());
			double capital = Double.parseDouble(topInfo.getCapital());
			BigDecimal bg = new BigDecimal(getMoney/capital);
			int rate = (int)(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() * 100);
			playerTopInfo.setYieldRate(rate + "%");
			//持仓比

			double totleDou = Double.parseDouble(topInfo.getTotalMoney());
			//剩余金额
			double buyMoney = totleDou - Double.parseDouble(String.valueOf(topInfo.getBalanceMoney()));
			bg = new BigDecimal(buyMoney/totleDou);
			rate = (int)(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() * 100);
			playerTopInfo.setBuyForALLRate(rate + "%");
			palyerTopMonthInfos.add(playerTopInfo);
		}
		GainsInfoCache.putTopForMonth(palyerTopMonthInfos);
	}
}
