package com.sojson.common;

/**
 * @Author: hy
 * @Description: 常量信息
 **/
public interface IConstant {


    /**
     * 是或否
     * 1：是
     * 0：否
     */
    public enum YES_OR_NO {
        /** 是 */
        YES((byte)1),
        /** 否 */
        NO((byte)0);

        public byte v;
        private YES_OR_NO(byte v) {
            this.v = v;
        }
    }

    /**
     * 交易标志
     * 0:证券买入
     * 1:证券卖出
     * 2:证券买入
     * 3:证券卖出
     */
    public enum BUSINESS_FLAG {
        /** 证券买入 */
        BOND_BUY((byte)0),
        /** 证券卖出 */
        BOND_SELL((byte)1),
        /** 基金申购 */
        FUND_BUY((byte)2),
        /** 基金赎回 */
        FUND_SELL((byte)3);

        public byte v;
        private BUSINESS_FLAG(byte v) {
            this.v = v;
        }
    }


    /**
     * 审核状态
     * 0:未审核 1：审核通过 2：审核不通过
     */
    public enum AUDIT_STATUS {
        /** 未审核 */
        WAIT_AUDIT((byte)0),
        /** 审核通过*/
        AUDIT_SUCC((byte)1),
        /**审核不通过*/
        AUDIT_FAIL((byte)2);

        public byte v;
        private AUDIT_STATUS(byte v) {
            this.v = v;
        }
    }

    /**
     * 位置标示
     * 0:banner首页横幅
     * 1:广告
     */
    public enum PATH_FLAG {
        /** 首页横幅 */
        BANNER((byte)0),
        /** 首页广告 */
        ADVERT_HOME((byte)1),
        /** 底部广告 */
        ADVERT_BOTTOM((byte)2),
        /** 移横幅动端 */
        BANNER_PHONE((byte)3);

        public byte v;
        private PATH_FLAG(byte v) {
            this.v = v;
        }
    }

    /**
     * VIP类型
     * 1:5000-A 2：2000-B 3：500-C
     */
    public enum VIP_LEVEL {
        /**0*/
        VIP_0((byte)0),
        /** 5000-A  */
        VIP_A((byte)1),
        /** 2000-B*/
        VIP_B((byte)2),
        /**500-C*/
        VIP_C((byte)3);

        public byte v;
        private VIP_LEVEL(byte v) {
            this.v = v;
        }
    }

    /**
     * 排行榜类型
     * 0、总收益率排行榜
     * 1、月收益率排行榜
     */
    public enum TOP_TYPE {
        /** 月收益率排行榜 */
        MONTH((byte)1),
        /** 总收益率排行榜 */
        ALL((byte)0);

        public byte v;
        private TOP_TYPE(byte v) {
            this.v = v;
        }
    }

    /**
     * 默认key
     */
    String key = "tJjwxDz4WF0Sf9JT";
    /**
     * 游客sessionID
     */
    String defSessionId = "visitor";

    /**
     * 本金
     */
    Long capital = 300000L;

    //父类ID
    String parentId = "0";

    /**
     * token开头标示
     */
    String TOKEN_PRE="tk:";
}
