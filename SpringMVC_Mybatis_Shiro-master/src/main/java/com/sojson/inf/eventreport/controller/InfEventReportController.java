package com.sojson.inf.eventreport.controller;

import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbEventReport;
import com.sojson.common.model.TbTopByMonth;
import com.sojson.common.model.vo.TbEventReportVo;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.inf.eventreport.service.EventReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



@Controller
@Scope(value="prototype")
@RequestMapping("interface/eventreport")
public class InfEventReportController extends BaseController {

	@Autowired
	EventReportService eventReportService;


	@RequestMapping(value="list",method=RequestMethod.POST)
	@ResponseBody
	public Pagination<TbEventReport> list(Integer pageSize, Integer pageNo ){
		if (pageSize == null || pageSize <= 0) {
			pageSize = 10;
		}
		if (pageNo == null || pageNo <= 0) {
			pageNo = 1;
		}
		return eventReportService.findByPage(pageNo, pageSize);
	}

	@RequestMapping(value="findById",method=RequestMethod.POST)
	@ResponseBody
	public TbEventReportVo findById(String id){
		return eventReportService.findById(id);
	}

}
