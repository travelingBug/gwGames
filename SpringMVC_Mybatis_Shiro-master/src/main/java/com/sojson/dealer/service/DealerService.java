package com.sojson.dealer.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbDealer;
import com.sojson.common.model.vo.DealerCountVo;
import com.sojson.core.mybatis.page.Pagination;

import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
public interface DealerService {
    Pagination<TbDealer> findByPage(Map<String, Object> resultMap, Integer pageNo,
                                    Integer pageSize);

    ResultMessage update(TbDealer entity);

    ResultMessage insert(TbDealer entity);

    ResultMessage delete(String id);

    /**
     * 统计经销商的会员数
     * @param param
     * @return
     */
    public List<DealerCountVo> countDealerVip(Map<String,Object> param);

    public List<DealerCountVo> countDealerVipById(Map<String,Object> param);

    public ResultMessage exportExcelDealerVip(Map<String,Object> param);

    public ResultMessage exportEmployee(Map<String,Object> param);
}
