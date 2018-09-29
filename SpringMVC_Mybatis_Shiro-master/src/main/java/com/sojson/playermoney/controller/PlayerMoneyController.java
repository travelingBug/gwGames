package com.sojson.playermoney.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbPlayerMoney;
import com.sojson.common.model.vo.TbPlayerMoneyVo;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.playermoney.service.PlayerMoneyService;
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
import java.util.Map;

/**
 * Created by lx on 2018/8/27.
 */

@Controller
@Scope(value="prototype")
@RequestMapping("playerMoney")
public class PlayerMoneyController extends BaseController {

    @Autowired
    PlayerMoneyService playerMoneyService;
    //导入excel
    @RequestMapping(value = "/import", method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage importExcel(@RequestParam(value="file",required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response){
        ResultMessage msg = playerMoneyService.importPlayerMoneyExcel(file);
        return msg;
    }

    @RequestMapping(value = "/update", method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage update(HttpServletRequest request, HttpServletResponse response,TbPlayerMoney tbplayerMoney){
        ResultMessage msg = playerMoneyService.update(tbplayerMoney);
        return msg;
    }

    @RequestMapping(value = "/add", method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage add(HttpServletRequest request, HttpServletResponse response,TbPlayerMoney tbplayerMoney){
        ResultMessage msg = playerMoneyService.add(tbplayerMoney);
        return msg;
    }

    @RequestMapping(value = "/del", method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage del(HttpServletRequest request, HttpServletResponse response,Long id){
        ResultMessage msg = playerMoneyService.deleteById(id);
        return msg;
    }

    /**
     * 参赛选手金额列表
     * @return
     */
    @RequestMapping(value="list")
    public ModelAndView list(Integer pageNo, ModelMap modelMap,@RequestParam Map<String,Object> map){

        Pagination<TbPlayerMoneyVo> page = playerMoneyService.findByPage(map,pageNo,pageSize);
        modelMap.put("page", page);
        modelMap.putAll(map);
        return new ModelAndView("playerMoney/list");
    }

}
