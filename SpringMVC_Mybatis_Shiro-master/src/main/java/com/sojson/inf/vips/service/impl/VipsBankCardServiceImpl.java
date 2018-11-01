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
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

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
            String fee = entity.getFee();
            if ("3".equals(fee)) {

//                entity.setFee("500");
            } else if ("2".equals(fee)) {
//                entity.setFee("2000");
            } else if ("1".equals(fee)) {
//                entity.setFee("5000");
            }
            entity.setFee("0.5");

            if("p1".equals(entity.getStep())){
                entity.setStatus(0);
                int id = uTbVipsOrderMapper.insert(entity);
            }

            Map<String, String> map = HttpClientUtils.createData();
            map.put("out_trade_no", entity.getOrderNo());
            map.put("orderBody", entity.getOrderTitle());
            map.put("out_trade_date", entity.getOrderDate());
            map.put("mercUserNo", entity.getVipId());

            map.put("total_fee", entity.getFee());
            map.put("bank_code", entity.getBankCode());
            map.put("cardNo", entity.getCardNo());
            map.put("cardNm", entity.getCardName());
            map.put("idNo", entity.getIdNo());
            map.put("mblNo", entity.getPhone());
            if("p3".equals(entity.getStep())){
                map.put("smsCode", entity.getSmsCode());
            }else{
                map.put("smsCode", "");
            }
            map.put("step", entity.getStep());

            String msg = HttpClientUtils.sendReq(map);
            JSONObject obj = JSONObject.fromObject(msg);

            if ((!"".equals(entity.getSmsCode())) && "p3".equals(entity.getStep())) {

                if(!obj.get("PayStatus").equals("PAY_SUCCESS")){
                    return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "支付失败");
                }else {

                    String phone = commonService.getUserPhone(req);
                    TbVips vip = new TbVips();
                    vip.setPhone(phone);
                    TbVips curVip = uTbVipsMapper.findUserByPhone(vip);
                    if ("3".equals(fee)) {
                        vip.setEndTime(DateUtil.getDate(22));
                        vip.setLevel(IConstant.VIP_LEVEL.VIP_C.v);
                        vip.setSurplusDay(22);
                    } else if ("2".equals(fee)) {
                        if (curVip.getLevel().toString().equals("0")) {
                            vip.setEndTime(DateUtil.getDate(22));
                            vip.setSurplusDay(22);
                        } else if (curVip.getLevel().toString().equals("3")) {
                            vip.setSurplusDay(upgrade(curVip.getSurplusDay(),"3", "2"));
                        }
                        vip.setLevel(IConstant.VIP_LEVEL.VIP_B.v);
                    } else if ("1".equals(fee)) {
                        if (curVip.getLevel().toString().equals("0")) {
                            vip.setEndTime(DateUtil.getDate(22));
                            vip.setSurplusDay(22);
                        } else if (curVip.getLevel().toString().equals("3")) {
                            vip.setSurplusDay(upgrade(curVip.getSurplusDay(), "3", "1"));
                        } else if (curVip.getLevel().toString().equals("2")) {
                            vip.setSurplusDay(upgrade(curVip.getSurplusDay(), "2", "1"));
                        }
                        vip.setLevel(IConstant.VIP_LEVEL.VIP_A.v);
                    }

                    TbVipRecord record = new TbVipRecord();
                    record.setLevel(vip.getLevel());
                    record.setVipId(curVip.getId());
                    record.setAmount(entity.getFee());
                    uTbVipRecordMapper.addRecord(record);
                    uTbVipsMapper.update(vip);
                    uTbVipsOrderMapper.update(entity);
                }

                return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "支付成功");
            }
        }catch (Exception e){
            e.getStackTrace();
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "创建订单失败");
        }

        return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "请输入验证码", entity.getOrderNo());
    }

    private int upgrade(int surplusDay, String oldLevel, String newLevel){
        try {
//            long nd = 1000 * 60 * 60 * 24;
//            long nh = 1000 * 60 * 60;
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//            long oldEndTime = sdf.parse(endTime).getTime();
//            long nowTime = new Date().getTime();
//            Date newDate = sdf.parse(DateUtil.getDate(22));
//
//            long diff = oldEndTime-nowTime;
//            long day = diff / nd;
//            long hour = diff % nd / nh;
//            int hours = 0;
//
//            //C类升级
//            if(oldLevel.equals("3")){
//                if(newLevel.equals("2")){
//                    hours = Math.round((day*24+hour)/4);
//                }else if(newLevel.equals("1")){
//                    hours = Math.round((day*24+hour)/10);
//                }
//            }
//            //B类升级
//            if(oldLevel.equals("2")){
//                if(newLevel.equals("1")){
//                    hours = (int) Math.round((day*24+hour)/2.5);
//                }
//            }
//
//            Calendar calendar = new GregorianCalendar();
//            calendar.setTime(newDate);
//            calendar.add(Calendar.HOUR_OF_DAY, hours);
//
//            return sdf.format(calendar.getTime());

            int days = 0;
            int c = 500;
            int b = 2000;
            int a = 5000;
            int weekday = 22;
            //C类升级
            if(oldLevel.equals("3")){
                if(newLevel.equals("2")){
                    days = Math.round((c/weekday*surplusDay)/(b/weekday));
                }else if(newLevel.equals("1")){
                    days = Math.round((c/weekday*surplusDay)/(a/weekday));
                }
            }
            //B类升级
            if(oldLevel.equals("2")){
                if(newLevel.equals("1")){
                    days = Math.round((b/weekday*surplusDay)/(a/weekday));
                }
            }

            return days;
        }catch (Exception e){
            e.printStackTrace();
        }

        return 0;

    }

    @Override
    public List<TbVipRecord> findRecord(Map<String, Object> map) {
        return uTbVipRecordMapper.findAllRecord(map);
    }
}