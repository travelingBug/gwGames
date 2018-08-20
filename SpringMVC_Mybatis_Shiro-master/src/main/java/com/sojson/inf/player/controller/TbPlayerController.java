package com.sojson.inf.player.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.inf.player.model.dto.TbPlayerDto;
import com.sojson.inf.player.service.TbPlayerService;
import com.sojson.inf.testInf.dto.TestInfDto;
import com.sojson.user.bo.SubmitDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@Scope(value="prototype")
@RequestMapping("interface/player")
public class TbPlayerController extends BaseController {

	@Autowired
	TbPlayerService tbPlayerService;

	@RequestMapping(value="save",method=RequestMethod.POST)
	@ResponseBody
	public ResultMessage save(TbPlayerDto dto){
		return tbPlayerService.insert(dto);
	}

}
