package com.sojson.weChat.message.req;

/**
 * ClassName: TextMessage
 * @Description: 文本消息
 * @author hwj
 */
public class TextMessage extends BaseMessage {
    // 消息内容
    private String Content;

    public String getContent() {
        return Content;
    }

    public void setContent(String content) {
        Content = content;
    }
}