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

}
