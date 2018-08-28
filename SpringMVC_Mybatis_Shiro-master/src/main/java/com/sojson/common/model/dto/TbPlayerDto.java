package com.sojson.common.model.dto;

import com.sojson.common.model.TbPlayer;

import java.io.Serializable;
import java.util.Date;


public class TbPlayerDto extends TbPlayer implements Serializable{
    //验证码
    private String verfiCode;

    public String getVerfiCode() {
        return verfiCode;
    }

    public void setVerfiCode(String verfiCode) {
        this.verfiCode = verfiCode;
    }
}