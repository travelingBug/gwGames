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
     * @param id
     * @param auditFlag
     * @param req
     * @return
     */
    @RequestMapping(value="auditById",method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage auditById(String id, String auditFlag, HttpServletRequest req){
        TbPlayer entity = new TbPlayer();
        entity.setId(id);
        entity.setAuditFlag(Byte.parseByte(auditFlag));
        return playerService.updateByPrimaryKeySelective(entity);
    }

    /**
     * 编辑参赛人员
     * @param id
     * @param accountName
     * @param req
     * @return
     */
    @RequestMapping(value="editPlayer",method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage editPlayer(String id, String accountName, HttpServletRequest req){
        TbPlayer entity = new TbPlayer();
        entity.setId(id);
        entity.setAccountName(accountName);
        return playerService.updateByPrimaryKeySelective(entity);
    }

    /**
     * 参赛人员主页
     * @return
     */
    @RequestMapping(value="list")
    public ModelAndView list(ModelMap map, Integer pageNo, String findContent, String auditFlag){

        map.put("findContent", findContent);
        map.put("auditFlag", auditFlag);
        Pagination<TbPlayer> page = playerService.findByPage(map,pageNo,pageSize);
        map.put("page", page);
        return new ModelAndView("player/list");
    }
}
