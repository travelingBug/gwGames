package com.sojson.common.timer;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;

import com.sojson.common.IConstant;
import com.sojson.common.model.TbStopDate;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.inf.gainsinfo.utis.GainsInfoCache;
import com.sojson.inf.vips.service.VipsService;
import com.sojson.playermoney.service.PlayerMoneyService;
import com.sojson.stopdate.service.StopDateService;
import com.sojson.topbymonth.service.TopByMonthService;
import com.sojson.topbymonth.service.impl.TopByMonthServiceImpl;
import org.apache.log4j.Logger;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.sojson.permission.service.RoleService;


/**
 * 定时任务恢复数据
 *
 */
@Component
public class ToTimer{
	Logger logger = Logger.getLogger(ToTimer.class);
    @Resource
	TopByMonthService topByMonthService;

	@Resource
	StopDateService stopDateService;

	@Resource
	VipsService vipsService;

	@Resource
	PlayerMoneyService playerMoneyService;

	@Scheduled(cron = "00 15 00 14 * ? ")
//@Scheduled(cron = "00 49 22 03 * ? ")
	public void run() {
		Calendar cal=Calendar.getInstance();
		Date currEndDate = cal.getTime();
        cal.add(Calendar.MONTH,-1);
		Date currBgnDate= cal.getTime();
		Date preEndDate = cal.getTime();
		cal.add(Calendar.MONTH,-1);
		Date preBgnDate = cal.getTime();
		logger.info("开始插入月度比赛排名");

		topByMonthService.insertTopMonth(currBgnDate,currEndDate,preBgnDate,preEndDate);
		logger.info("月度比赛排名排名完毕");

		playerMoneyService.findTopByMonth("","");
	}

	@Scheduled(cron = "00 01 00 * * ?")
//	@Scheduled(cron = "00 50 00 * * ?")
	public void changeVip() {

		//判断是周末不进行日期的减少
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		//因为当前时间是第二天，所以必须减1表示扣除头天的
		cal.add(Calendar.DATE,-1);
		if(!(cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || cal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)){
			//获取当前信息系统暂停信息
			List<TbStopDate> tbStopDates = stopDateService.findStopDate();

			//判断当前时间在不在日期类
			long currTime = cal.getTime().getTime();
			boolean flag = true;
			for (TbStopDate tbStopDate : tbStopDates) {
				//若果在时间范围内，则不需要做清理
				if (currTime >= tbStopDate.getBgnTime().getTime() && currTime <= tbStopDate.getEndTime().getTime() ) {
					flag = false;
					break;
				}
			}
			if (flag) {

//				//扣除会员天数
//				//会员当天开通的时间不做扣除操作。如果当前时间是周一，那么周五开通的不做扣除
//				if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.MONDAY) {
//					cal.add(Calendar.DATE,-3);
//				}
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Map<String,Object> param = new HashMap<String,Object>();
				param.put("noDay",sdf.format(cal.getTime()));
				vipsService.updateSurplusDay(param);

				//清理天数为0的用户会员级别
				LoggerUtils.fmtDebug(getClass(),"开始清理会员信息！");
				vipsService.updateLevelByDay();
				LoggerUtils.fmtDebug(getClass(),"清理会员信息结束！");
			} else {
				LoggerUtils.fmtDebug(getClass(),"当日不扣除会员天数");
			}
		}
	}


	@Scheduled(cron = "00 00 00 * * ?")
//	@Scheduled(cron = "00 50 00 * * ?")
	public void clearNew() {
		LoggerUtils.fmtDebug(getClass(),"开始清理最新标记！");
		GainsInfoCache.clearTopAllNewFlag();
		GainsInfoCache.clearTopMonthNewFlag();;
		LoggerUtils.fmtDebug(getClass(),"清理最新标记结束！");
	}

}
