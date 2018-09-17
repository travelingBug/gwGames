package com.sojson.gainsinfo.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbGainsInfo;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.TbGainsInfoDto;
import com.sojson.common.model.vo.TbGainsInfoVo;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.gainsinfo.service.GainsInfoService;
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
import java.util.Map;

/**
 * Created by lx on 2018/8/27.
 */

@Controller
@Scope(value="prototype")
@RequestMapping("gainsInfo")
public class GainsInfoController extends BaseController {

    @Autowired
    GainsInfoService gainsInfoService;
    //导入excel
    @RequestMapping(value = "/import", method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage importExcel(@RequestParam(value="file",required = false) MultipartFile file, HttpServletRequest request, HttpServletResponse response){
        ResultMessage msg = gainsInfoService.importGainsExcel(file);
        return msg;
    }

    @RequestMapping(value = "/update", method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage update(HttpServletRequest request, HttpServletResponse response,TbGainsInfo tbGainsInfo){
        ResultMessage msg = gainsInfoService.update(tbGainsInfo);
        return msg;
    }

    @RequestMapping(value = "/add", method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage add(HttpServletRequest request, HttpServletResponse response,TbGainsInfo tbGainsInfo){
        ResultMessage msg = gainsInfoService.add(tbGainsInfo);
        return msg;
    }

    @RequestMapping(value = "/del", method=RequestMethod.POST)
    @ResponseBody
    public ResultMessage del(HttpServletRequest request, HttpServletResponse response,Long id){
        ResultMessage msg = gainsInfoService.deleteById(id);
        return msg;
    }

    /**
     * 参赛选手数据列表
     * @return
     */
    @RequestMapping(value="list")
    public ModelAndView list(Integer pageNo, ModelMap modelMap,@RequestParam Map<String,Object> map){

        Pagination<TbGainsInfoVo> page = gainsInfoService.findByPage(map,pageNo,pageSize);
        modelMap.put("page", page);
        modelMap.putAll(map);
        return new ModelAndView("gainsInfo/list");
    }

}
