package com.sojson.inf.vips.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbVips;
import com.sojson.common.model.TbVipsCard;
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

    /**
     * 新增
     *
     * @param entity
     * @return
     */
    @RequestMapping(value = "addBankCard", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage addBank(TbVipsCard entity,String sessionId,HttpServletRequest req) {
        return vipsBankCardService.insert(entity, sessionId, req);
    }

    /**
     * 删除
     *
     * @param id
     * @param req
     * @return
     */
    @RequestMapping(value = "delBankCard", method = RequestMethod.GET)
    @ResponseBody
    public ResultMessage delBankCard(String id, HttpServletRequest req) {
        return vipsBankCardService.delete(id);
    }

    /**
     *
     *查询
     * @return
     */
    @RequestMapping(value = "list")
    @ResponseBody
    public List<TbVipsCard> list(String sessionId) {

        List<TbVipsCard> list = vipsBankCardService.findList(sessionId);
        return list;
    }
}
