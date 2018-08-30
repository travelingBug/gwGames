package com.sojson.common.model.dto;

import com.sojson.common.model.TbPlayer;

import java.io.Serializable;
import java.util.Date;


public class TbPlayerDto extends TbPlayer implements Serializable{
    //验证码
    private String verfiCode;

    //模糊匹配Name
    private String findContent;

    public String getVerfiCode() {
        return verfiCode;
    }

    public void setVerfiCode(String verfiCode) {
        this.verfiCode = verfiCode;
    }

    public String getFindContent() {
        return findContent;
    }

    public void setFindContent(String findContent) {
        this.findContent = findContent;
    }
}