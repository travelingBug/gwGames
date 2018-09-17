package com.sojson.common.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 选手收益表
 */
public class TbGainsInfo implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * 主键
     */
    private String id;

    /**
     * 身份证号
     */
    private String idCard;


    /**
     * 股票代码
     */
    private String sharesCode;

    /**
     * '股票名称'
     */
    private String sharesName;

    /**
     * 买卖标致
     * 0:买 1：卖
     */
    private Byte  businessFlag;

    /**
     * '成交量'
     */
    private Integer volume;

    /**
     * 成交价格
     */
    private String price;

    /**
     * '总资产'
     */
    private String totalMoney;

    /**
     * 交易时间
     */
    private Date businessTime;

    /**
     * 创建时间
     */
    private Date crtTime;

    /**
     * 修改时间
     */
    private Date modTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSharesCode() {
        return sharesCode;
    }

    public void setSharesCode(String sharesCode) {
        this.sharesCode = sharesCode;
    }


    public Byte getBusinessFlag() {
        return businessFlag;
    }

    public void setBusinessFlag(Byte businessFlag) {
        this.businessFlag = businessFlag;
    }

    public Integer getVolume() {
        return volume;
    }

    public void setVolume(Integer volume) {
        this.volume = volume;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(String totalMoney) {
        this.totalMoney = totalMoney;
    }

    public Date getBusinessTime() {

        return businessTime;
    }

    public void setBusinessTime(Date businessTime) {
        this.businessTime = businessTime;
    }

    public Date getCrtTime() {
        return crtTime;
    }

    public void setCrtTime(Date crtTime) {
        this.crtTime = crtTime;
    }

    public Date getModTime() {
        return modTime;
    }

    public void setModTime(Date modTime) {
        this.modTime = modTime;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getSharesName() {
        return sharesName;
    }

    public void setSharesName(String sharesName) {
        this.sharesName = sharesName;
    }

}
