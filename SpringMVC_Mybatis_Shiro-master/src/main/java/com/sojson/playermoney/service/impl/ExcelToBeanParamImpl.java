package com.sojson.playermoney.service.impl;

import com.sojson.common.IExcelToBeanParam;
import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.utils.CommonVal;
import com.sojson.common.utils.DateUtil;
import com.sojson.common.utils.StringUtils;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**

/**
 * @ClassName:ExcelToBeanParamImpl
 * @Description:TODO
 * @Author:yamol
 * @Date:2018-9-11 22:59
 * @VERSION: 1.0
 */
public class ExcelToBeanParamImpl implements IExcelToBeanParam {

    private List<TbPlayer> playes = new ArrayList<TbPlayer>();
    String numReg="^\\d+$";
    String moneyReg="^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d)*)?$";
    @Override
    public ResultMessage validExcelCol(Object[] cols) {
        //时间
        if (StringUtils.isBlank(cols[0])) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"时间不能为空！");
        }
        try {
            //操作时间格式验证
            Date date = DateUtil.stringToDate(cols[0].toString(), DateUtil.DATETIME_PATTERN);
            if (date == null) {
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"时间格式错误！");
            }
        }catch (Exception e){
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"时间格式错误！");
        }

        //资金账户
        if (cols[1] == null || StringUtils.isBlank(cols[1].toString())) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"资金账号不正确！");
        }
        //验证资金账户
        if (playes != null && playes.size() > 0) {
            boolean flag = true;
            for (TbPlayer player : playes) {
                if (player.getAccount().equals(cols[1].toString())) {
                    flag = false;
                    break;
                }
            }
            if (flag) {
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"此资金账户没有对应参赛选手！");
            }

        }


        //资金余额
        if (StringUtils.isBlank(cols[2]) || !cols[2].toString().matches(moneyReg)) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"资金余额只能为数字且最多包含2位小数！");
        }

        //总资产
        if (StringUtils.isBlank(cols[3]) || !cols[3].toString().matches(moneyReg)) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"总资产只能为数字且最多包含2位小数！");
        }


        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
    }

    @Override
    public void setValOtherType(Method setMethod, String type, Object obj, Object value) {

    }

    public List<TbPlayer> getPlayes() {
        return playes;
    }

    public void setPlayes(List<TbPlayer> playes) {
        this.playes = playes;
    }
}
