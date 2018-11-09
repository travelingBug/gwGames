package com.sojson.common;

import com.sojson.common.utils.CommonVal;
import com.sojson.common.utils.IFormatExcel;

import java.math.BigDecimal;
import java.text.DecimalFormat;
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
        gainsInfoHeadReal.put("资金账号","account");
        gainsInfoHeadReal.put("股票代码","sharesCode");
        gainsInfoHeadReal.put("股票名称","sharesName");
        gainsInfoHeadReal.put("买卖标志","businessFlag");
        gainsInfoHeadReal.put("成交数量","volume");
        gainsInfoHeadReal.put("成交价格","price");
        gainsInfoHeadReal.put("成交总金额","amount");
//        gainsInfoHeadReal.put("资金余额","balanceMoney");
//        gainsInfoHeadReal.put("总资产","totalMoney");

    }

    private static LinkedHashMap<String,IFormatExcel> gainsInfoHeadFormat = new LinkedHashMap<String,IFormatExcel>();

    public static LinkedHashMap<String,IFormatExcel> getGainsInfoHeadFormat(){
        if (gainsInfoHeadFormat.size() < 1) {
            gainsInfoHeadFormat.put("businessFlag",new IFormatExcel(){
                public Object format(String key){
                    return CommonVal.BUSINESS_FLAG.get(key);
                }
            });
            gainsInfoHeadFormat.put("price",new IFormatExcel(){
                public Object format(String key){
                    BigDecimal bg = new BigDecimal(key);
                    return new DecimalFormat("#.00").format(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                }
            });
            gainsInfoHeadFormat.put("amount",new IFormatExcel(){
                public Object format(String key){
                    BigDecimal bg = new BigDecimal(key);
                    return new DecimalFormat("#.00").format(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                }
            });
        }
        return gainsInfoHeadFormat;
    }

    public static LinkedHashMap<String,String> playerMoneyHeadReal = new LinkedHashMap<String,String>();
    static{
        playerMoneyHeadReal.put("时间","businessTime");
        playerMoneyHeadReal.put("资金账号","account");
        playerMoneyHeadReal.put("资金余额","balanceMoney");
        playerMoneyHeadReal.put("总资产","totalMoney");

    }

    private static LinkedHashMap<String,IFormatExcel> playerMoneyHeadFormat = new LinkedHashMap<String,IFormatExcel>();

    public static LinkedHashMap<String,IFormatExcel> getPlayerMoneyHeadFormat(){
        if (playerMoneyHeadFormat.size() < 1) {
            playerMoneyHeadFormat.put("balanceMoney",new IFormatExcel(){
                public Object format(String key){
                    BigDecimal bg = new BigDecimal(key);
                    return new DecimalFormat("#.00").format(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                }
            });
            playerMoneyHeadFormat.put("totalMoney",new IFormatExcel(){
                public Object format(String key){
                    BigDecimal bg = new BigDecimal(key);
                    return new DecimalFormat("#.00").format(bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() );
                }
            });
        }
        return playerMoneyHeadFormat;
    }

    public static LinkedHashMap<String,String> playerHeadReal = new LinkedHashMap<String,String>();
    static{
        playerHeadReal.put("昵称","accountName");
        playerHeadReal.put("姓名","name");
        playerHeadReal.put("资金账号","account");
        playerHeadReal.put("身份证","idCard");
        playerHeadReal.put("手机号码","telPhone");

    }

    private static LinkedHashMap<String,IFormatExcel> playerHeadFormat = new LinkedHashMap<String,IFormatExcel>();

    public static LinkedHashMap<String,IFormatExcel> getPlayerHeadFormat(){

        return playerHeadFormat;
    }


    public static LinkedHashMap<String,String> playerCapitalReal = new LinkedHashMap<String,String>();
    static{
        playerCapitalReal.put("资金账号","account");
        playerCapitalReal.put("本金","capital");

    }

    private static LinkedHashMap<String,IFormatExcel> playerCapitalFormat = new LinkedHashMap<String,IFormatExcel>();

    public static LinkedHashMap<String,IFormatExcel> getPlayerCapitalFormat(){

        return playerCapitalFormat;
    }
}
