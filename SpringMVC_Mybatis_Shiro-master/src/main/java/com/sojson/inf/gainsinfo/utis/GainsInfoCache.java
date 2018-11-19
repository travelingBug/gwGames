package com.sojson.inf.gainsinfo.utis;

import com.sojson.common.IConstant;
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

    /**
     * 获取排行榜的倒数
     * @param size
     * @return
     */
    public static List<PlayerTopInfo>  getLastTopAllForSize(int size){
        List<PlayerTopInfo> topForYour = new ArrayList<PlayerTopInfo>();
        synchronized (lock) {
            if (size > 0) {
                int c = 0;
                for (int i = topForAll.size() - 1; i >= 0  ;i--) {
                    if (topForAll.size() > c && size > c && i >= 30) {
                        topForYour.add(topForAll.get(i));
                    }
                    c ++;
                }
            }
        }
        return topForYour;
    }

    /**
     * 清理是否为新的标记
     */
    public static void  clearTopAllNewFlag(){
        synchronized (lock) {
             for (PlayerTopInfo playerTopInfo : topForAll) {
                 playerTopInfo.setIsNewFlag(IConstant.YES_OR_NO.NO.v);
             }
        }
    }

    /**
     * 分页查询内存数据
     * @param pageSize
     * @param pageNo
     * @return
     */
    public static List<PlayerTopInfo>  getTopAllByPage(int pageSize,int pageNo){
        List<PlayerTopInfo> topForYour = new ArrayList<PlayerTopInfo>();
        int end = pageSize * pageNo;
        int start = (pageNo - 1) * pageSize;
        synchronized (lock) {
            int i = 0;
            for (PlayerTopInfo playerTopInfo : topForAll) {
                if (topForAll.size() > i && i >= start && i < end) {
                    topForYour.add(playerTopInfo);
                }

                i++;
            }
        }
        return topForYour;
    }

    /**
     * 分页查询当前用户关注的数据
     * @param pageSize
     * @param pageNo
     * @return
     */
    public static List<PlayerTopInfo>  getTopAllByAccount(List<PlayerTopInfo> topAllByAccount,int pageSize,int pageNo){
        List<PlayerTopInfo> topForYour = new ArrayList<PlayerTopInfo>();
        int end = pageSize * pageNo;
        int start = (pageNo - 1) * pageSize;
        int i = 0;
        for (PlayerTopInfo playerTopInfo : topAllByAccount) {
            if (topAllByAccount.size() > i && i >= start && i < end) {
                topForYour.add(playerTopInfo);
            }

            i++;
        }
        return topForYour;
    }

    public static int  getTopAllSize(){
        return topForAll.size();
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

    public static int  getTopMonthSize(){
        return topForMonth.size();
    }

    public static List<PlayerTopInfo>  getTopMonthByPage(int pageSize,int pageNo){
        List<PlayerTopInfo> topForYour = new ArrayList<PlayerTopInfo>();
        int end = pageSize * pageNo;
        int start = (pageNo - 1) * pageSize;
        synchronized (lock) {
            int i = 0;
            for (PlayerTopInfo playerTopInfo : topForMonth) {
                if (topForMonth.size() > i && i >= start && i < end) {
                    topForYour.add(playerTopInfo);
                }

                i++;
            }
        }
        return topForYour;
    }

    /**
     * 获取月排行榜的倒数
     * @param size
     * @return
     */
    public static List<PlayerTopInfo>  getLastTopMonthSize(int size){
        List<PlayerTopInfo> topForYour = new ArrayList<PlayerTopInfo>();
        synchronized (lock) {
            if (size > 0) {
                int c = 0;
                for (int i = topForMonth.size() - 1; i >= 0  ;i--) {
                    if (topForMonth.size() > c && size > c && i >= 30) {
                        topForYour.add(topForMonth.get(i));
                    }
                    c ++;
                }
            }
        }
        return topForYour;
    }

    /**
     *
     * @param account
     * @return
     */
    public static PlayerTopInfo  getPlayer4account(String account){
        synchronized (lock) {
            for (PlayerTopInfo playerTopInfo : topForAll){
                if (playerTopInfo.getAccount().equals(account)) {
                    return playerTopInfo;
                }
            }
        }
        return null;
    }

    /**
     * 清理是否为新的标记
     */
    public static void  clearTopMonthNewFlag(){
        synchronized (lock) {
            for (PlayerTopInfo playerTopInfo : topForMonth) {
                playerTopInfo.setIsNewFlag(IConstant.YES_OR_NO.NO.v);
            }
        }
    }


    /**
     * 更新new标记
     * @param accounts 需要更新的账户信息
     */
    public static void updateNewFlag(List<String> accounts){
        synchronized (lock) {
            for (PlayerTopInfo playerTopInfo : topForAll) {
                for (String account : accounts) {
                    if (account.equals(playerTopInfo.getAccount())) {
                        playerTopInfo.setIsNewFlag(IConstant.YES_OR_NO.YES.v);
                    }
                }
            }

            for (PlayerTopInfo playerTopInfo : topForMonth) {
                for (String account : accounts) {
                    if (account.equals(playerTopInfo.getAccount())) {
                        playerTopInfo.setIsNewFlag(IConstant.YES_OR_NO.YES.v);
                    }
                }
            }
        }
    }

}
