package com.sojson.common.model.dto;

/**
 * @ClassName:PlayerTopInfo
 * @Description:用户排行榜信息
 * @Author:yamol
 * @Date:2018-9-23 15:01
 * @VERSION: 1.0
 */
public class PlayerTopInfo {

    /**
     * 选手昵称
     */
    private String accountName;

    /**
     * 选手资金账号
     */
    private String account;

    /**
     * 选手总资产
     */
    private String totalMoney;

    /**
     * 本金
     */
    private String capital;

    /**
     * 收益率：（总金额-本金）/本金
     */
    private String yieldRate;

    /**
     * 购买总金额
     */
    private String buyMoney;

    /**
     * 持仓比：购买总金额/总金额
     */
    private String buyForALLRate;

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }



    public String getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(String totalMoney) {
        this.totalMoney = totalMoney;
    }

    public String getCapital() {
        return capital;
    }

    public void setCapital(String capital) {
        this.capital = capital;
    }

    public String getYieldRate() {
        return yieldRate;
    }

    public void setYieldRate(String yieldRate) {
        this.yieldRate = yieldRate;
    }

    public String getBuyMoney() {
        return buyMoney;
    }

    public void setBuyMoney(String buyMoney) {
        this.buyMoney = buyMoney;
    }

    public String getBuyForALLRate() {
        return buyForALLRate;
    }

    public void setBuyForALLRate(String buyForALLRate) {
        this.buyForALLRate = buyForALLRate;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }
}
