package com.sojson.common.model.dto;

import com.sojson.common.IConstant;

/**
 * @ClassName:PlayerTopInfo
 * @Description:用户排行榜信息
 * @Author:yamol
 * @Date:2018-9-23 15:01
 * @VERSION: 1.0
 */
public class PlayerTopInfo implements Comparable<PlayerTopInfo>,Cloneable {

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
     * 收益
     */
    private String yield;

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

    /**
     * 排名
     */
    private Integer rank;

    /**
     * 是否为最新标记
     */
    private Byte isNewFlag = IConstant.YES_OR_NO.NO.v;

    /**
     * 数据日期
     */
    private String dataTime;

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

    public String getYield() {
        return yield;
    }

    public void setYield(String yield) {
        this.yield = yield;
    }

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }

    public Byte getIsNewFlag() {
        return isNewFlag;
    }

    public void setIsNewFlag(Byte isNewFlag) {
        this.isNewFlag = isNewFlag;
    }

    public String getDataTime() {
        return dataTime;
    }

    public void setDataTime(String dataTime) {
        this.dataTime = dataTime;
    }

    @Override
    public int compareTo(PlayerTopInfo o) {
        if (Double.parseDouble(this.yieldRate) >= Double.parseDouble(o.yieldRate)) {
            return 1;
        }
        return -1;
    }

    @Override
    public PlayerTopInfo clone() {
        PlayerTopInfo playerTopInfo = null;
        try {
            playerTopInfo = (PlayerTopInfo) super.clone();
        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
        return playerTopInfo;
    }



}
