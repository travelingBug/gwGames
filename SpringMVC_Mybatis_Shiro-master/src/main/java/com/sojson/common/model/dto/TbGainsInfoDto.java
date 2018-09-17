package com.sojson.common.model.dto;

import com.sojson.common.model.TbGainsInfo;


/**
 * 选手收益表
 */
public class TbGainsInfoDto extends TbGainsInfo {

    /**
     * 交易开始时间
     */
    private String bgnTime;

    /**
     * 交易结束时间
     */
    private String endTime;

    /**
     * 交易时间（字符串格式）
     */
    private String businessTimeStr;

    public String getBgnTime() {
        return bgnTime;
    }

    public void setBgnTime(String bgnTime) {
        this.bgnTime = bgnTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getBusinessTimeStr() {
        return businessTimeStr;
    }

    public void setBusinessTimeStr(String businessTimeStr) {
        this.businessTimeStr = businessTimeStr;
    }
}
