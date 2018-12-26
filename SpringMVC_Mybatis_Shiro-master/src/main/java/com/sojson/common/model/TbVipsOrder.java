package com.sojson.common.model;

public class TbVipsOrder {

    private Integer id;
    /**
     * 订单编号
     */
    private String orderNo;
    /**
     * 订单内容
     */
    private String orderTitle;
    /**
     * 订单日期
     */
    private String orderDate;
    /**
     * 用户编号
     */
    private String vipId;
    /**
     * 充值费用
     */
    private String fee;

    /**
     * 银行编码
     */
    private String bankCode;

    /**
     * 银行卡号
     */
    private String cardNo;

    /**
     * 持卡人
     */
    private String cardName;

    /**
     * 身份证
     */
    private String idNo;

    /**
     * 电话号码
     */
    private String phone;

    /**
     * 验证码
     */
    private String smsCode;

    /**
     * 订单状态
     */
    private Integer status;

    private String step;

    //微信支付1：扫码，2：app，3：公众号，4：小程序
    private String t;

    public String getT() {
        return t;
    }

    public void setT(String t) {
        this.t = t;
    }

    public String getStep() {
        return step;
    }

    public void setStep(String step) {
        this.step = step;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getSmsCode() {
        return smsCode;
    }

    public void setSmsCode(String smsCode) {
        this.smsCode = smsCode;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getOrderTitle() {
        return orderTitle;
    }

    public void setOrderTitle(String orderTitle) {
        this.orderTitle = orderTitle;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getVipId() {
        return vipId;
    }

    public void setVipId(String vipId) {
        this.vipId = vipId;
    }

    public String getFee() {
        return fee;
    }

    public void setFee(String fee) {
        this.fee = fee;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getCardNo() {
        return cardNo;
    }

    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}