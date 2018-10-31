package com.sojson.common.timer;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;

import com.sojson.common.IConstant;
import com.sojson.common.model.TbStopDate;
import com.sojson.common.utils.LoggerUtils;
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

	@Scheduled(cron = "00 00 01 01 * ? ")
//@Scheduled(cron = "00 42 10 * * ? ")
	public void run() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
		Calendar cal=Calendar.getInstance();
        cal.add(Calendar.MONTH,-1);
		String currDate = formatter.format(cal.getTime());
		cal.add(Calendar.MONTH,-1);
		String preDate = formatter.format(cal.getTime());
		logger.info("开始插入月度比赛排名("+currDate+")");

		topByMonthService.insertTopMonth(currDate,preDate);
		logger.info("月度比赛排名排名完毕");
	}

	@Scheduled(cron = "00 01 00 * * ?")
	public void changeVip() {

		//判断是周末不进行日期的减少
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		if(!(cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || cal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY)){
			//获取当前信息系统暂停信息
			List<TbStopDate> tbStopDates = stopDateService.findStopDate();

			//判断当前时间在不在日期类
			long currTime = new Date().getTime();
			boolean flag = true;
			for (TbStopDate tbStopDate : tbStopDates) {
				//若果在时间范围内，则不需要做清理
				if (currTime >= tbStopDate.getBgnTime().getTime() && currTime <= tbStopDate.getEndTime().getTime() ) {
					flag = false;
					break;
				}
			}
			if (flag) {
				//扣除会员天数
				vipsService.updateSurplusDay();

				//清理天数为0的用户会员级别
				LoggerUtils.fmtDebug(getClass(),"开始清理会员信息！");
				vipsService.updateLevelByDay();
				LoggerUtils.fmtDebug(getClass(),"清理会员信息结束！");
			} else {
				LoggerUtils.fmtDebug(getClass(),"当日不扣除会员天数");
			}
		}
	}


}
