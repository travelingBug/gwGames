package com.sojson.inf.message.controller;

import com.sojson.common.ResultMessage;
import com.sojson.common.controller.BaseController;
import com.sojson.inf.message.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@Scope(value="prototype")
@RequestMapping("interface/meaage")
public class MessageController extends BaseController {

	@Autowired
	MessageService messageService;

	/**
	 * 发送消息
	 * @param telPhone
	 * @return
	 */
	@RequestMapping(value="send",method=RequestMethod.POST)
	@ResponseBody
	public ResultMessage send(String telPhone){

		return messageService.send(telPhone);
	}


}
