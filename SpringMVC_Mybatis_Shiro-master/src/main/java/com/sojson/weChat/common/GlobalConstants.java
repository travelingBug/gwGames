package com.sojson.weChat.common;

import java.util.Properties;

public class GlobalConstants {

    public static Properties interfaceUrlProperties;

    public static String getInterfaceUrl(String key) {
        return (String) interfaceUrlProperties.get(key);
    }
    /**
     * 微信域名地址
     */
    private static final String API_BASE_URL = "https://api.weixin.qq.com";

    /**
     * 获取 token 的 url
     */
    public static final String TOKEN =API_BASE_URL + "/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
}
