package com.sojson.common.timer;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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

	@Scheduled(cron = "0 0/5 * * * ?")
	public void changeVip() {
		LoggerUtils.fmtError(getClass(),"开始清理会员信息！");
		//获取当前信息系统暂停信息
		TbStopDate tbStopDate = stopDateService.findStopDate();
		//只有在未暂停才会执行
		if (tbStopDate.getStopFlag() == IConstant.YES_OR_NO.NO.v) {
			Map<String,Object> param = new HashMap<String,Object>();
			param.put("nowDate",new Date());
			vipsService.updateLevelByEndTIme(param);
			LoggerUtils.fmtError(getClass(),"清理会员信息结束！");
		} else {
			LoggerUtils.fmtError(getClass(),"暂停记时开启中！");
		}

	}

	
	
	
	
	
	
}
