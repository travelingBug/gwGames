package com.sojson.common.model.vo;

/**
 * @ClassName:VipRecordCount
 * @Description:报表统计
 * @Author:yamol
 * @Date:2018-9-24 16:47
 * @VERSION: 1.0
 */
public class VipRecordCount {

    /**
     * 经销商名称
     */
    private String name;

    /**
     * 邀请码
     */
    private String invitaionCode;

    /**
     * 会员级别
     */
    private Byte level;

    /**
     * 统计总数
     */
    private Integer countNum;

    /**
     * 统计总额
     */
    private Integer countMoney;

    public String getInvitaionCode() {
        return invitaionCode;
    }

    public void setInvitaionCode(String invitaionCode) {
        this.invitaionCode = invitaionCode;
    }

    public Byte getLevel() {
        return level;
    }

    public void setLevel(Byte level) {
        this.level = level;
    }

    public Integer getCountNum() {
        return countNum;
    }

    public void setCountNum(Integer countNum) {
        this.countNum = countNum;
    }

    public Integer getCountMoney() {
        return countMoney;
    }

    public void setCountMoney(Integer countMoney) {
        this.countMoney = countMoney;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
