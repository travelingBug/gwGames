package com.sojson.common;

import java.lang.reflect.Method;

/**
 * @Author: hy
 * @Description:
 * @Date:${Time} ${Date}
 **/
public interface IExcelToBeanParam {
    /**
     * 验证EXCEL每一行的数据
     * @param cols EXCEL的行数据
     * @return
     */
    ResultMessage validExcelCol(Object[] cols);

    /**
     * 转换Excel的对象
     * @param setMethod
     * @param type
     * @param obj
     * @param value
     */
    void setValOtherType(Method setMethod, String type, Object obj, Object value);
}
