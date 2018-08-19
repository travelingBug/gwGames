package com.sojson.inf.player.controller;

import com.sojson.common.controller.BaseController;
import com.sojson.inf.testInf.dto.TestInfDto;
import com.sojson.user.bo.SubmitDto;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@Scope(value="prototype")
@RequestMapping("interface")
public class TbPlayerController extends BaseController {

	@RequestMapping(value="save",method=RequestMethod.POST)
	@ResponseBody
	public SubmitDto save(TestInfDto dto1){
		SubmitDto dto = new SubmitDto();
		dto.setLoginName(dto1.getUser());
		return dto;
	}

}
