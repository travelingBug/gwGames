package com.sojson.inf.homeconfig.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbEventReport;
import com.sojson.common.model.vo.TbEventReportVo;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.homeconfig.service.HomeConfigService;
import com.sojson.inf.eventreport.service.EventReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@Scope(value="prototype")
@RequestMapping("interface/homeconfig")
public class InfHomeConfigController extends BaseController {

	@Autowired
	HomeConfigService homeConfigService;


	@RequestMapping(value="getData",method=RequestMethod.POST)
	@ResponseBody
	public ResultMessage getData(String id){
		return homeConfigService.getHomeConfig();
	}

	@RequestMapping(value="getHomeAdvert",method=RequestMethod.POST)
	@ResponseBody
	public ResultMessage getHomeAdvert(String id){
		return homeConfigService.getHomeAdvert();
	}

}
