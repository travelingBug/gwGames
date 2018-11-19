package com.sojson.inf.gainsinfo.service.impl;

import com.sojson.common.IConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbGainsInfoMapper;
import com.sojson.common.dao.UTbPlayerMoneyMapper;
import com.sojson.common.dao.UTbTopByMonthMapper;
import com.sojson.common.dao.UTbVipFollowPlayerMapper;
import com.sojson.common.model.TbTopByMonth;
import com.sojson.common.model.TbVipFollowPlayer;
import com.sojson.common.model.dto.PlayerTopInfo;
import com.sojson.common.model.vo.TbGainsInfoVo;
import com.sojson.common.model.vo.TbPlayerMoneyVo;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.gainsinfo.service.GainsInfoService;
import com.sojson.inf.gainsinfo.service.InfGainsInfoService;
import com.sojson.inf.gainsinfo.utis.GainsInfoCache;
import com.sojson.topbymonth.service.TopByMonthService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.*;

@Service
public class InfGainsInfoServiceImpl extends BaseMybatisDao<UTbGainsInfoMapper> implements InfGainsInfoService{


	@Resource
	UTbGainsInfoMapper uTbGainsInfoMapper;

	@Resource
	UTbPlayerMoneyMapper uTbPlayerMoneyMapper;

	@Resource
	UTbVipFollowPlayerMapper uTbVipFollowPlayerMapper;

	@Resource
	GainsInfoService gainsInfoService;

	@Resource
	UTbTopByMonthMapper uTbTopByMonthMapper;

	@Resource
	TopByMonthService topByMonthService;

	@Override
	public List<PlayerTopInfo> getTopAll(int size){
		return GainsInfoCache.getTopAllForSize(size);
	}

	@Override
	public Pagination<PlayerTopInfo> getTopAllByPage(int pageSize,int pageNo){
		Pagination<PlayerTopInfo> page = new Pagination<PlayerTopInfo>(pageNo, pageSize,GainsInfoCache.getTopAllSize(), GainsInfoCache.getTopAllByPage(pageSize,pageNo));
		return page;
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
	public Pagination<PlayerTopInfo> getTopMonthByPage(int pageSize,int pageNo){
		Pagination<PlayerTopInfo> page = new Pagination<PlayerTopInfo>(pageNo, pageSize,GainsInfoCache.getTopMonthSize(), GainsInfoCache.getTopMonthByPage(pageSize,pageNo));
		return page;
	}

	@Override
	public ResultMessage getPlayerInfo(String account,String dataTime){
		ResultMessage msg = new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
		PlayerTopInfo playerTopInfo = GainsInfoCache.getPlayer4account(account);
		if (playerTopInfo == null){
			return new ResultMessage(ResultMessage.MSG_LEVEL.HINT.v,"错误的选手信息!");
		}
		playerTopInfo.setDataTime(dataTime);
		msg.setData(playerTopInfo);

		return msg;
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
			int volume = vo.getVolume();
			if (vo.getBusinessFlag() == IConstant.BUSINESS_FLAG.BOND_SELL.v
					|| vo.getBusinessFlag() == IConstant.BUSINESS_FLAG.FUND_SELL.v) { //卖出
				volume = volume * -1;
			}
			vo.setVolume(volume);
			if (strategyMap.get(vo.getSharesCode()) == null) {
				strategyMap.put(vo.getSharesCode(), vo);
			} else {
				strategyMap.get(vo.getSharesCode()).setVolume(strategyMap.get(vo.getSharesCode()).getVolume() + volume);

			}
		}
		List<TbGainsInfoVo> showGainsInfos = new ArrayList<TbGainsInfoVo>();
		for (TbGainsInfoVo vo : strategyMap.values()) {
			if (vo.getVolume() > 0 ){
				showGainsInfos.add(vo);
			}
		}
		return showGainsInfos;
	}

	@Override
	public Pagination<TbGainsInfoVo> getTransactionInfo(String account, String endTime,Integer pageNo, Integer pageSize){
		ResultMessage msg = new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("account",account);
		param.put("endTime",endTime);
		return gainsInfoService.findByPage(param,pageNo,pageSize);
	}

	@Override
	public TbPlayerMoneyVo getPlayerMoney4Account(String account,String vipPhone, String endTime){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("account",account);
		param.put("endTime",endTime);
		List<TbPlayerMoneyVo> vos = uTbPlayerMoneyMapper.findAll(param);
		param.remove("endTime");
		param.put("vipPhone",vipPhone);
		List<TbVipFollowPlayer> follows = uTbVipFollowPlayerMapper.findAll(param);
		TbPlayerMoneyVo vo = vos.get(0);
		if (follows.size() > 0) {
			vo.setIsFollow(IConstant.YES_OR_NO.YES.v);
		}
		vo.setBusinessTimeStr(endTime);
		return vo;

	}

