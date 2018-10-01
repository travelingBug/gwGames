package com.sojson.inf.gainsinfo.utis;

import com.sojson.common.model.dto.PlayerTopInfo;

import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName:GainsInfoCache
 * @Description:缓存信息
 * @Author:yamol
 * @Date:2018-9-23 21:42
 * @VERSION: 1.0
 */
public class GainsInfoCache {
    /**
     * 总排行榜
     */
    private static List<PlayerTopInfo> topForAll = new ArrayList();

    /**
     * 总收益排行
     */
    private static List<PlayerTopInfo> topForAllByMoney = new ArrayList();

    /**
     * 月排行榜
     */
    private static List<PlayerTopInfo> topForMonth = new ArrayList();

    public static byte[] lock = new byte[0];


    public static void putTopForAllByMoney(List<PlayerTopInfo> topAllByMoney){
        synchronized (lock) {
            topForAllByMoney.clear();
            topForAllByMoney.addAll(topAllByMoney);
        }
    }

    public static List<PlayerTopInfo>  getTopAllByMoneyForSize(int size){
        List<PlayerTopInfo> topForYour = new ArrayList<PlayerTopInfo>();
        synchronized (lock) {
            if (size > 0) {
                int i = 0;
                for (PlayerTopInfo playerTopInfo : topForAllByMoney) {
                    if (topForAllByMoney.size() > i && size > i) {
                        topForYour.add(playerTopInfo);
                    }

                    i++;
                }
            }
        }
        return topForYour;
    }


    public static void putTopForAll(List<PlayerTopInfo> topAll){
        synchronized (lock) {
            topForAll.clear();
            topForAll.addAll(topAll);
        }
    }

    public static List<PlayerTopInfo>  getTopAllForSize(int size){
        List<PlayerTopInfo> topForYour = new ArrayList<PlayerTopInfo>();
        synchronized (lock) {
            if (size > 0) {
                int i = 0;
                for (PlayerTopInfo playerTopInfo : topForAll) {
                    if (topForAll.size() > i && size > i) {
                        topForYour.add(playerTopInfo);
                    }

                    i++;
                }
            }
        }
        return topForYour;
    }

    public static void putTopForMonth(List<PlayerTopInfo> topMonth){
        synchronized (lock) {
            topForMonth.clear();
            topForMonth.addAll(topMonth);
        }
    }

    public static List<PlayerTopInfo>  getTopMonthForSize(int size){
        List<PlayerTopInfo> topForYour = new ArrayList<PlayerTopInfo>();
        synchronized (lock) {
            if (size > 0) {
                int i = 0;
                for (PlayerTopInfo playerTopInfo : topForMonth) {
                    if (topForMonth.size() > i && size > i) {
                        topForYour.add(playerTopInfo);
                    }
                    i++;
                }
            }
        }
        return topForYour;
    }

}
