package com.sojson.common.model.vo;

import com.sojson.common.model.TbGainsInfo;

import java.io.Serializable;
import java.util.Date;

/**
 * 选手收益展示信息
 */
public class TbGainsInfoVo extends TbGainsInfo {

    /**
     * 账户名称
     */
    private String accountName;

    /**
     * 参赛者名称
     */
    private String name;

    /**
     * 交易时间格式
     */
    private String businessTimeStr;

    /**
     * 收益金额
     */
    private String getMoney;

    /**
     * 本金
     */
    private String capital;

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBusinessTimeStr() {
        return businessTimeStr;
    }

    public void setBusinessTimeStr(String businessTimeStr) {
        this.businessTimeStr = businessTimeStr;
    }

    public String getGetMoney() {
        return getMoney;
    }

    public void setGetMoney(String getMoney) {
        this.getMoney = getMoney;
    }

    public String getCapital() {
        return capital;
    }

    public void setCapital(String capital) {
        this.capital = capital;
    }
}
