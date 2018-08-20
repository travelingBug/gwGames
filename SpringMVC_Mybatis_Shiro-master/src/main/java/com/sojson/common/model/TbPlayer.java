package com.sojson.common.model;

import net.sf.json.JSONObject;

import java.io.Serializable;
import java.util.Date;


public class TbPlayer implements Serializable{
	private static final long serialVersionUID = 1L;
    /**
     * 主键
     */
	private String id;

    /**
     * 账户名称
     */
	private String accountName;

    /**
     * 参赛者名称
     */
	private String name;

    /**
     * 身份证
     */
	private String idCard;

    /**
     * 电话号码
     */
	private String telPhone;

    /**
     * 删除标记
     * 0:未删除 1：已删除
     */
	private Byte delFlag;

    /**
     * 审核标记
     * 0:未审核 1：审核通过 2：审核不通过
     */
	private Byte auditFlag;

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getTelPhone() {
        return telPhone;
    }

    public void setTelPhone(String telPhone) {
        this.telPhone = telPhone;
    }

    public Byte getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Byte delFlag) {
        this.delFlag = delFlag;
    }

    public Byte getAuditFlag() {
        return auditFlag;
    }

    public void setAuditFlag(Byte auditFlag) {
        this.auditFlag = auditFlag;
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

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }
}