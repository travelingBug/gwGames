package com.sojson.inf.problem.controller;

import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbEventReport;
import com.sojson.common.model.TbProblem;
import com.sojson.common.model.vo.TbEventReportVo;
import com.sojson.common.model.vo.TbProblemVo;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.inf.eventreport.service.EventReportService;
import com.sojson.inf.problem.service.InfProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@Scope(value="prototype")
@RequestMapping("interface/problem")
public class InfProblemController extends BaseController {

	@Autowired
	InfProblemService infProblemService;


	@RequestMapping(value="list",method=RequestMethod.POST)
	@ResponseBody
	public Pagination<TbProblem> list(Integer pageSize, Integer pageNo ){
		if (pageSize == null || pageSize <= 0) {
			pageSize = 10;
		}
		if (pageNo == null || pageNo <= 0) {
			pageNo = 1;
		}
		return infProblemService.findByPage(pageNo, pageSize);
	}

	@RequestMapping(value="findById",method=RequestMethod.POST)
	@ResponseBody
	public TbProblemVo findById(String id){
		return infProblemService.findById(id);
	}

}
