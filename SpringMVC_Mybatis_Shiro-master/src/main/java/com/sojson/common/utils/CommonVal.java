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
        BUSINESS_FLAG.put("证券买入",(byte)0);
        BUSINESS_FLAG.put("证券卖出",(byte)1);
        BUSINESS_FLAG.put("基金申购",(byte)2);
        BUSINESS_FLAG.put("基金赎回",(byte)3);
        BUSINESS_FLAG.put("融券回购",(byte)4);
    }
}