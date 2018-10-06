package com.sojson.common.timer;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;

import com.sojson.playermoney.service.PlayerMoneyService;
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

	@Scheduled(cron = "00 00 01 01 * ? ")
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

	
	
	
	
	
	
}
