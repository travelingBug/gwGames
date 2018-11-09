package com.sojson.player.service.impl;

import com.sojson.common.IExcelToBeanParam;
import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.utils.DateUtil;
import com.sojson.common.utils.StringUtils;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**

/**
 * @ClassName:ExcelToBeanParamImpl
 * @Description:导入选手基本信息
 * @Author:yamol
 * @Date:2018-9-11 22:59
 * @VERSION: 1.0
 */
public class ExcelToPlayerParamCapImpl implements IExcelToBeanParam {

    private List<TbPlayer> playes = new ArrayList<TbPlayer>();

    String numReg="^\\d+$";
    String moneyReg="^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d)*)?$";
    @Override
    public ResultMessage validExcelCol(Object[] cols) {
        if (cols == null || cols.length < 2 || cols.length > 2) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"当前行数据错误！");
        }
        //资金账户
        if (StringUtils.isBlank(cols[0])) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"资金账号不能为空！");
        }

        //验证资金账户
        if (playes != null && playes.size() > 0) {
            boolean flag = true;
            for (TbPlayer player : playes) {
                if (player.getAccount().equals(cols[0].toString())) {
                    flag = false;
                    break;
                }
            }
            if (flag) {
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"此资金账户没有对应参赛选手！");
            }

        }

        //本金
        if (StringUtils.isBlank(cols[1]) || !cols[1].toString().matches(moneyReg)) {
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"本金格式错误！");
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
