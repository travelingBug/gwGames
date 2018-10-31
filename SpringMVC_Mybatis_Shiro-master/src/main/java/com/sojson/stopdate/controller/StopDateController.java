package com.sojson.stopdate.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.TbStopDate;
import com.sojson.common.model.TbVips;
import com.sojson.common.model.vo.TbPlayerMoneyVo;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.stopdate.service.StopDateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by lx on 2018/8/27.
 */

@Controller
@Scope(value="prototype")
@RequestMapping("stopdate")
public class StopDateController extends BaseController {

    @Autowired
    StopDateService stopDateService;

//    /**
//     * 审核参赛人员
//     * @param req
//     * @return
//     */
//    @RequestMapping(value="list",method=RequestMethod.POST)
//    @ResponseBody
//    public TbStopDate list(HttpServletRequest req){
//        return stopDateService.findStopDate();
//    }

    @RequestMapping(value="/list")
    public ModelAndView list(ModelMap modelMap,@RequestParam Map<String,Object> map){

        Pagination<TbVips> page = stopDateService.findByPage(map,pageNo,pageSize);
        modelMap.put("page", page);
        modelMap.putAll(map);
        return new ModelAndView("stopdate/list");
    }

    /**
     * @param req
     * @return
     */
    @RequestMapping(value="/insert",method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage editPlayer( HttpServletRequest req,TbStopDate vo){
        return stopDateService.insert(vo);
    }

    /**
     * @param req
     * @return
     */
    @RequestMapping(value="/del",method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage editPlayer( HttpServletRequest req,Long id){
        return stopDateService.deleteById(id);
    }

}
