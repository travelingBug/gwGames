package com.sojson.weChat.controller;

import com.sojson.core.config.IConfig;
import com.sojson.weChat.dispatcher.EventDispatcher;
import com.sojson.weChat.dispatcher.MsgDispatcher;
import com.sojson.weChat.utils.MessageUtil;
import com.sojson.weChat.utils.SignUtil;
import com.sojson.weChat.utils.WxseverUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.Map;

/**
 * 微信接入
 * @author hwj
 */
@Controller
@Scope(value = "prototype")
@RequestMapping("wechat")
public class WechatSecurity  {

    private static Logger logger = Logger.getLogger(WechatSecurity.class);

    /**
     * @Description: 用于接收 get 参数，返回验证参数
     * @param request
     * @param response
     */
    @RequestMapping(value = "security", method = RequestMethod.GET)
    public void doGet(
            HttpServletRequest request,
            HttpServletResponse response) {
        try {
            String echostr = request.getParameter("echostr");//接入验证时候的编码
            String signature = request.getParameter("signature");// 微信加密签名
            String timestamp = request.getParameter("timestamp");// 时间戳
            String nonce = request.getParameter("nonce");// 随机数
            if (SignUtil.checkSignature(signature, timestamp, nonce)) {
                PrintWriter out = response.getWriter();
                out.print(echostr);
                out.close();
            } else {
                logger.info("这里存在非法请求！");
            }
        } catch (Exception e) {
            logger.error(e, e);
        }
    }

    /**
     * 用于接收微信服务端消息
     * @param request
     * @param response
     */
    @RequestMapping(value = "security", method = RequestMethod.POST)
    public void DoPost(HttpServletRequest request,HttpServletResponse response){
        System.out.println("这是 post 方法！");
        try{
            String respXML = null;
            response.setCharacterEncoding("utf-8");
            Map<String, String> map= MessageUtil.parseXml(request);
            String msgtype=map.get("MsgType");
            if(MessageUtil.REQ_MESSAGE_TYPE_EVENT.equals(msgtype)){
                respXML = EventDispatcher.processEvent(map); //进入事件处理
            }else{
                respXML = MsgDispatcher.processMessage(map); //进入消息处理
            }
            PrintWriter out = response.getWriter();
            out.print(respXML);
            out.flush();
            out.close();
        }catch(Exception e){
            logger.error(e,e);
        }
    }


    @RequestMapping(value = "ces", method = RequestMethod.GET)
    public void ces(HttpServletRequest request,HttpServletResponse response){
        //{"button":[{"name":"博客","type":"view","url":"http://www.cuiyongzhi.com"},{"name":"菜单","sub_button":[{"key":"text","name":"回复图文","type":"click"},{"name":"博客","type":"view","url":"http://www.cuiyongzhi.com"}]},{"key":"text","name":"回复图文","type":"click"}]}
        JSONArray gResBut = new JSONArray();

        JSONArray gResBut1 = new JSONArray();
        JSONObject node = new JSONObject();
        node.put("name","首页");
        node.put("type","view");
        node.put("url", IConfig.get("httpUrl_path")+"/static/wx/index.html?t=0&p=1");
        gResBut1.add(node);
        node.put("name","报名");
        node.put("type","view");
        node.put("url",IConfig.get("httpUrl_path")+"/static/wx/index.html?t=5&p=1");
        gResBut1.add(node);
        node.put("name","赛事");
        node.put("type","view");
        node.put("url",IConfig.get("httpUrl_path")+"/static/wx/index.html?t=4&p=1");
        gResBut1.add(node);
        node.put("name","排行榜");
        node.put("type","view");
        node.put("url",IConfig.get("httpUrl_path")+"/static/wx/index.html?t=2&p=1");
        gResBut1.add(node);

        JSONObject node1 = new JSONObject();
        node1.put("name","主页");
        node1.put("sub_button",gResBut1);
        gResBut.add(node1);

        JSONArray gResBut2 = new JSONArray();
        node.put("name","个人中心");
        node.put("type","view");
        node.put("url",IConfig.get("httpUrl_path")+"/static/wx/index.html?t=3&p=1");
        gResBut2.add(node);
        node.put("name","观赛");
        node.put("type","view");
        node.put("url",IConfig.get("httpUrl_path")+"/static/wx/index.html?t=6&p=1");
        gResBut2.add(node);
        node.put("name","会员权益");
        node.put("type","view");
        node.put("url",IConfig.get("httpUrl_path")+"/static/wx/index.html?t=1&p=1");
        gResBut2.add(node);
        node.put("key","text");
        node.put("name","联系我们");
        node.put("type","click");
        gResBut2.add(node);

        JSONObject node2 = new JSONObject();
        node2.put("name","观赛通道");
        node2.put("sub_button",gResBut2);
        gResBut.add(node2);
        /*JSONObject node2 = new JSONObject();
        node2.put("name","回复图文");
        node2.put("type","click");
        node2.put("key","text");
        JSONArray gResBut2 = new JSONArray();
        gResBut2.add(node2);
        JSONObject node3 = new JSONObject();
        node3.put("name","菜单");
        node3.put("sub_button",gResBut2);
        gResBut.add(node3);*/
        JSONObject menujson=new JSONObject();
        menujson.put("button",gResBut);
        System.out.println(menujson.toString());
        WxseverUtils.setWxMenus(menujson.toString());
    }
}
