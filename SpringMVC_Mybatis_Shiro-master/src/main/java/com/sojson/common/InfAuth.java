package com.sojson.common;

import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName:InfAuth
 * @Description:TODO
 * @Author:yamol
 * @Date:2018-9-26 0:54
 * @VERSION: 1.0
 */
public class InfAuth {

    public static List<String> NEED_LOGIN = new ArrayList<String>();
    static{
        NEED_LOGIN.add("interface/gainsInfo/getStrategy.shtml");
        NEED_LOGIN.add("interface/gainsInfo/getTransactionInfo.shtml");
        NEED_LOGIN.add("interface/gainsInfo/validLevel.shtml");
        NEED_LOGIN.add("interface/gainsInfo/addfollow.shtml");
        NEED_LOGIN.add("interface/gainsInfo/cancelFollow.shtml");
        NEED_LOGIN.add("interface/gainsInfo/getNickName.shtml");
    }
}
