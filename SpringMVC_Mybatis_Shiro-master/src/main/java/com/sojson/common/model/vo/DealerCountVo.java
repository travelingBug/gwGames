package com.sojson.common.model.vo;

import com.sojson.common.model.TbDealer;

import java.io.Serializable;
import java.util.Date;

/**
 */
public class DealerCountVo extends TbDealer implements Serializable {

    private Integer vipCount = 0;

    private Integer vipACount = 0;

    private Double vipAMoneyCount = 0d;

    private Integer vipBCount = 0;

    private Double vipBMoneyCount = 0d;

    private Integer vipCCount = 0;

    private Double vipCMoneyCount = 0d;

    private Double vipMoneyCount = 0d;

    public Integer getVipACount() {
        return vipACount;
    }

    public void setVipACount(Integer vipACount) {
        this.vipACount = vipACount;
    }

    public Integer getVipBCount() {
        return vipBCount;
    }

    public void setVipBCount(Integer vipBCount) {
        this.vipBCount = vipBCount;
    }

    public Integer getVipCCount() {
        return vipCCount;
    }

    public void setVipCCount(Integer vipCCount) {
        this.vipCCount = vipCCount;
    }

    public Double getVipAMoneyCount() {
        return vipAMoneyCount;
    }

    public void setVipAMoneyCount(Double vipAMoneyCount) {
        this.vipAMoneyCount = vipAMoneyCount;
    }

    public Double getVipBMoneyCount() {
        return vipBMoneyCount;
    }

    public void setVipBMoneyCount(Double vipBMoneyCount) {
        this.vipBMoneyCount = vipBMoneyCount;
    }

    public Double getVipCMoneyCount() {
        return vipCMoneyCount;
    }

    public void setVipCMoneyCount(Double vipCMoneyCount) {
        this.vipCMoneyCount = vipCMoneyCount;
    }

    public Double getVipMoneyCount() {
        return vipMoneyCount;
    }

    public void setVipMoneyCount(Double vipMoneyCount) {
        this.vipMoneyCount = vipMoneyCount;
    }

    public Integer getVipCount() {
        return vipCount;
    }

    public void setVipCount(Integer vipCount) {
        this.vipCount = vipCount;
    }
}
