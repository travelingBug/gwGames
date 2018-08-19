package com.sojson.inf.testInf.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.inf.player.model.dto.TbPlayerDto;
import com.sojson.inf.player.service.TbPlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
@Scope(value="prototype")
@RequestMapping("interface")
public class TestInfController extends BaseController {

//	@Autowired
//	TbPlayerService tbPlayerService;
//	/**
//	 * 密码修改
//	 * @return
//	 */
//	@RequestMapping(value="test",method=RequestMethod.POST)
//	@ResponseBody
//	public ResultMessage updatePswd(TbPlayerDto dto){
//		return tbPlayerService.
//	}

}
