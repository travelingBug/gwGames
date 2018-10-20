package com.sojson.common.model;

public class TbVipsCard {

    private Integer id;
    /**
     * 手机号码
     */
    private String phone;
    /**
     * 银行卡号
     */
    private String cardNo;
    /**
     * 银行编码
     */
    private String cardCode;
    /**
     * 持卡人姓名
     */
    private String cardName;
    /**
     * 身份证号码
     */
    private String idNo;

    private String bankName;

    /**
     * 开户电话
     */
    private String bankPhone;

    public String getBankPhone() {
        return bankPhone;
    }

    public void setBankPhone(String bankPhone) {
        this.bankPhone = bankPhone;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCardNo() {
        return cardNo;
    }

    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }

    public String getCardCode() {
        return cardCode;
    }

    public void setCardCode(String cardCode) {
        this.cardCode = cardCode;
    }

    public String getCardName() {
        return cardName;
    }

    public void setCardName(String cardName) {
        this.cardName = cardName;
    }

    public String getIdNo() {
        return idNo;
    }

    public void setIdNo(String idNo) {
        this.idNo = idNo;
    }
}