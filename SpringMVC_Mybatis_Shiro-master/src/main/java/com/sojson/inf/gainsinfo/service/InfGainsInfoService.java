package com.sojson.inf.gainsinfo.service;


import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbTopByMonth;
import com.sojson.common.model.TbVipFollowPlayer;
import com.sojson.common.model.dto.PlayerTopInfo;
import com.sojson.common.model.vo.TbGainsInfoVo;
import com.sojson.common.model.vo.TbPlayerMoneyVo;
import com.sojson.core.mybatis.page.Pagination;

import java.util.Collection;
import java.util.List;

public interface InfGainsInfoService {


    public List<PlayerTopInfo> getTopAll(int size);

    public Pagination<PlayerTopInfo> getTopAllByPage(int pageSize,int pageNo);

    public List<PlayerTopInfo> getTopMonth(int size);

    public List<PlayerTopInfo> getTopAllByMoney(int size);

    public Collection<TbGainsInfoVo> getStrategy(String account, String endTime);
    public ResultMessage getPlayerInfo(String account,String dataTime);

    public Pagination<TbGainsInfoVo> getTransactionInfo(String account, String endTime, Integer pageNo, Integer pageSize);

    public TbPlayerMoneyVo getPlayerMoney4Account(String account,String vipPhone, String endTime);

    public ResultMessage addFollow(TbVipFollowPlayer tbVipFollowPlayer);
    public ResultMessage cancelFollow(TbVipFollowPlayer tbVipFollowPlayer);

    public Pagination<PlayerTopInfo> getTopMonthByPage(int pageSize,int pageNo);

    public List<String> getMonths();

    public Pagination<TbTopByMonth>  getTopMonthHisByPage(String month, int pageSize, int pageNo );

    Pagination<PlayerTopInfo> getTopAllByAccount(String phone, int pageSize,int pageNo);

    public List<PlayerTopInfo> getLastTopMonth(int size);

    public List<PlayerTopInfo> getLastTopAll(int size);

    public ResultMessage getLastDate();
}
