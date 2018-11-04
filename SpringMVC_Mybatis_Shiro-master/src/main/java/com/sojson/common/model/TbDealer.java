package com.sojson.common.model;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by lx on 2018/9/4.
 */
public class TbDealer implements Serializable {
    private static final long serialVersionUID = 1L;

    //0:未删除
    public static final Byte _0 = 0;
    //1:已删除
    public static final Byte _1 = 1;
    /**
     * 主键
     */
    private String id;

    /**
     * 账号
     */
    private String loginName;

    /**
     * 经销商名称
     */
    private String name;

    /**
     * 用户编号
     */
    private Long userId;

    /**
     * 删除标记
     * 0:未删除 1：已删除
     */
    private Byte delFlag;

    /**
     * 父节点
     * 0：无父节点
     */
    private String parentId;

    /**
     * 手机号码
     */
    private String phone;

    /**
     * 联系地址
     */
    private String address;

    /**
     * 返点类型
     */
    private String type;

    /**
     * 角色编号
     */
    private String roleId;

    /**
     * 登录状态(0-禁止登录，1-激活登录)
     */
    private String status;

    /**
     * 创建时间
     */
    private Date crtTime;

    /**
     * 修改时间
     */
    private Date modTime;

    private String seatNum;

    private String inviteNum;

    private String dGroup;

    public String getdGroup() {
        return dGroup;
    }

    public void setdGroup(String dGroup) {
        this.dGroup = dGroup;
    }

    public String getSeatNum() {
        return seatNum;
    }

    public void setSeatNum(String seatNum) {
        this.seatNum = seatNum;
    }

    public String getInviteNum() {
        return inviteNum;
    }

    public void setInviteNum(String inviteNum) {
        this.inviteNum = inviteNum;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
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

    public Byte getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Byte delFlag) {
        this.delFlag = delFlag;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
