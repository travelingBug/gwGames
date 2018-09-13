package com.sojson.common.utils;
import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName:CommonVal
 * @Description:TODO
 * @Author:yamol
 * @Date:2018-9-11 23:42
 * @VERSION: 1.0
 */
public class CommonVal {
    public static Map<String,Byte> BUSINESS_FLAG = new HashMap<String,Byte>();
    static{
        BUSINESS_FLAG.put("买入",(byte)0);
        BUSINESS_FLAG.put("卖出",(byte)1);
    }
}