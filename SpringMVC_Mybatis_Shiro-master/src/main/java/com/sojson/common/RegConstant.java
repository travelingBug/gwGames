package com.sojson.common;

/**
 * @Author: hy
 * @Description: 常用正则
 **/
public interface RegConstant {
    //纯数字
    String numReg="^\\d+$";

    //钱（2位小数）
    String moneyReg="^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,2})?$";

}
