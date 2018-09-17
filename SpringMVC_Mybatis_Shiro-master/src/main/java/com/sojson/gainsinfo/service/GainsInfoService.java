package com.sojson.gainsinfo.service;


import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbGainsInfo;
import com.sojson.common.model.dto.TbGainsInfoDto;
import com.sojson.common.model.vo.TbGainsInfoVo;
import com.sojson.core.mybatis.page.Pagination;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

/**
 * 选手收益处理层
 */
public interface GainsInfoService {
    /**
     * 导入参赛选手数据
     * @param file 参赛选手EXCEL
     * @return
     */
    public ResultMessage importGainsExcel(MultipartFile file);

    Pagination<TbGainsInfoVo> findByPage(Map<String, Object> resultMap, Integer pageNo,
                                         Integer pageSize);

    /**
     * 修改
     * @param tbGainsInfo
     * @return
     */
    public ResultMessage update(TbGainsInfo tbGainsInfo);

    public ResultMessage add(TbGainsInfo tbGainsInfo);

    public ResultMessage deleteById(Long id);
}
