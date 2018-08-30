package com.sojson.inf.message.service;

import com.sojson.common.ResultMessage;

public interface MessageService {

	/**
	 * 短消息发送
	 * @param telPhone
	 * @return
	 */
	public ResultMessage send(String telPhone);
}
