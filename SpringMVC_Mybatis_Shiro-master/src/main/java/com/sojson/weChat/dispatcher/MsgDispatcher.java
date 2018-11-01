package com.sojson.weChat.dispatcher;

import com.sojson.core.config.IConfig;
import com.sojson.weChat.message.resp.Article;
import com.sojson.weChat.message.resp.NewsMessage;
import com.sojson.weChat.message.resp.TextMessage;
import com.sojson.weChat.utils.MessageUtil;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * ClassName: MsgDispatcher
 * @Description: 消息业务处理分发器
 * @author hwj
 */
public class MsgDispatcher {
    public static String processMessage(Map<String, String> map) {
        String openid=map.get("FromUserName"); //用户 openid
        String mpid=map.get("ToUserName");   //公众号原始 ID

        //普通文本消息
        TextMessage txtmsg=new TextMessage();
        txtmsg.setToUserName(openid);
        txtmsg.setFromUserName(mpid);
        txtmsg.setCreateTime(new Date().getTime());
        txtmsg.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_TEXT);
        if (map.get("MsgType").equals(MessageUtil.REQ_MESSAGE_TYPE_TEXT)) { // 文本消息
            System.out.println("==============这是文本消息！");

            txtmsg.setContent("您好，这里是股神大赛直播室！\n客服联系方式\n客服电话：<a href=\"tel:028-87689938\">028-87689938</a>\n客服QQ：<a href=\"https://wpa.qq.com/msgrd?v=3&uin=1930621578&site=qq&menu=yes\">1930621578</a>");
            return MessageUtil.textMessageToXml(txtmsg);
        }

        //对图文消息
        NewsMessage newmsg=new NewsMessage();
        newmsg.setToUserName(openid);
        newmsg.setFromUserName(mpid);
        newmsg.setCreateTime(new Date().getTime());
        newmsg.setMsgType(MessageUtil.RESP_MESSAGE_TYPE_NEWS);
        if (map.get("MsgType").equals(MessageUtil.REQ_MESSAGE_TYPE_IMAGE)) { // 图片消息
            System.out.println("==============这是图片消息！");
            Article article=new Article();
            article.setDescription("天下股神实盘大赛是由天府新区对冲基金学会和富甲文化联合主办的实盘炒股比赛。天下股神实盘大赛旨在挖掘民间炒股高手，为其提供一个展现自我风采、相互学习的大舞台。"); //图文消息的描述
            article.setPicUrl(IConfig.get("httpUrl_path")+"/images/bm_bg.png"); //图文消息图片地址
            article.setTitle("股神大赛");  //图文消息标题
            article.setUrl(IConfig.get("httpUrl_path")+"/static/wx/index.html");  //图文 url 链接
            List<Article> list=new ArrayList<Article>();
            list.add(article);     //这里发送的是单图文，如果需要发送多图文则在这里 list 中加入多个 Article 即可！

            newmsg.setArticleCount(list.size());
            newmsg.setArticles(list);
            return MessageUtil.newsMessageToXml(newmsg);
        }

        if (map.get("MsgType").equals(MessageUtil.REQ_MESSAGE_TYPE_LINK)) { // 链接消息
            System.out.println("==============这是链接消息！");
        }

        if (map.get("MsgType").equals(MessageUtil.REQ_MESSAGE_TYPE_LOCATION)) { // 位置消息
            System.out.println("==============这是位置消息！");
        }

        if (map.get("MsgType").equals(MessageUtil.REQ_MESSAGE_TYPE_VIDEO)) { // 视频消息
            System.out.println("==============这是视频消息！");
            txtmsg.setContent("您好，股神大赛暂不识别视频消息！");
            return MessageUtil.textMessageToXml(txtmsg);
        }

        if (map.get("MsgType").equals(MessageUtil.REQ_MESSAGE_TYPE_VOICE)) { // 语音消息
            System.out.println("==============这是语音消息！");

            txtmsg.setContent("您说："+map.get("Recognition"));
            return MessageUtil.textMessageToXml(txtmsg);
        }

        return null;
    }
}