	/**
	 * 添加关注
	 * @param tbVipFollowPlayer
	 * @return
	 */
	@Override
	public ResultMessage addFollow(TbVipFollowPlayer tbVipFollowPlayer){
		List<TbVipFollowPlayer> follows = uTbVipFollowPlayerMapper.findAll(tbVipFollowPlayer);
		if (follows.size() > 0) {
			return new ResultMessage(ResultMessage.MSG_LEVEL.HINT.v,"此选手已经关注过了");
		}
		uTbVipFollowPlayerMapper.insert(tbVipFollowPlayer);
		return  new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"关注成功!");
	}

	/**
	 * 取消关注
	 * @param tbVipFollowPlayer
	 * @return
	 */
	@Override
	public ResultMessage cancelFollow(TbVipFollowPlayer tbVipFollowPlayer){
		List<TbVipFollowPlayer> follows = uTbVipFollowPlayerMapper.findAll(tbVipFollowPlayer);
		if (follows.size() <= 0) {
			return new ResultMessage(ResultMessage.MSG_LEVEL.HINT.v,"此选手不再关注列表！");
		}
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("account",tbVipFollowPlayer.getAccount());
		param.put("vipPhone",tbVipFollowPlayer.getVipPhone());
		uTbVipFollowPlayerMapper.deleteByVipPlayer(param);
		return  new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"取消关注成功!");

	}

	/**
	 * 获取历史月度冠军的月份
	 * @return
	 */
	@Override
	public List<String> getMonths(){
		return uTbTopByMonthMapper.getMonths();
	}

	/**
	 * 根据月份查询出历史月份的比赛排名
	 * @param month
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	public Pagination<TbTopByMonth>  getTopMonthHisByPage(String month, int pageSize, int pageNo ){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("month",month);
		return topByMonthService.findByPage(param, pageNo, pageSize);
	}

	@Override
	public Pagination<PlayerTopInfo> getTopAllByAccount(String phone,int pageSize, int pageNo) {
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("vipPhone", phone);

		List<PlayerTopInfo> allFollowPlayerTops = new ArrayList<PlayerTopInfo>();
		List<TbVipFollowPlayer> followPlayers = uTbVipFollowPlayerMapper.findAll(params);
		List<PlayerTopInfo> allPlayerTops = GainsInfoCache.getTopAllForSize(GainsInfoCache.getTopAllSize());
		for(int i=0; i<followPlayers.size(); i++){
			for(int j=0; j<allPlayerTops.size(); j++){
				if(followPlayers.get(i).getAccount().equals(allPlayerTops.get(j).getAccount())){
					allFollowPlayerTops.add(allPlayerTops.get(i));
				}
			}
		}
		Pagination<PlayerTopInfo> page = new Pagination<PlayerTopInfo>(pageNo, pageSize,followPlayers.size(), GainsInfoCache.getTopAllByAccount(allFollowPlayerTops,pageSize,pageNo));
		return page;
	}


	@Override
	public List<PlayerTopInfo> getLastTopMonth(int size){
		List<PlayerTopInfo> last = new ArrayList<PlayerTopInfo>();
		List<PlayerTopInfo> data = GainsInfoCache.getLastTopMonthSize(size);

		int frist = 166;
		//顺序倒着获取
		for (int i = data.size() - 1; i >= 0; i--) {
			PlayerTopInfo playerTopInfo = data.get(i).clone();
			playerTopInfo.setRank(frist);
			playerTopInfo.setAccount("******");
			playerTopInfo.setAccountName("****");
			last.add(playerTopInfo);
			frist ++;
		}

		return last;
	}

	@Override
	public List<PlayerTopInfo> getLastTopAll(int size){
		List<PlayerTopInfo> last = new ArrayList<PlayerTopInfo>();
		List<PlayerTopInfo> data = GainsInfoCache.getLastTopAllForSize(size);

		int frist = 166;
		//顺序倒着获取
		for (int i = data.size() - 1; i >= 0; i--) {
			PlayerTopInfo playerTopInfo = data.get(i).clone();
			playerTopInfo.setRank(frist);
			playerTopInfo.setAccount("******");
			playerTopInfo.setAccountName("****");
			last.add(playerTopInfo);
			frist ++;
		}

		return last;
	}
}
