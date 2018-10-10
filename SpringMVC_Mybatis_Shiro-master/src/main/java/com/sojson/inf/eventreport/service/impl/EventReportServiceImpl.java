package com.sojson.inf.eventreport.service.impl;

import com.sojson.common.dao.UTbEventReportMapper;
import com.sojson.common.model.TbEventReport;
import com.sojson.common.model.vo.TbEventReportVo;
import com.sojson.common.utils.DateUtil;
import com.sojson.core.config.IConfig;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.inf.eventreport.service.EventReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by lx on 2018/8/27.
 */
@Service
public class EventReportServiceImpl extends BaseMybatisDao<UTbEventReportMapper> implements EventReportService {

    @Autowired
    UTbEventReportMapper uTbEventReportMapper;

    @SuppressWarnings("unchecked")
    @Override
    public Pagination<TbEventReport> findByPage(Integer pageNo, Integer pageSize) {
        Map<String,Object> resultMap = new HashMap<String,Object>();
        Pagination<TbEventReport> page = super.findPage(resultMap, pageNo, pageSize);
        if (page.getList() != null && page.getList().size() > 0) {
            for (TbEventReport vo : page.getList()  ) {
                vo.setCover(IConfig.get("eventReport_path") + vo.getCover());
            }
        }

        return page;
    }


    @Override
    public TbEventReportVo findById(String id){
        TbEventReport tbEventReport =  uTbEventReportMapper.findById(id);
        TbEventReportVo vo = new TbEventReportVo();
        vo.setCrtTime(tbEventReport.getCrtTime());
        vo.setTitle(tbEventReport.getTitle());
        vo.setContent(tbEventReport.getContent());
        vo.setCrtTimeStr(DateUtil.dateToString(vo.getCrtTime(),DateUtil.DATETIME_PATTERN));
        return vo;
    }




}
