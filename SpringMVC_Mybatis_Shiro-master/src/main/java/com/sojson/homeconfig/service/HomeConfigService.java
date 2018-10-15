package com.sojson.homeconfig.service;


import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbEventReport;
import com.sojson.common.model.TbHomeConfig;
import com.sojson.core.mybatis.page.Pagination;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 * 赛事报道
 */
public interface HomeConfigService {

    /**
     * 赛事报道数据列表
     *
     * @param resultMap
     * @param pageNo
     * @param pageSize
     * @return
     */
    Pagination<TbHomeConfig> findByPage(Map<String, Object> resultMap, Integer pageNo,
                                        Integer pageSize);

    public ResultMessage add(MultipartFile file, TbHomeConfig tbHomeConfig);


    public TbHomeConfig findById(String id);


    public ResultMessage update(MultipartFile file, TbHomeConfig tbHomeConfig);


    public ResultMessage deleteById(String id);

    public ResultMessage getHomeConfig();

    public ResultMessage getHomeAdvert();
}
