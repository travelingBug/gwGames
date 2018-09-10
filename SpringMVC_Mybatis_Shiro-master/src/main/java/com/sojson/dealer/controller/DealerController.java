package com.sojson.dealer.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbDealer;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.dealer.service.DealerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by lx on 2018/9/4.
 */
@Controller
@Scope(value="prototype")
@RequestMapping("dealer")
public class DealerController extends BaseController {

    @Autowired
    DealerService dealerService;

    /**
     * 增加经销商
     *
     * @param entity
     * @param req
     * @return
     */
    @RequestMapping(value = "addDealer", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage addDealer(TbDealer entity, HttpServletRequest req) {
        entity.setId(StringUtils.getUUID32());

        return dealerService.insert(entity);
    }

    /**
     * 编辑经销商
     *
     * @param id
     * @param name
     * @param req
     * @return
     */
    @RequestMapping(value = "editDealer", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage editDealer(String id, String name, HttpServletRequest req) {
        TbDealer entity = new TbDealer();
        entity.setId(id);
        entity.setName(name);
        return dealerService.update(entity);
    }

    /**
     * 删除经销商
     *
     * @param id
     * @param req
     * @return
     */
    @RequestMapping(value = "deleteDealerById", method = RequestMethod.GET)
    @ResponseBody
    public ResultMessage deleteDealerById(String id, HttpServletRequest req) {
        return dealerService.delete(id);
    }

    /**
     * 参赛人员主页
     *
     * @return
     */
    @RequestMapping(value = "list")
    public ModelAndView list(ModelMap map, Integer pageNo, String findContent) {

        map.put("findContent", findContent);
        Pagination<TbDealer> page = dealerService.findByPage(map, pageNo, pageSize);
        map.put("page", page);
        return new ModelAndView("dealer/list");
    }
}
