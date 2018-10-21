package com.sojson.inf.vips.service.impl;

import com.sojson.common.IConstant;
import com.sojson.common.ResultMessage;
import com.sojson.common.dao.UTbVipRecordMapper;
import com.sojson.common.dao.UTbVipsBankCardMapper;
import com.sojson.common.dao.UTbVipsMapper;
import com.sojson.common.dao.UTbVipsOrderMapper;
import com.sojson.common.model.TbVipRecord;
import com.sojson.common.model.TbVips;
import com.sojson.common.model.TbVipsCard;
import com.sojson.common.model.TbVipsOrder;
import com.sojson.common.service.CommonService;
import com.sojson.common.utils.DateUtil;
import com.sojson.common.utils.HttpClientUtils;
import com.sojson.inf.vips.service.VipsBankCardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class VipsBankCardServiceImpl implements VipsBankCardService{
    @Autowired
    UTbVipsBankCardMapper uTbVipsBankCardMapper;

    @Autowired
    UTbVipsOrderMapper uTbVipsOrderMapper;

    @Autowired
    UTbVipsMapper uTbVipsMapper;

    @Autowired
    CommonService commonService;

    @Autowired
    UTbVipRecordMapper uTbVipRecordMapper;

    @Override
    public ResultMessage insert(TbVipsCard entity) {
        Map<String,String> params = new HashMap<String,String>();
        params.put("cardNo", entity.getCardNo());
        List<TbVipsCard> cards = uTbVipsBankCardMapper.findList(params);
        if(cards.size()<=0) {
            int id = uTbVipsBankCardMapper.insert(entity);
            if (id <= 0) {
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "绑定失败");
            }
        }else{
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "银行卡已经绑定");
        }
        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "绑定成功");
    }

    @Override
    public ResultMessage delete(String cardNo) {
        uTbVipsBankCardMapper.delete(cardNo);

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "解绑成功");
    }

    @Override
    public List<TbVipsCard> findList(Map<String,String> params) {
        return uTbVipsBankCardMapper.findList(params);
    }

    @Transactional
    @Override
    public ResultMessage addOrder(TbVipsOrder entity, HttpServletRequest req) {
        try {
            Map<String, String> map = HttpClientUtils.createData();
            map.put("out_trade_no", entity.getOrderNo());
            map.put("orderBody", entity.getOrderTitle());
            map.put("out_trade_date", entity.getOrderDate());
            map.put("mercUserNo", entity.getVipId());
            String fee = entity.getFee();
            if ("3".equals(fee)) {
                entity.setFee("500");
            } else if ("2".equals(fee)) {
                entity.setFee("2000");
            } else if ("1".equals(fee)) {
                entity.setFee("5000");
            }
            map.put("total_fee", entity.getFee());
            map.put("bank_code", entity.getBankCode());
            map.put("cardNo", entity.getCardNo());
            map.put("cardNm", entity.getCardName());
            map.put("idNo", entity.getIdNo());
            map.put("mblNo", entity.getPhone());
            map.put("smsCode", entity.getSmsCode());
            map.put("step", entity.getStep());

            String msg = HttpClientUtils.sendReq(map);

            if ((!"".equals(entity.getSmsCode())) && "p3".equals(entity.getStep())) {
                entity.setStatus(1);

                int id = uTbVipsOrderMapper.insert(entity);
                String phone = commonService.getUserPhone(req);
                if (id > 0) {
                    TbVips vip = new TbVips();
                    vip.setPhone(phone);
                    TbVips curVip = uTbVipsMapper.findUserByPhone(vip);
                    if ("3".equals(fee)) {
                        vip.setLevel(IConstant.VIP_LEVEL.VIP_C.v);
                    } else if ("2".equals(fee)) {
//                        if(curVip.getLevel().toString().equals("0")){
//                            vip.setEndTime(DateUtil.getDate(22));
//                        }else if(curVip.getLevel().toString().equals("3")){
//                            vip.setEndTime(DateUtil.getDate(22));
//                        }
                        vip.setLevel(IConstant.VIP_LEVEL.VIP_B.v);
                    } else if ("1".equals(fee)) {
                        vip.setLevel(IConstant.VIP_LEVEL.VIP_A.v);
                    }


                    vip.setEndTime(DateUtil.getDate(22));

                    TbVipRecord record = new TbVipRecord();
                    record.setLevel(vip.getLevel());
                    record.setVipId(curVip.getId());
                    record.setAmount(entity.getFee());
                    uTbVipRecordMapper.addRecord(record);
                    uTbVipsMapper.update(vip);
                }

                return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "支付成功");
            }
        }catch (Exception e){
            e.getStackTrace();
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "创建订单失败");
        }

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "请输入验证码");
    }

    @Override
    public List<TbVipRecord> findRecord(Map<String, Object> map) {
        return uTbVipRecordMapper.findAllRecord(map);
    }
}