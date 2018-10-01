package com.sojson.inf.gainsinfo.service;


import com.sojson.common.model.dto.PlayerTopInfo;

import java.util.List;

public interface InfGainsInfoService {


    public List<PlayerTopInfo> getTopAll(int size);

    public List<PlayerTopInfo> getTopMonth(int size);

    public List<PlayerTopInfo> getTopAllByMoney(int size);
}
