package com.sojson.dealer.service.impl;

import com.sojson.common.dao.UTbDealerMapper;
import com.sojson.common.dao.UTbVipsMapper;
import com.sojson.common.model.TbVipRecord;
import com.sojson.common.model.TbVips;
import com.sojson.core.mybatis.BaseMybatisDao;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.dealer.service.VipsListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.*;

/**
 * Created by lx on 2018/9/4.
 */
@Service
public class VipsListServiceImpl extends BaseMybatisDao<UTbVipsMapper> implements VipsListService {

    @Autowired
    UTbDealerMapper uTbDealerMapper;

    @Autowired
    UTbVipsMapper uTbVipsMapper;

    protected Map<String, Object> resultMap = new LinkedHashMap<String, Object>();

    @SuppressWarnings("unchecked")
    @Override
    public Pagination<TbVips> findByPage(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        return super.findPage(resultMap, pageNo, pageSize);
    }

    @Override
    public Pagination<TbVips> findByPageAdmin(Map<String, Object> resultMap, Integer pageNo, Integer pageSize) {
        pageNo = null == pageNo ? 1 : pageNo;
        pageSize = null == pageSize ? 10 : pageSize;

        Pagination page = new Pagination();
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);

        int start = (pageNo - 1) * pageSize;
        resultMap.put("start", start);
        resultMap.put("pageSize", pageSize);
        int totalNum = uTbVipsMapper.findVipsAdminCount(resultMap);

        List<TbVips> list = null;
        if (totalNum > 0) {
            list =uTbVipsMapper.findVipsAdmin(resultMap);
        }

        page.setTotalCount(totalNum);
        page.setList(list);

        return page;
    }


}
