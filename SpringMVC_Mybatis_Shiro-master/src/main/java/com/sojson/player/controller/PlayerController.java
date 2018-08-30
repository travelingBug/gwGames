package com.sojson.player.controller;

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

/**
 * Created by lx on 2018/8/27.
 */

@Controller
@Scope(value="prototype")
@RequestMapping("player")
public class PlayerController extends BaseController {

    @Autowired
    PlayerService playerService;

    /**
     * 审核参赛人员
     * @param entity
     * @param req
     * @return
     */
    @RequestMapping(value="audit",method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage audit(TbPlayer entity, HttpServletRequest req){
        return playerService.updateByPrimaryKeySelective(entity);
    }

}
