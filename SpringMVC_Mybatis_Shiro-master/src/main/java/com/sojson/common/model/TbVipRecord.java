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
    private String amount;

    private String remark;

    private String nickname;

    private String belong;

    private String belong2;

    public String getBelong() {
        return belong;
    }

    public void setBelong(String belong) {
        this.belong = belong;
    }

    public String getBelong2() {
        return belong2;
    }

    public void setBelong2(String belong2) {
        this.belong2 = belong2;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

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

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }
}