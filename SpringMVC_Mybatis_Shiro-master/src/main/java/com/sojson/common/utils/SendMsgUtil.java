package com.sojson.common.utils;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

import java.io.IOException;

/**
 * Created by lx on 2018/8/25.
 */
public class SendMsgUtil {

    public static String sendMsg(String user, String key, String phone, String msg) {
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
}
