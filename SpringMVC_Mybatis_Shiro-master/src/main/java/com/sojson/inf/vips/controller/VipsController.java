package com.sojson.inf.vips.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbVips;
import com.sojson.common.service.CommonService;
import com.sojson.core.mybatis.page.Pagination;
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
import java.util.Map;

/**
 * Created by lx on 2018/9/4.
 */
@Controller
@Scope(value="prototype")
@RequestMapping("interface/vips")
public class VipsController extends BaseController {

    @Autowired
    VipsService vipsService;

    @Autowired
    UUserService userService;

    @Resource
    CommonService commonService;

    /**
     * 注册
     *
     * @param entity
     * @return
     */
    @RequestMapping(value = "register", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage register(TbVips entity, HttpServletRequest req) {
        return vipsService.insert(entity, req);
    }

    /**
     * 登录
     *
     * @param entity
     * @return
     */
    @RequestMapping(value = "login", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage login(TbVips entity, HttpServletRequest req) {
        return vipsService.login(entity, req);
    }

    /**
     * 验证手机号码
     *
     * @param telPhone
     * @return
     */
    @RequestMapping(value = "validPhone", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage validPhone(String telPhone) {
        return vipsService.validPhone(telPhone);
    }

    /**
     * 编辑
     *
     * @param req
     * @return
     */
    @RequestMapping(value = "editVips", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage editVips(TbVips entity, HttpServletRequest req) throws Exception{
        return vipsService.update(entity,req);
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

    @RequestMapping(value="queryVipsInfo",method=RequestMethod.POST)
    @ResponseBody
    public TbVips queryVipsInfo(HttpServletRequest req) throws Exception{
        String phone = commonService.getUserPhone(req);
        return vipsService.queryVipsInfo(phone);
    }

    @RequestMapping(value="loginOut",method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage loginOut(HttpServletRequest request) throws Exception {
        String token = commonService.getToken(request);
        return vipsService.loginOut(token);
    }

    @RequestMapping(value="forbidUserById",method=RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> forbidUserById(Long id, Long status){
        return userService.updateForbidUserById(id,status);
    }

    @RequestMapping(value = "valiPass", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage valiPass(String pwd, HttpServletRequest req) throws Exception{
        String phone = commonService.getUserPhone(req);
        return vipsService.validatePwd(pwd, phone);
    }

    @RequestMapping(value = "validInviteCode", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage validInviteCode(String inviteCode, HttpServletRequest req) throws Exception{
        return vipsService.validInviteCode(inviteCode);
    }

    @RequestMapping(value = "resetPwd", method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage resetPwd(TbVips entity, HttpServletRequest req) throws Exception{
        return vipsService.resetPwd(entity, req);
    }
}
