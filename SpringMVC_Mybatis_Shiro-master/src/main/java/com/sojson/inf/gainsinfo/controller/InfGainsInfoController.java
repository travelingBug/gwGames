package com.sojson.inf.gainsinfo.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.PlayerTopInfo;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.inf.gainsinfo.service.InfGainsInfoService;
import com.sojson.inf.player.service.TbPlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;


@Controller
@Scope(value="prototype")
@RequestMapping("interface/gainsInfo")
public class InfGainsInfoController extends BaseController {

	@Autowired
	InfGainsInfoService infGainsInfoService;

	@RequestMapping(value="getTopAll",method=RequestMethod.POST)
	@ResponseBody
	public List<PlayerTopInfo> getTopAll(int size){
		return infGainsInfoService.getTopAll(size);
	}

	@RequestMapping(value="getTopMonth",method=RequestMethod.POST)
	@ResponseBody
	public List<PlayerTopInfo> getTopMonth(int size){

		return infGainsInfoService.getTopMonth(size);
	}


}
