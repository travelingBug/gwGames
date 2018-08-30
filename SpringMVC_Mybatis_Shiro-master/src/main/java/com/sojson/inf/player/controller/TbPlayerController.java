package com.sojson.inf.player.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.common.model.TbPlayer;
import com.sojson.common.model.dto.TbPlayerDto;
import com.sojson.core.mybatis.page.Pagination;
import com.sojson.inf.player.service.TbPlayerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.xml.transform.Result;
import java.util.List;


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

	/**
	 * 获取参赛选手信息
	 * @return
	 */
	@RequestMapping(value="findAllNoPage",method=RequestMethod.POST)
	@ResponseBody
	public List<TbPlayer> findAllNoPage(TbPlayerDto dto){
		List<TbPlayer> players = tbPlayerService.findAllNoPage(dto);
		return players;
	}

}
