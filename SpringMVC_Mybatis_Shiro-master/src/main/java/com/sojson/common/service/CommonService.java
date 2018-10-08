package com.sojson.common.service;

import javax.servlet.http.HttpServletRequest;

/**
 * @Author: hy
 * @Description:
 * @Date:${Time} ${Date}
 **/
public interface CommonService {
    String getTimeByToken(HttpServletRequest request) throws Exception;

    String getUserPhone(HttpServletRequest request) throws Exception;

    public String getNickName(HttpServletRequest request) throws Exception;

    public String getToken(HttpServletRequest request) throws Exception;
}
