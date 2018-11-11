package com.sojson.player.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.player.service.PlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

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
     * @param req
     * @return
     */
    @RequestMapping(value="auditById",method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage auditById(TbPlayer entity, HttpServletRequest req){
        return playerService.updateByPrimaryKeySelective(entity);
    }

    /**
     * 编辑参赛人员
     * @param req
     * @return
     */
    @RequestMapping(value="editPlayer",method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage editPlayer(TbPlayer entity, HttpServletRequest req){
        return playerService.updateByPrimaryKeySelective(entity);
    }

    /**
     * 新增参赛人员
     * @param req
     * @return
     */
    @RequestMapping(value="addPlayer",method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage addPlayer(TbPlayerDto entity, HttpServletRequest req){
        return playerService.insertPlayer(entity);
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

    /**
     * 获取参赛选手
     */
    @RequestMapping(value="findAll",method=RequestMethod.POST)
    @ResponseBody
    public List<TbPlayer> findAll(TbPlayerDto player){
        return this.playerService.findAll(player);
    }

    //导入excel
    @RequestMapping(value = "/import", method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage importExcel(@RequestParam(value="file",required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response){
        ResultMessage msg = playerService.importPlayerExcel(file);
        return msg;
    }


    //导入excel
    @RequestMapping(value = "/updateCapitalBatch", method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage updateCapitalBatch(@RequestParam(value="file",required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response){
        ResultMessage msg = playerService.updateCapitalBatch(file);
        return msg;
    }


}
