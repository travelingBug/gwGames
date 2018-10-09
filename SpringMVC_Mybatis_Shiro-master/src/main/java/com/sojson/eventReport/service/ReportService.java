package com.sojson.eventReport.service;


import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbEventReport;
import com.sojson.core.mybatis.page.Pagination;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 * 赛事报道
 */
public interface ReportService {

    /**
     * 赛事报道数据列表
     * @param resultMap
     * @param pageNo
     * @param pageSize
     * @return
     */
    Pagination<TbEventReport> findByPage(Map<String, Object> resultMap, Integer pageNo,
                                         Integer pageSize);

    public ResultMessage add(MultipartFile file, TbEventReport tbEventReport);


    public TbEventReport findById(String id);


    public ResultMessage update(MultipartFile file, TbEventReport tbEventReport);


    public ResultMessage deleteById(String id);
}
