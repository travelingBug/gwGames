package com.sojson.dealer.service.impl;

import com.sojson.common.dao.UTbDealerMapper;
import com.sojson.common.dao.UTbVipRecordMapper;
import com.sojson.common.dao.UTbVipsMapper;
import com.sojson.common.model.TbVipRecord;
import com.sojson.common.model.TbVips;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.dealer.service.VipsRecordListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
@Service
public class VipsRecordListServiceImpl extends BaseMybatisDao<UTbVipRecordMapper> implements VipsRecordListService {

    @Autowired
    UTbVipRecordMapper uTbVipRecordMapper;

    protected Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

    @SuppressWarnings("unchecked")
    @Override
    public Pagination<TbVipRecord> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }

    @Override
    public Pagination<TbVipRecord> findByPageAdmin(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        pageNo = null == pageNo ? 1 : pageNo;
        pageSize = null == pageSize ? 10 : pageSize;

        Pagination page = new Pagination();
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);

        int start = (pageNo - 1) * pageSize;
        resultMap.put("start", start);
        resultMap.put("pageSize", pageSize);
        int totalNum = uTbVipRecordMapper.findByPageAdminCount(resultMap);

        List<TbVipRecord> list = null;
        String totalAmount = "";
        if (totalNum > 0) {
            totalAmount = uTbVipRecordMapper.findByPageAdminSum(resultMap);
            list =uTbVipRecordMapper.findByPageAdmin(resultMap);
        }

        page.setTotalCount(totalNum);
        page.setList(list);
        page.setTotalAmount(totalAmount);

        return page;
    }

    @Override
    public Pagination<TbVipRecord> findByPageDealer(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        pageNo = null == pageNo ? 1 : pageNo;
        pageSize = null == pageSize ? 10 : pageSize;

        Pagination page = new Pagination();
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);

        int start = (pageNo - 1) * pageSize;
        resultMap.put("start", start);
        resultMap.put("pageSize", pageSize);
        int totalNum = uTbVipRecordMapper.findByPageDealerCount(resultMap);

        List<TbVipRecord> list = null;
        String totalAmount = "";
        if (totalNum > 0) {
            totalAmount = uTbVipRecordMapper.findByPageDealerSum(resultMap);
            list =uTbVipRecordMapper.findByPageDealer(resultMap);
        }

        page.setTotalCount(totalNum);
        page.setList(list);
        page.setTotalAmount(totalAmount);

        return page;
    }

    @Override
    public Pagination<TbVipRecord> findByPageEmployee(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        pageNo = null == pageNo ? 1 : pageNo;
        pageSize = null == pageSize ? 10 : pageSize;

        Pagination page = new Pagination();
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);

        int start = (pageNo - 1) * pageSize;
        resultMap.put("start", start);
        resultMap.put("pageSize", pageSize);
        int totalNum = uTbVipRecordMapper.findByPageEmployeeCount(resultMap);

        List<TbVipRecord> list = null;
        String totalAmount = "";
        if (totalNum > 0) {
            totalAmount = uTbVipRecordMapper.findByPageEmployeeSum(resultMap);
            list =uTbVipRecordMapper.findByPageEmployee(resultMap);
        }

        page.setTotalCount(totalNum);
        page.setList(list);
        page.setTotalAmount(totalAmount);

        return page;
    }


}
