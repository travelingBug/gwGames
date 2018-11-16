package com.sojson.inf.vips.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbVipRecord;
import com.sojson.common.model.TbVips;
import com.sojson.common.model.TbVipsCard;
import com.sojson.common.model.TbVipsOrder;
import com.sojson.common.service.CommonService;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.inf.vips.service.VipsBankCardService;
import com.sojson.inf.vips.service.VipsService;
import com.sojson.user.service.UUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
@Controller
@Scope(value="prototype")
@RequestMapping("interface/vipsBankCard")
public class VipsBankCardController extends BaseController {

    @Autowired
    VipsBankCardService vipsBankCardService;

    @Autowired
    CommonService commonService;

    /**
     * 新增
     *
     * @param entity
     * @return
     */
    @RequestMapping(value = "addBankCard", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage addBank(TbVipsCard entity,HttpServletRequest req){
        ResultMessage msg = null;
        try {
            String phone = commonService.getUserPhone(req);
            if(phone!=null && !phone.equals("")) {
                entity.setPhone(phone);
                msg = vipsBankCardService.insert(entity);
            }else{
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "手机号码为空");
            }
        }catch (Exception e){
            e.getStackTrace();
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "绑定失败");
        }
        return msg;
    }

    /**
     * 绑定银行卡发送验证码
     *
     * @param entity
     * @return
     */
    @RequestMapping(value = "sendBankSmsCode", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage sendBankSmsCode(TbVipsCard entity,HttpServletRequest req){
        ResultMessage msg = null;
        try {
            String phone = commonService.getUserPhone(req);
            if(phone!=null && !phone.equals("")) {
                entity.setPhone(phone);
                msg = vipsBankCardService.sendBankSmsCode(entity);
            }else{
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "手机号码为空");
            }
        }catch (Exception e){
            e.getStackTrace();
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "获取验证码失败");
        }
        return msg;
    }

    /**
     * 删除
     *
     * @param req
     * @return
     */
    @RequestMapping(value = "delBankCard", method = RequestMethod.GET)
    @ResponseBody
    public ResultMessage delBankCard(String cardNo, HttpServletRequest req) {
        return vipsBankCardService.delete(cardNo);
    }

    /**
     *
     *查询
     * @return
     */
    @RequestMapping(value = "list")
    @ResponseBody
    public List<TbVipsCard> list(HttpServletRequest req) throws Exception{
        String phone = commonService.getUserPhone(req);
        Map<String,String> params = new HashMap<>();
        params.put("phone",phone);
        List<TbVipsCard> list = vipsBankCardService.findList(params);
        return list;
    }

    @RequestMapping(value = "addOrder", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage pay(TbVipsOrder order, HttpServletRequest req){
        ResultMessage msg = null;
        try {
            String phone = commonService.getUserPhone(req);
            if(phone!=null && !phone.equals("")) {
                Map<String,String> params = new HashMap<>();
                params.put("phone",phone);
                params.put("cardNo",order.getCardNo());
                List<TbVipsCard> list = vipsBankCardService.findList(params);

                if(list.size()<=0){
                    return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "未绑定银行卡");
                }

                if(order.getStep().equals("p1")){
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSSS");
                    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
                    Date date = new Date();
                    String orderNo = sdf.format(date);
                    String orderDate = sdf1.format(date);
                    order.setOrderNo(orderNo);
                    order.setOrderDate(orderDate);
                }else{
                    if(order.getOrderNo().equals("undefined") || order.getOrderNo().equals("")){
                        return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "支付验证码输入错误");
                    }
                    String orderDate = order.getOrderNo().substring(0,8);
                    order.setOrderDate(orderDate);
                }

                TbVipsCard card = list.get(0);
                order.setPhone(card.getBankPhone());
                order.setCardNo(card.getCardNo());
                order.setCardName(card.getCardName());
                order.setIdNo(card.getIdNo());
                order.setBankCode(card.getCardCode());
                order.setVipId(card.getId()+"");
                order.setOrderTitle("购票");
                msg = vipsBankCardService.addOrder(order,req);
            }else{
                return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "登录异常");
            }
        }catch (Exception e){
            e.getStackTrace();
            return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "创建订单失败");
        }
        return msg;
    }

    @RequestMapping(value = "findRecord")
    @ResponseBody
    public List<TbVipRecord> findRecord(HttpServletRequest req) throws Exception{
        String phone = commonService.getUserPhone(req);
        Map<String,Object> params = new HashMap<>();
        params.put("phone",phone);
        List<TbVipRecord> list = vipsBankCardService.findRecord(params);
        return list;
    }


}
