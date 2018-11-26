package com.sojson.core.init;/**
 * @Author: hy
 * @Description:
 * @Date:${Time} ${Date}
 **/

import com.sojson.common.dao.UTbPlayerMoneyMapper;
import com.sojson.common.model.vo.PlayerTransVo;
import com.sojson.common.utils.RedisUtil;
import com.sojson.inf.gainsinfo.service.InfGainsInfoService;
import com.sojson.inf.gainsinfo.utis.GainsInfoCache;
import com.sojson.playermoney.service.PlayerMoneyService;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @ClassName:TestInit
 * @Description:TODO
 * @Author:yamol
 * @Date:2018-9-1 23:29
 * @VERSION: 1.0
 */
public class TestInit {

    @Resource
    PlayerMoneyService playerMoneyService;

    @Resource
    UTbPlayerMoneyMapper uTbPlayerMoneyMapper;


    public void init(){
//        RedisUtil.getRedis();
//        RedisUtil.removeAll();
        playerMoneyService.getTopResultForAll();

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
        Calendar cal=Calendar.getInstance();
//        cal.add(Calendar.MONTH,-1);
        String currDate = formatter.format(cal.getTime());
        cal.add(Calendar.MONTH,-1);
        String preDate = formatter.format(cal.getTime());
        playerMoneyService.findTopByMonth(currDate,preDate);

        //获取当天有策略的信息
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String nowDate = sdf.format(new Date());
        Map<String,Object> param = new HashMap<String,Object>();
        param.put("currDate",nowDate);
        List<String> accounts = uTbPlayerMoneyMapper.getNewAccounts(param);
        GainsInfoCache.updateNewFlag(accounts);

        //获取当月的交易数量
        nowDate = nowDate.substring(0,7);
        param.put("currDate",nowDate);
        List<PlayerTransVo> playerTransVos = uTbPlayerMoneyMapper.getTransCount(param);
        GainsInfoCache.updateTransCount(playerTransVos);

    }
}
