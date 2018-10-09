package com.sojson.eventReport.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbEventReport;
import com.sojson.common.utils.StringUtils;
import com.sojson.core.config.IConfig;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.eventReport.service.ReportService;
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
 * Created by hwj on 2018/10/07.
 */

@Controller
@Scope(value="prototype")
@RequestMapping("eventReport")
public class ReportController extends BaseController {

    @Autowired
    ReportService reportService;

    /**
     * 赛事报道数据列表
     * @return
     */
    @RequestMapping(value="list")
    public ModelAndView list(Integer pageNo, ModelMap modelMap,@RequestParam Map<String,Object> map){

        Pagination<TbEventReport> page = reportService.findByPage(map,pageNo,pageSize);
        modelMap.put("page", page);
        modelMap.putAll(map);
        return new ModelAndView("eventReport/list");
    }

    @RequestMapping(value = "/add", method= RequestMethod.POST)
    @ResponseBody
    public ResultMessage add(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="file",required = false) MultipartFile file, TbEventReport tbEventReport){
        ResultMessage msg = reportService.add(file,tbEventReport);
        return msg;
    }



    @RequestMapping(value = "/findById", method= RequestMethod.POST)
    @ResponseBody
    public TbEventReport findById(HttpServletRequest request, HttpServletResponse response, String id){
        TbEventReport tbEventReport = reportService.findById(id);
        String path = IConfig.get("eventReport_path");
        if(StringUtils.isNotBlank(tbEventReport.getCover())){
            tbEventReport.setCover(path+tbEventReport.getCover());
        }
        return tbEventReport;
    }


    @RequestMapping(value = "/update", method= RequestMethod.POST)
    @ResponseBody
    public ResultMessage update(HttpServletRequest request, HttpServletResponse response, @RequestParam(value="file",required = false) MultipartFile file, TbEventReport tbEventReport){
        ResultMessage msg = reportService.update(file,tbEventReport);
        return msg;
    }


    @RequestMapping(value = "/del", method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage del(HttpServletRequest request, HttpServletResponse response,String id){
        ResultMessage msg = reportService.deleteById(id);
        return msg;
    }

}
