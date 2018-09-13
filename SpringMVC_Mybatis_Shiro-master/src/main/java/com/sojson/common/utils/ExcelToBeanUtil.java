package com.sojson.common.utils;

import com.sojson.common.IExcelToBeanParam;
import com.sojson.common.ResultMessage;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.*;

/**
 * Created by hy on 2016/7/7.
 */
public class ExcelToBeanUtil {

    public static String COMMONS_XLS = ".xls";

    public static String COMMONS_XLSX = ".xlsx";

    /**
     * 转换Excel中的数据为对象
     * @param filePath Excle的路径
     * @param heahReal 映射关系
     * @param cls  转换的对象
     * @param sheetNum 读取的工作区间
     * @return   返回消息结果
     * @throws Exception
     */
    public static ResultMessage changeExcelToPo(String filePath, LinkedHashMap<String,String> heahReal,LinkedHashMap<String,IFormatExcel> headValue, Class cls, int sheetNum,IExcelToBeanParam param) throws Exception{
        //返回结果集
        Map<Byte,Object> result = new HashMap<Byte,Object>();
        List<Object[]> datas = null;
        //根据文件格式，读取对应的Excel数据
        if (filePath.toLowerCase().endsWith(COMMONS_XLS)) {
            datas = ExcelUtil.readXls(filePath,sheetNum);
        } else if (filePath.toLowerCase().endsWith(COMMONS_XLSX)) {
            datas = ExcelUtil.readXlsx(filePath,sheetNum);
        } else {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"文件格式不匹配");
        }

        if (datas == null || datas.size() <= 0) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"未获取到相关数据");
        }

        //获取表头*************************BGN*************************

        //定义表头的属性
        String[] headAttr = new String[datas.get(0).length];
        //表头映射长度验证
        if (heahReal != null && heahReal.size() > 0) {
            //如果映射关系不为空，但是表头长度对不上，则返回错
            if (heahReal.size() != headAttr.length) {
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "映射关系错误,映射字段和表头长度字段不对应");
            }
        } else {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "表头转换配置不正确");
        }

        //获取表头信息
        int headNum = 0;
        for (Object obj : datas.get(0)) {
            if(obj == null || "".equals(obj.toString().trim())){
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "表头不能有空数据");
            }
            //需要转换为映射关系
            String title = obj.toString().trim();
            if(!heahReal.containsKey(title)){
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "找不到对应表头的映射关系");
            }
            title = heahReal.get(title);
            headAttr[headNum++] = title;
        }
        //获取表头*************************END*************************

        //数据验证*************************BGN*************************
        //生成对象存放处
        List<Object> objList = new ArrayList<Object>();
        //验证错误数据存放处
        List<Object[]> errorData = new ArrayList<Object[]>();
        for (int i = 1 ; i < datas.size() ; i ++) {
            if(datas.get(i).length != headAttr.length){
                Object[] errorColum = new Object[datas.get(i).length + 1];
                //src: 源数组
                //srcPos: 从源数组复制数据的起始位置
                //dest: 目标数组
                //destPos: 复制到目标数组的起始位置
                //length: 复制的长度
                System.arraycopy(datas.get(i), 0, errorColum, 0, datas.get(i).length );
                errorColum[datas.get(i).length] = "数据列数不匹配";
                errorData.add( errorColum);
                continue;
            }
            ResultMessage colVail = param.validExcelCol(datas.get(i));
            if ( colVail.getLevel() ==  ResultMessage.MSG_LEVEL.SUCC.v){
                //验证正确的数据进行对象转换
                objList.add(chang(datas.get(i), headAttr,headValue, cls,param));
            } else { //记录验证没有通过的行数和错误原因 ,第一个为行数，第二个为错误原因
                Object[] errorColum = new Object[datas.get(i).length + 1];
                //src: 源数组
                //srcPos: 从源数组复制数据的起始位置
                //dest: 目标数组
                //destPos: 复制到目标数组的起始位置
                //length: 复制的长度
                System.arraycopy(datas.get(i), 0, errorColum, 0, datas.get(i).length );
                errorColum[datas.get(i).length] = colVail.getMessageText();
                errorData.add( errorColum);
            }
        }
        //把验证没通过的行给放进去
        result.put(ResultMessage.MSG_LEVEL.FAIL.v, errorData);
        //把转换正确的数据放进来
        result.put(ResultMessage.MSG_LEVEL.SUCC.v, objList);

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"转换成功",result);
    }



    /**
     * 转换方法
     * @param setMethod
     * @param value
     * @param obj
     * @throws Exception
     */
    private static void setVal(Method setMethod , Object value,Object obj,IExcelToBeanParam param) throws Exception{
        String type = setMethod.getParameterTypes()[0].getName();
        //为空时，则不需要设置就会为空
        if (value != null) {
            String str = value.toString();
            //如果值是空字符串，且是字符型型时才设置，否则也不用设置
            if("".equals(str) ){
                if( "java.lang.String".equals(type)){
                    setMethod.invoke(obj, str);
                }
            } else {
                if ("java.lang.String".equals(type)) {
                    setMethod.invoke(obj, str);
                }else  if ("java.lang.Integer".equals(type)){
                    //EXCEL返回类型的异常处理
                    if (str.endsWith(".0")) {
                        str = str.substring(0,str.length() - 2);
                    }
                    setMethod.invoke(obj, Integer.parseInt(str));
                }else  if ("java.lang.Double".equals(type)){
                    //EXCEL返回类型的异常处理
                    if (str.endsWith(".0")) {
                        str = str.substring(0,str.length() - 2);
                    }
                    setMethod.invoke(obj, Double.parseDouble(str));
                }else  if ("java.lang.Byte".equals(type)){
                    //EXCEL返回类型的异常处理
                    if (str.endsWith(".0")) {
                        str = str.substring(0,str.length() - 2);
                    }
                    setMethod.invoke(obj, Byte.parseByte(str));
                }else  if ("java.lang.Long".equals(type)){
                    //EXCEL返回类型的异常处理
                    if (str.endsWith(".0")) {
                        str = str.substring(0,str.length() - 2);
                    }
                    setMethod.invoke(obj, Long.parseLong(str));
                }else  if ("java.util.Date".equals(type)){
                    setMethod.invoke(obj, DateUtil.stringToDate(value.toString(),DateUtil.DATETIME_PATTERN));
                } else {
                    //其他自定义的值重写这个方法
                    param.setValOtherType(setMethod, type, obj, value);
                }
            }
        }

    }



    /**
     * 转换时间
     * @param data 数据
     * @param headName 头信息
     * @param cls 转换对象的class
     * @return  生成的对象
     * @throws Exception
     */
    public static Object chang(Object[] data,String[] headName,LinkedHashMap<String,IFormatExcel> headValue,Class cls,IExcelToBeanParam param)throws Exception{
        List<Object> objList = new ArrayList<Object>();
        //生成一个对象
        Object obj = cls.newInstance();
        int j = 0;
        for (String attrName : headName) {
            PropertyDescriptor pd = new PropertyDescriptor(attrName,obj.getClass());
            Method setMethod = pd.getWriteMethod();//获得set方法
            //转换需要保存的数据方法
            Object valueObj = data[j];
            if (headValue != null && data[j] != null && headValue.get(attrName) != null) {
                data[j] = headValue.get(attrName).format(data[j].toString());
            }
            setVal(setMethod, data[j], obj,param);//执行set方法
            j++;
        }
        return obj;
    }
}
