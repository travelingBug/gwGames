package com.sojson.common.model;

import java.io.Serializable;
import java.util.Date;

/**
 */
public class TbStopDateHis implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * 主键
     */
    private Long id;


    /**
     * '开始时间'
     */
    private Date bgnTime;

    /**
     * '结束时间'
     */
    private Date endTime;
    /**
     * '开始操作人员'
     */
    private Long bgnUserId;
    /**
     * '结束操作人员'
     */
    private Long endUserId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }


    public Date getBgnTime() {
        return bgnTime;
    }

    public void setBgnTime(Date bgnTime) {
        this.bgnTime = bgnTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Long getBgnUserId() {
        return bgnUserId;
    }

    public void setBgnUserId(Long bgnUserId) {
        this.bgnUserId = bgnUserId;
    }

    public Long getEndUserId() {
        return endUserId;
    }

    public void setEndUserId(Long endUserId) {
        this.endUserId = endUserId;
    }
}
