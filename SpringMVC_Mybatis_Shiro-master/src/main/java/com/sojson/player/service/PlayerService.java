package com.sojson.player.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbPlayer;
import com.sojson.core.mybatis.page.Pagination;

import java.util.Map;

/**
 * Created by lx on 2018/8/27.
 */
public interface PlayerService {

    Pagination<TbPlayer> findByPage(Map<String, Object> resultMap, Integer pageNo,
                                    Integer pageSize);

    ResultMessage updateByPrimaryKeySelective(TbPlayer entity);
}