package com.sojson.vips.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbDealer;
import com.sojson.common.model.TbVips;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.dealer.service.DealerService;
import com.sojson.user.service.UUserService;
import com.sojson.vips.service.VipsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
@Controller
@Scope(value="prototype")
@RequestMapping("vips")
public class VipsController extends BaseController {

    @Autowired
    VipsService vipsService;

    @Autowired
    UUserService userService;

    /**
     * 注册
     *
     * @param entity
     * @return
     */
    @RequestMapping(value = "register", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage register(TbVips entity) {
        entity.setId(StringUtils.getUUID32());
        return vipsService.insert(entity);
    }

    /**
     * 编辑
     *
     * @param req
     * @return
     */
    @RequestMapping(value = "editVips", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage editVips(TbVips entity, HttpServletRequest req) {
        return vipsService.update(entity);
    }

    /**
     * 删除
     *
     * @param id
     * @param req
     * @return
     */
    @RequestMapping(value = "deleteVipsById", method = RequestMethod.GET)
    @ResponseBody
    public ResultMessage deleteVipsById(String id, HttpServletRequest req) {
        return vipsService.delete(id);
    }

    /**
     *
     *
     * @return
     */
    @RequestMapping(value = "list")
    public ModelAndView list(ModelMap map, Integer pageNo, String findContent,
                             String parentId) {

        map.put("findContent", findContent);
        map.put("parentId", parentId);
        Pagination<TbVips> page = vipsService.findByPage(map, pageNo, pageSize);
        map.put("page", page);
        return new ModelAndView("vips/list");
    }

    @RequestMapping(value="forbidUserById",method=RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> forbidUserById(Long id, Long status){
        return userService.updateForbidUserById(id,status);
    }
}
