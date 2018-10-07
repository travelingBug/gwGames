package com.sojson.inf.gainsinfo.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.TbTopByMonth;
import com.sojson.common.model.TbVipFollowPlayer;
import com.sojson.common.model.dto.PlayerTopInfo;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.common.model.vo.TbGainsInfoVo;
import com.sojson.common.model.vo.TbPlayerMoneyVo;
import com.sojson.common.service.CommonService;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.inf.gainsinfo.service.InfGainsInfoService;
import com.sojson.inf.player.service.TbPlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collection;
import java.util.List;


@Controller
@Scope(value="prototype")
@RequestMapping("interface/gainsInfo")
public class InfGainsInfoController extends BaseController {

	@Autowired
	InfGainsInfoService infGainsInfoService;

	@Resource
	CommonService commonService;

	@RequestMapping(value="getTopAll",method=RequestMethod.POST)
	@ResponseBody
	public List<PlayerTopInfo> getTopAll(int size){
		return infGainsInfoService.getTopAll(size);
	}

	@RequestMapping(value="getTopAllByPage",method=RequestMethod.POST)
	@ResponseBody
	public Pagination<PlayerTopInfo> getTopAllByPage(Integer pageSize,Integer pageNo){
		if (pageSize == null || pageSize <= 0) {
			pageSize = 10;
		}
		if (pageNo == null || pageNo <= 0) {
			pageNo = 1;
		}
		return infGainsInfoService.getTopAllByPage(pageSize,pageNo);
	}

	@RequestMapping(value="getTopMonth",method=RequestMethod.POST)
	@ResponseBody
	public List<PlayerTopInfo> getTopMonth(int size){

		return infGainsInfoService.getTopMonth(size);
	}

	@RequestMapping(value="getTopMonthByPage",method=RequestMethod.POST)
	@ResponseBody
	public Pagination<PlayerTopInfo> getTopMonthByPage(Integer pageSize,Integer pageNo){
		if (pageSize == null || pageSize <= 0) {
			pageSize = 10;
		}
		if (pageNo == null || pageNo <= 0) {
			pageNo = 1;
		}
		return infGainsInfoService.getTopMonthByPage(pageSize,pageNo);
	}

	@RequestMapping(value="getTopAllByMoney",method=RequestMethod.POST)
	@ResponseBody
	public List<PlayerTopInfo> getTopAllByMoney(int size){
		return infGainsInfoService.getTopAllByMoney(size);
	}



	@RequestMapping(value="getStrategy",method=RequestMethod.POST)
	@ResponseBody
	public ResultMessage getStrategy(HttpServletRequest request,String account) throws Exception {
		ResultMessage msg = new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
			String endTime = commonService.getTimeByToken(request);
			if (endTime == null) {
				msg = new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"您还未购买观赛券，请购买后再进行观赛!");
			} else {
				Collection<TbGainsInfoVo> datas = infGainsInfoService.getStrategy(account,endTime);
				msg.setData(datas);
			}
		return msg;
	}

	@RequestMapping(value="getTransactionInfo",method=RequestMethod.POST)
	@ResponseBody
	public ResultMessage getTransactionInfo(HttpServletRequest request,String account, Integer pageNo) throws Exception{
		ResultMessage msg = new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
			String endTime = commonService.getTimeByToken(request);
			if (endTime == null) {
				msg = new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"您还未购买观赛券，请购买后再进行观赛!");
			} else {
				Pagination<TbGainsInfoVo> datas = infGainsInfoService.getTransactionInfo(account,endTime, pageNo, pageSize);
				msg.setData(datas);
			}
		return msg;
	}

	@RequestMapping(value="validLevel",method=RequestMethod.POST)
	@ResponseBody
	public ResultMessage validLevel(HttpServletRequest request) throws Exception{
		ResultMessage msg = new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
			String endTime = commonService.getTimeByToken(request);
			if (endTime == null) {
				msg = new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"您还未购买观赛券，请购买后再进行观赛!");
			}
		return msg;
	}


	@RequestMapping(value="getPlayerMoney4Account",method=RequestMethod.POST)
	@ResponseBody
	public ResultMessage getPlayerMoney4Account(HttpServletRequest request,String account) throws Exception{
		ResultMessage msg = new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
		String endTime = commonService.getTimeByToken(request);
		String phone = commonService.getUserPhone(request);
		if (endTime == null) {
			msg = new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"您还未购买观赛券，请购买后再进行观赛!");
		} else {
			TbPlayerMoneyVo data = infGainsInfoService.getPlayerMoney4Account(account,phone,endTime);
			msg.setData(data);
		}
		return msg;
	}

	@RequestMapping(value="addfollow",method=RequestMethod.POST)
	@ResponseBody
	public ResultMessage addfollow(HttpServletRequest request, TbVipFollowPlayer tbVipFollowPlayer) throws Exception{
		String phone = commonService.getUserPhone(request);
		tbVipFollowPlayer.setVipPhone(phone);
		ResultMessage msg = infGainsInfoService.addFollow(tbVipFollowPlayer);
		return msg;
	}

	@RequestMapping(value="cancelFollow",method=RequestMethod.POST)
	@ResponseBody
	public ResultMessage cancelFollow(HttpServletRequest request, TbVipFollowPlayer tbVipFollowPlayer) throws Exception{
		String phone = commonService.getUserPhone(request);
		tbVipFollowPlayer.setVipPhone(phone);
		ResultMessage msg = infGainsInfoService.cancelFollow(tbVipFollowPlayer);
		return msg;
	}

	@RequestMapping(value="getMonths",method=RequestMethod.POST)
	@ResponseBody
	public List<String> getMonths(){
		return infGainsInfoService.getMonths();
	}

	@RequestMapping(value="getTopMonthHisByPage",method=RequestMethod.POST)
	@ResponseBody
	public Pagination<TbTopByMonth> getTopMonthHisByPage(String month, Integer pageSize, Integer pageNo ){
		if (pageSize == null || pageSize <= 0) {
			pageSize = 10;
		}
		if (pageNo == null || pageNo <= 0) {
			pageNo = 1;
		}
		return infGainsInfoService.getTopMonthHisByPage(month,pageSize,pageNo);
	}

	@RequestMapping(value="getTopAllByAccount",method=RequestMethod.POST)
	@ResponseBody
	public Pagination<PlayerTopInfo> getTopAllByAccount(HttpServletRequest request,Integer pageSize,Integer pageNo) throws Exception{
//		String phone = commonService.getUserPhone(request);
		String phone = "15828029800";
		if (pageSize == null || pageSize <= 0) {
			pageSize = 10;
		}
		if (pageNo == null || pageNo <= 0) {
			pageNo = 1;
		}
		return infGainsInfoService.getTopAllByAccount(phone,pageSize,pageNo);
	}
}
