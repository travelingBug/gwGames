package com.sojson.topbymonth.service.impl;


import com.sojson.common.dao.UTbPlayerMoneyMapper;
import com.sojson.common.dao.UTbTopByMonthMapper;
import com.sojson.common.model.TbTopByMonth;
import com.sojson.common.model.vo.TbPlayerMoneyVo;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.topbymonth.service.TopByMonthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.*;

@Service
public class TopByMonthServiceImpl extends BaseMybatisDao<UTbTopByMonthMapper> implements TopByMonthService {


    @Autowired
    UTbTopByMonthMapper uTbTopByMonthMapper;

    @Resource
    UTbPlayerMoneyMapper uTbPlayerMoneyMapper;

    @SuppressWarnings("unchecked")
    @Override
    public Pagination<TbTopByMonth> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }


    @Override
    public void insertTopMonth(String currDate,String preDate){
        Map<String,Object> param = new HashMap<String,Object>();
        param.put("currDate",currDate);
        List<TbPlayerMoneyVo> cuurTopInfos = uTbPlayerMoneyMapper.findTopByMonth(param);
        param.put("currDate",preDate);
        List<TbPlayerMoneyVo> preTopInfos = uTbPlayerMoneyMapper.findTopByMonth(param);
        //根据身份证统计每个人的信息
        List<TbTopByMonth> palyerTopMonthInfos = new ArrayList<TbTopByMonth>();
        //保存已经存在的重复数据
        List<String> hasAccount = new ArrayList<String>();
        for (TbPlayerMoneyVo cuurTopInfo : cuurTopInfos) {
            //剔除重复数据
            if (hasAccount.contains(cuurTopInfo.getAccount())) {
                continue;
            }
            hasAccount.add(cuurTopInfo.getAccount());

            TbTopByMonth playerTopInfo = new TbTopByMonth();
            playerTopInfo.setAccountName(cuurTopInfo.getAccountName());
            playerTopInfo.setAccount(cuurTopInfo.getAccount());
            playerTopInfo.setTotalMoney(cuurTopInfo.getTotalMoney());
            playerTopInfo.setCapital(cuurTopInfo.getCapital()); //默认先设置本金为当前本金，（因为初始化第一个月就是用本金）

            //***********************************计算收益率
            //找到上个月最后一条记录做为本金
            for (TbPlayerMoneyVo preTopInfo : preTopInfos) {
                if (preTopInfo.getAccount().equals(cuurTopInfo.getAccount())) {
                    //以上个月最后一天的资金做为本金计算收益
                    playerTopInfo.setCapital(preTopInfo.getTotalMoney());
                    break;
                }
            }
            //计算收益率
            double totleDou = Double.parseDouble(playerTopInfo.getTotalMoney());
            double capital = Double.parseDouble(playerTopInfo.getCapital());
            BigDecimal bg = new BigDecimal((totleDou - capital) * 100/capital);
            double rate = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            playerTopInfo.setYieldRate(rate + "");

            bg = new BigDecimal(totleDou - capital);
            playerTopInfo.setYield(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() + "");
            //持仓比

            //计算剩余金额
            double buyMoney = Double.parseDouble(String.valueOf(cuurTopInfo.getSharesMoney()));
            playerTopInfo.setBuyMoney(new BigDecimal(buyMoney).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() + "");
            bg = new BigDecimal(buyMoney * 100/totleDou);
            rate = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            playerTopInfo.setBuyForALLRate(rate + "");

            palyerTopMonthInfos.add(playerTopInfo);
        }
        Collections.sort(palyerTopMonthInfos,Collections.reverseOrder());
        //设置时间和排名
        int i = 1 ;
        for (TbTopByMonth tbTopByMonth : palyerTopMonthInfos) {
            tbTopByMonth.setMonth(currDate);
            tbTopByMonth.setRank(i);
            i++;
        }

        uTbTopByMonthMapper.insertBatch(palyerTopMonthInfos);

    }

}
