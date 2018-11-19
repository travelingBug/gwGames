package com.sojson.common.utils;

import com.sojson.core.config.IConfig;
import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;

/**
 * Created by lx on 2018/8/25.
 */
public class SendMsgUtil {

    public static String sendMsg(String phone) {

        String user = IConfig.get("user");
        String key = IConfig.get("key");
        String msg_1 = "";
        String msg_4 = "";
        try {
            msg_1 = new String(IConfig.get("msg_1").getBytes("iso-8859-1"),"utf-8");
            msg_4 = new String(IConfig.get("msg_4").getBytes("iso-8859-1"),"utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        int code = (int)((Math.random()*9+1)*100000);
//        RedisUtil redisUtil = RedisUtil.getRedis();
        RedisUtil.save(phone, code+","+ new Date().getTime());

        String msg = msg_1 + code + msg_4;

        HttpClient client = new HttpClient();
        PostMethod post = new PostMethod("http://utf8.api.smschinese.cn");
        post.addRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");//在头文件中设置转码
        NameValuePair[] data = {new NameValuePair("Uid", user), new NameValuePair("Key", key), new NameValuePair("smsMob", phone), new NameValuePair("smsText", msg)};
        post.setRequestBody(data);
        String result = "";
        try {
            client.executeMethod(post);
            Header[] headers = post.getResponseHeaders();
            int statusCode = post.getStatusCode();
            System.out.println("statusCode:" + statusCode);
            for (Header h : headers) {
                System.out.println(h.toString());
            }
            result = new String(post.getResponseBodyAsString().getBytes("utf-8"));
            System.out.println(result); //打印返回消息状态
            post.releaseConnection();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }

    public static String sendAdminMsg(String phone) {

        String user = IConfig.get("user");
        String key = IConfig.get("key");
        String msg_3 = "";
        try {
            msg_3 = new String(IConfig.get("msg_3").getBytes("iso-8859-1"),"utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        int code = (int)((Math.random()*9+1)*100000);
//        RedisUtil redisUtil = RedisUtil.getRedis();
        RedisUtil.save(phone, code+","+ new Date().getTime());

        String msg = msg_3;

        HttpClient client = new HttpClient();
        PostMethod post = new PostMethod("http://utf8.api.smschinese.cn");
        post.addRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");//在头文件中设置转码
        NameValuePair[] data = {new NameValuePair("Uid", user), new NameValuePair("Key", key), new NameValuePair("smsMob", phone), new NameValuePair("smsText", msg)};
        post.setRequestBody(data);
        String result = "";
        try {
            client.executeMethod(post);
            Header[] headers = post.getResponseHeaders();
            int statusCode = post.getStatusCode();
            System.out.println("statusCode:" + statusCode);
            for (Header h : headers) {
                System.out.println(h.toString());
            }
            result = new String(post.getResponseBodyAsString().getBytes("utf-8"));
            System.out.println(result); //打印返回消息状态
            post.releaseConnection();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }

    public static String sendValidCode(String phone) {

        String user = IConfig.get("user");
        String key = IConfig.get("key");
        String msg_1 = "";
        String msg_4 = "";
        try {
            msg_1 = new String(IConfig.get("msg_1").getBytes("iso-8859-1"),"utf-8");
            msg_4 = new String(IConfig.get("msg_4").getBytes("iso-8859-1"),"utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        int code = (int)((Math.random()*9+1)*100000);
//        RedisUtil redisUtil = RedisUtil.getRedis();
        RedisUtil.save(phone, code+","+ new Date().getTime());

        String msg = msg_1 + code + msg_4;

        HttpClient client = new HttpClient();
        PostMethod post = new PostMethod("http://utf8.api.smschinese.cn");
        post.addRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");//在头文件中设置转码
        NameValuePair[] data = {new NameValuePair("Uid", user), new NameValuePair("Key", key), new NameValuePair("smsMob", phone), new NameValuePair("smsText", msg)};
        post.setRequestBody(data);
        String result = "";
        try {
            client.executeMethod(post);
            Header[] headers = post.getResponseHeaders();
            int statusCode = post.getStatusCode();
            System.out.println("statusCode:" + statusCode);
            for (Header h : headers) {
                System.out.println(h.toString());
            }
            result = new String(post.getResponseBodyAsString().getBytes("utf-8"));
            System.out.println(result); //打印返回消息状态
            post.releaseConnection();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }

    public static String sendDealerMsg(String phone, String seatNum, String loginName, String pwd) {

        String user = IConfig.get("user");
        String key = IConfig.get("key");
        String msg_5 = "";
        String msg_6 = "";
        try {
            msg_5 = new String(IConfig.get("msg_5").getBytes("iso-8859-1"),"utf-8");
            msg_6 = new String(IConfig.get("msg_6").getBytes("iso-8859-1"),"utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        int code = (int)((Math.random()*9+1)*100000);
        RedisUtil.save(phone, code+","+ new Date().getTime());

        String msg = msg_5+ "席位号："+seatNum+" ，登录账号："+loginName + "，登录密码：" + pwd + msg_6;

        HttpClient client = new HttpClient();
        PostMethod post = new PostMethod("http://utf8.api.smschinese.cn");
        post.addRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");//在头文件中设置转码
        NameValuePair[] data = {new NameValuePair("Uid", user), new NameValuePair("Key", key), new NameValuePair("smsMob", phone), new NameValuePair("smsText", msg)};
        post.setRequestBody(data);
        String result = "";
        try {
            client.executeMethod(post);
            Header[] headers = post.getResponseHeaders();
            int statusCode = post.getStatusCode();
            System.out.println("statusCode:" + statusCode);
            for (Header h : headers) {
                System.out.println(h.toString());
            }
            result = new String(post.getResponseBodyAsString().getBytes("utf-8"));
            System.out.println(result); //打印返回消息状态
            post.releaseConnection();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }


    public static String sendMsgTest(String phone) {


//        RedisUtil redisUtil = RedisUtil.getRedis();
        RedisUtil.save(phone, "123456,"+ new Date().getTime());

        return "1";
    }
}
