package com.sojson.inf.vips.service;

import com.sojson.common.ResultMessage;
import com.sojson.common.model.TbVipRecord;
import com.sojson.common.model.TbVipsCard;
import com.sojson.common.model.TbVipsOrder;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
public interface VipsBankCardService {

    ResultMessage insert(TbVipsCard entity);

    ResultMessage delete(String cardNo);

    List<TbVipsCard> findList(Map<String,String> params);

    ResultMessage addOrder(TbVipsOrder entity, HttpServletRequest req);

    List<TbVipRecord> findRecord(Map<String,Object> map);

    ResultMessage sendBankSmsCode(TbVipsCard entity);

    ResultMessage insertUpay(TbVipsOrder entity, HttpServletRequest req);

    ResultMessage insertUpaySuccess(String orderNo, String orderMoney, HttpServletRequest req);
}
