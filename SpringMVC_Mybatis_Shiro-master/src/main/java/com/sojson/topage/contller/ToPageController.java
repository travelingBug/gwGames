package com.sojson.topage.contller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbPlayer;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.player.service.PlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;


@Controller
@Scope(value="prototype")
@RequestMapping("toPage")
public class ToPageController extends BaseController {

    /**
     * b报名主页
     * @return
     */
    @RequestMapping(value="/bmIndex",method=RequestMethod.GET)
    @ResponseBody
    public void bmIndex(){
        System.out.println("");
    }
}
