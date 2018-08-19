package com.sojson.inf.testInf.controller;

import com.sojson.common.controller.BaseController;
import com.sojson.common.model.UUser;
import com.sojson.common.utils.LoggerUtils;
import com.sojson.core.shiro.token.manager.TokenManager;
import com.sojson.inf.testInf.dto.TestInfDto;
import com.sojson.user.bo.SubmitDto;
import com.sojson.user.manager.UserManager;
import com.sojson.user.service.UUserService;
import net.sf.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;


@Controller
@Scope(value="prototype")
@RequestMapping("interface")
public class TestInfController extends BaseController {

	/**
	 * 密码修改
	 * @return
	 */
	@RequestMapping(value="test",method=RequestMethod.POST)
	@ResponseBody
	public SubmitDto updatePswd(TestInfDto dto1){
		SubmitDto dto = new SubmitDto();
		dto.setLoginName(dto1.getUser());
		return dto;
	}

}
