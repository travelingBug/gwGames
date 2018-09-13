package com.sojson.common;

import com.sojson.common.utils.CommonVal;
import com.sojson.common.utils.IFormatExcel;

import java.util.LinkedHashMap;

/**
 * @ClassName:ImportHeader
 * @Description:导入表头
 * @Author:yamol
 * @Date:2018-9-11 23:01
 * @VERSION: 1.0
 */
public class ImportHeader {
    public static LinkedHashMap<String,String> gainsInfoHeadReal = new LinkedHashMap<String,String>();
    static{
        gainsInfoHeadReal.put("操作时间","businessTime");
        gainsInfoHeadReal.put("身份证","idCard");
        gainsInfoHeadReal.put("股票代码","sharesCode");
        gainsInfoHeadReal.put("股票名称","sharesNmae");
        gainsInfoHeadReal.put("买卖标志","businessFlag");
        gainsInfoHeadReal.put("成交数量","volume");
        gainsInfoHeadReal.put("成交价格","price");
        gainsInfoHeadReal.put("总资产","totalMoney");
    }

    private static LinkedHashMap<String,IFormatExcel> gainsInfoHeadFormat = new LinkedHashMap<String,IFormatExcel>();

    public static LinkedHashMap<String,IFormatExcel> getGainsInfoHeadFormat(){
        if (gainsInfoHeadFormat.size() < 1) {
            gainsInfoHeadFormat.put("businessFlag",new IFormatExcel(){
                public Object format(String key){
                    return CommonVal.BUSINESS_FLAG.get(key);
                }
            });
        }
        return gainsInfoHeadFormat;
    }
}
