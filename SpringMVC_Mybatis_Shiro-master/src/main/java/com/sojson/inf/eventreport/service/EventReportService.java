package com.sojson.inf.eventreport.service;


import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbEventReport;
import com.sojson.common.model.vo.TbEventReportVo;
import com.sojson.core.mybatis.page.Pagination;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 * 赛事报道
 */
public interface EventReportService {

    /**
     * 赛事报道数据列表
     * @param pageNo
     * @param pageSize
     * @return
     */
    Pagination<TbEventReport> findByPage(Integer pageNo,
                                         Integer pageSize);

    public TbEventReportVo findById(String id);

}
