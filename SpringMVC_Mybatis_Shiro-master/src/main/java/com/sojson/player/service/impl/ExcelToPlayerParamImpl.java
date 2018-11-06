package com.sojson.player.service.impl;

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
 * @Description:导入选手基本信息
 * @Author:yamol
 * @Date:2018-9-11 22:59
 * @VERSION: 1.0
 */
public class ExcelToPlayerParamImpl implements IExcelToBeanParam {

    private List<TbPlayer> playes = new ArrayList<TbPlayer>();
    String numReg="^\\d+$";
    String moneyReg="^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d)*)?$";
    @Override
    public ResultMessage validExcelCol(Object[] cols) {


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
