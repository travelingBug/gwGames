package com.sojson.inf.message.service.impl;

import com.sojson.common.ResultMessage;
import com.sojson.common.utils.RedisUtil;
import com.sojson.common.utils.SendMsgUtil;
import com.sojson.common.utils.StringUtils;
import com.sojson.inf.message.service.MessageService;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class MessageServiceImpl implements MessageService {

	RedisUtil redisUtil = RedisUtil.getRedis();
	/**
	 * 发送短信验证
	 * @param telPhone
	 * @return
	 */
	public ResultMessage send(String telPhone){
		ResultMessage msg = vaildCanSend(telPhone);
		if (msg.getLevel() == ResultMessage.MSG_LEVEL.SUCC.v) {
			String result = SendMsgUtil.sendMsg(telPhone);
			SendMsgUtil.sendAdminMsg("18019565656,18980907645,15982113122");
//			String result = SendMsgUtil.sendMsgTest(telPhone);
			if (Integer.parseInt(result) > 0) {
				msg =  new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v, "短信发送成功");
			} else {
				msg = new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v, "短信发送失败");
			}
		}

		return msg;
	}

	/**
	 * 验证是否需要发送短信
	 * @param telPhone
	 * @return
	 */
	public ResultMessage vaildCanSend(String telPhone){
		String code = redisUtil.get(telPhone);
		if (!StringUtils.isBlank(code)) {
			String[] codeArr = code.split(",");
			if (codeArr.length == 2) {
				if (new Date().getTime() - Long.parseLong(codeArr[1])  < 60000 ) {
					return new ResultMessage(ResultMessage.MSG_LEVEL.FAIL.v,"倒计时结束后才可重新发送验证码！");
				}
			}

		}
		return new ResultMessage(ResultMessage.MSG_LEVEL.SUCC.v);
	}
}
