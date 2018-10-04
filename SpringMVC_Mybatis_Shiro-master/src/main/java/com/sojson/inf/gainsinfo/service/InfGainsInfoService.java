package com.sojson.inf.gainsinfo.service;


import com.sojson.common.ResultMessage;
import com.sojson.common.model.dto.PlayerTopInfo;
import com.sojson.common.model.vo.TbGainsInfoVo;
import com.sojson.common.model.vo.TbPlayerMoneyVo;
import com.sojson.core.mybatis.page.Pagination;

import java.util.Collection;
import java.util.List;

public interface InfGainsInfoService {


    public List<PlayerTopInfo> getTopAll(int size);

    public List<PlayerTopInfo> getTopMonth(int size);

    public List<PlayerTopInfo> getTopAllByMoney(int size);

    public Collection<TbGainsInfoVo> getStrategy(String account, String endTime);

    public Pagination<TbGainsInfoVo> getTransactionInfo(String account, String endTime, Integer pageNo, Integer pageSize);

    public TbPlayerMoneyVo getPlayerMoney4Account(String account, String endTime);
}
