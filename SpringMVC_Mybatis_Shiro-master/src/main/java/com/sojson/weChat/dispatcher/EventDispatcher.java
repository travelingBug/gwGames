package com.sojson.weChat.dispatcher;

import com.sojson.weChat.message.resp.TextMessage;
import com.sojson.weChat.utils.MessageUtil;
import com.sojson.weChat.utils.WxseverUtils;

import java.util.Date;
import java.util.Map;

/**
 * ClassName: EventDispatcher
 * @Description: 事件消息业务分发器
 * @author hwj
 */
public class EventDispatcher {

    public static String processEvent(Map<String, String> map) {
        String openid=map.get("FromUserName"); //用户 openid
        String mpid=map.get("ToUserName");   //公众号原始 ID

        //普通文本消息
        TextMessage txtmsg=new TextMessage();
        txtmsg.setToUserName(openid);
        txtmsg.setFromUserName(mpid);
        txtmsg.setCreateTime(new Date().getTime());
        txtmsg.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
        if (map.get("Event").equals(MessageUtil.EVENT_TYPE_SUBSCRIBE)) { //关注事件
            System.out.println("==============这是关注事件！");
            Map<String, Object> userinfo=WxseverUtils.getWxUserInfo(openid);
            txtmsg.setContent("尊敬的："+userinfo.get("nickname") +"，您好！感谢关注股神大赛！[愉快]");
            return MessageUtil.textMessageToXml(txtmsg);
        }

        if (map.get("Event").equals(MessageUtil.EVENT_TYPE_UNSUBSCRIBE)) { //取消关注事件
            System.out.println("==============这是取消关注事件！");
        }

        if (map.get("Event").equals(MessageUtil.EVENT_TYPE_SCAN)) { //扫描二维码事件
            System.out.println("==============这是扫描二维码事件！");
        }

        if (map.get("Event").equals(MessageUtil.EVENT_TYPE_LOCATION)) { //位置上报事件
            System.out.println("==============这是位置上报事件！");
        }

        if (map.get("Event").equals(MessageUtil.EVENT_TYPE_CLICK)) { //自定义菜单点击事件
            System.out.println("==============这是自定义菜单点击事件！");

            txtmsg.setContent("您好，这里是股神大赛直播室！\n客服联系方式\n客服电话：<a href=\"tel:028-87689938\">028-87689938</a>\n客服QQ：<a href=\"https://wpa.qq.com/msgrd?v=3&uin=1930621578&site=qq&menu=yes\">1930621578</a>");
            return MessageUtil.textMessageToXml(txtmsg);
        }

        if (map.get("Event").equals(MessageUtil.EVENT_TYPE_VIEW)) { //自定义菜单 View 事件
            System.out.println("==============这是自定义菜单 View 事件！");
        }

        return null;
    }

}
