package com.sojson.common.utils;/**
 * @Author: hy
 * @Description:
 * @Date:${Time} ${Date}
 **/

/**
 * @ClassName:IdCardVaild
 * @Description:验证公共类
 * @Author:yamol
 * @Date:2018-8-20 21:59
 * @VERSION: 1.0
 */
public class VaildUtils {
    //第一代身份证正则表达式(15位)
    static String isIDCard1 = "^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    //第二代身份证正则表达式(18位)
    static String isIDCard2 ="^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[A-Z])$";

    /**
     * 身份证验证
     * @param cardcode 身份证号码
     * @return true 表示合法，false表示不合法
     */
    public static boolean cardCodeValid(String cardcode) {
        //验证身份证
        if (cardcode.matches(isIDCard1) || cardcode.matches(isIDCard2)) {
            return true;
        }
        return false;
    }
}
