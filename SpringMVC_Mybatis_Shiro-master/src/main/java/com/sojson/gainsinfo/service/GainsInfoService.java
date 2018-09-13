package com.sojson.gainsinfo.service;


import com.sojson.common.ResultMessage;
import org.springframework.web.multipart.MultipartFile;

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
}
