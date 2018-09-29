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
		//获取所有选手的数据
		List<TbGainsInfoVo> topInfos = uTbGainsInfoMapper.findTopForAll();
		//根据身份证统计每个人的信息
		List<PlayerTopInfo> palyerTopInfos = new ArrayList<PlayerTopInfo>();
		//保存已经存在的重复数据
		List<String> hasAccount = new ArrayList<String>();
		for (TbGainsInfoVo topInfo : topInfos) {
			//剔除重复数据
			if (hasAccount.contains(topInfo.getAccount())) {
				continue;
			}
			hasAccount.add(topInfo.getAccount());
			PlayerTopInfo playerTopInfo = new PlayerTopInfo();
			playerTopInfo.setAccountName(topInfo.getAccountName());
			playerTopInfo.setAccount(topInfo.getAccount());
			playerTopInfo.setTotalMoney(topInfo.getTotalMoney());
			playerTopInfo.setCapital(topInfo.getCapital());
			//计算收益率
			double totleDou = Double.parseDouble(topInfo.getTotalMoney());
			double capital = Double.parseDouble(String.valueOf(IConstant.capital));
			BigDecimal bg = new BigDecimal((totleDou - capital) * 100/capital);
			double rate = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			playerTopInfo.setYieldRate(rate + "");
			//持仓比

			//计算剩余金额
			double buyMoney = totleDou - Double.parseDouble(String.valueOf(topInfo.getBalanceMoney()));
			bg = new BigDecimal(buyMoney * 100/totleDou);
			rate = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			playerTopInfo.setBuyForALLRate(rate + "");
			palyerTopInfos.add(playerTopInfo);
		}
		Collections.sort(palyerTopInfos,Collections.reverseOrder());
		GainsInfoCache.putTopForAll(palyerTopInfos);
	}

	@Override
	public void findTopByMonth(String currDate,String preDate){
//		Map<String,Object> param = new HashMap<String,Object>();
//		param.put("currDate",currDate);
//		List<TbGainsInfoVo> cuurTopInfos = uTbGainsInfoMapper.findTopByMonth(param);
//		param.put("currDate",preDate);
//		List<TbGainsInfoVo> preTopInfos = uTbGainsInfoMapper.findTopByMonth(param);
//		//根据身份证统计每个人的信息
//		List<PlayerTopInfo> palyerTopMonthInfos = new ArrayList<PlayerTopInfo>();
//		//保存已经存在的重复数据
//		List<String> hasAccount = new ArrayList<String>();
//		for (TbGainsInfoVo cuurTopInfo : cuurTopInfos) {
//			//剔除重复数据
//			if (hasAccount.contains(cuurTopInfo.getAccount())) {
//				continue;
//			}
//			hasAccount.add(cuurTopInfo.getAccount());
//
//			PlayerTopInfo playerTopInfo = new PlayerTopInfo();
//			playerTopInfo.setAccountName(cuurTopInfo.getAccountName());
//			playerTopInfo.setAccount(cuurTopInfo.getAccount());
//			playerTopInfo.setTotalMoney(cuurTopInfo.getTotalMoney());
//			playerTopInfo.setCapital(cuurTopInfo.getCapital()); //默认先设置本金为当前本金，（因为初始化第一个月就是用本金）
//
//			//***********************************计算收益率
//			//找到上个月最后一条记录做为本金
//			for (TbGainsInfoVo preTopInfo : preTopInfos) {
//				if (preTopInfo.getAccount().equals(cuurTopInfo.getAccount())) {
//					//以上个月最后一天的资金做为本金计算收益
//					playerTopInfo.setCapital(preTopInfo.getTotalMoney());
//					break;
//				}
//			}
//			double getMoney = Double.parseDouble(topInfo.getGetMoney());
//			double capital = Double.parseDouble(topInfo.getCapital());
//			BigDecimal bg = new BigDecimal(getMoney/capital);
//			int rate = (int)(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() * 100);
//			playerTopInfo.setYieldRate(rate + "%");
//			//持仓比
//
//			double totleDou = Double.parseDouble(topInfo.getTotalMoney());
//			//剩余金额
//			double buyMoney = totleDou - Double.parseDouble(String.valueOf(topInfo.getBalanceMoney()));
//			bg = new BigDecimal(buyMoney/totleDou);
//			rate = (int)(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() * 100);
//			playerTopInfo.setBuyForALLRate(rate + "%");
//			palyerTopMonthInfos.add(playerTopInfo);
//		}
//		GainsInfoCache.putTopForMonth(palyerTopMonthInfos);
	}

	public void getStrategy(String idCard){

	}
}
