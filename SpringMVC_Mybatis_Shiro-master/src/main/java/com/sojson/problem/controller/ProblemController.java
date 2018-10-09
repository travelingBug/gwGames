package com.sojson.problem.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbProblem;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.problem.service.ProblemService;
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
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * Created by hwj on 2018/10/09.
 */

@Controller
@Scope(value="prototype")
@RequestMapping("problem")
public class ProblemController extends BaseController {

    @Autowired
    ProblemService problemService;

    /**
     * 常见问题数据列表
     * @return
     */
    @RequestMapping(value="list")
    public ModelAndView list(Integer pageNo, ModelMap modelMap,@RequestParam Map<String,Object> map){

        Pagination<TbProblem> page = problemService.findByPage(map,pageNo,pageSize);
        modelMap.put("page", page);
        modelMap.putAll(map);
        return new ModelAndView("problem/list");
    }

    @RequestMapping(value = "/add", method= RequestMethod.POST)
    @ResponseBody
    public ResultMessage add(HttpServletRequest request, HttpServletResponse response, TbProblem tbProblem){
        ResultMessage msg = problemService.add(tbProblem);
        return msg;
    }



    @RequestMapping(value = "/findById", method= RequestMethod.POST)
    @ResponseBody
    public TbProblem findById(HttpServletRequest request, HttpServletResponse response, String id){
        TbProblem tbProblem = problemService.findById(id);
        return tbProblem;
    }


    @RequestMapping(value = "/update", method= RequestMethod.POST)
    @ResponseBody
    public ResultMessage update(HttpServletRequest request, HttpServletResponse response,TbProblem tbProblem){
        ResultMessage msg = problemService.update(tbProblem);
        return msg;
    }


    @RequestMapping(value = "/del", method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage del(HttpServletRequest request, HttpServletResponse response,String id){
        ResultMessage msg = problemService.deleteById(id);
        return msg;
    }

}
