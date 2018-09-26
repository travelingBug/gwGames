package com.sojson.core.init;/**
 * @Author: hy
 * @Description:
 * @Date:${Time} ${Date}
 **/

import com.sojson.inf.gainsinfo.service.InfGainsInfoService;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * @ClassName:TestInit
 * @Description:TODO
 * @Author:yamol
 * @Date:2018-9-1 23:29
 * @VERSION: 1.0
 */
public class TestInit {

    @Resource
    InfGainsInfoService infGainsInfoService;


    public void init(){
//        infGainsInfoService.getTopResultForAll();
//
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
//        Calendar cal=Calendar.getInstance();
//        cal.add(Calendar.MONTH,2);
//        String currDate = formatter.format(cal.getTime());
//        cal.add(Calendar.MONTH,-1);
//        String preDate = formatter.format(cal.getTime());
//        infGainsInfoService.findTopByMonth(currDate,preDate);
    }
}
