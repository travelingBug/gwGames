package com.sojson.inf.message.service.impl;

import com.sojson.common.ResultMessage;
import com.sojson.common.utils.SendMsgUtil;
import com.sojson.inf.message.service.MessageService;
import org.springframework.stereotype.Service;

@Service
public class MessageServiceImpl implements MessageService {

	/**
	 * 发送短信验证
	 * @param telPhone
	 * @return
	 */
	public ResultMessage send(String telPhone){
		String result = SendMsgUtil.sendMsg(telPhone);
		if (Integer.parseInt(result) > 0) {
			return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v,"短信发送成功");
		} else {
			return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"短信发送失败");
		}
	}
}
