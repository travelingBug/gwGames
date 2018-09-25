package com.sojson.common.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;


public class TbVipRecord implements Serializable{
	private static final long serialVersionUID = 1L;

    private Integer id;

    /**
     * 所属VIP会员
     */
    private Integer vipId;

    /**
     * 会员类型 a:1  b:2  C:3
     */
    private byte level;

    /**
     * 充值时间
     */
    private Date crtTime;


    /**
     * 充值金额
     */
    private Integer amount;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getVipId() {
        return vipId;
    }

    public void setVipId(Integer vipId) {
        this.vipId = vipId;
    }

    public byte getLevel() {
        return level;
    }

    public void setLevel(byte level) {
        this.level = level;
    }

    public Date getCrtTime() {
        return crtTime;
    }

    public void setCrtTime(Date crtTime) {
        this.crtTime = crtTime;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

}