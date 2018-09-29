package com.sojson.common.utils;

import net.sf.json.JSONObject;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import sun.misc.BASE64Encoder;

import java.util.*;


public class HttpClientUtils {
    public static String doPost(String url,String jsonstr){
        HttpClient httpClient = null;
        HttpPost httpPost = null;
        String result = null;
        try{
            httpClient = new SSLClient();
            httpPost = new HttpPost(url);
            httpPost.addHeader("Content-Type", "text/html");
            StringEntity se = new StringEntity(jsonstr);
            se.setContentType("text/html");
            se.setContentEncoding("UTF-8");
            httpPost.setEntity(se);
            HttpResponse response = httpClient.execute(httpPost);
            if(response != null){
                HttpEntity resEntity = response.getEntity();
                if(resEntity != null){
                    result = EntityUtils.toString(resEntity,"utf-8");
                }
            }
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return result;
    }

    /**
     * 生成签名
     * @param map
     * @return
     */
    public static String getSign(Map<String, String> map) {

        String result = "";
        try {
            List<Map.Entry<String, String>> infoIds = new ArrayList<Map.Entry<String, String>>(map.entrySet());
            // 对所有传入参数按照字段名的 ASCII 码从小到大排序（字典序）
            Collections.sort(infoIds, new Comparator<Map.Entry<String, String>>() {

                public int compare(Map.Entry<String, String> o1, Map.Entry<String, String> o2) {
                    return (o1.getKey()).toString().compareTo(o2.getKey());
                }
            });

            // 构造签名键值对的格式
            StringBuilder sb = new StringBuilder();
            for (Map.Entry<String, String> item : infoIds) {
                if (item.getKey() != null || item.getKey() != "") {
                    String key = item.getKey();
                    String val = item.getValue();
                    if (!(val == "" || val == null)) {
                        sb.append(key + ":" + val + ":");
                    }
                }

            }
            result = sb.toString();

            //进行MD5加密
            result = DigestUtils.md5Hex(result).toUpperCase();
        } catch (Exception e) {
            return null;
        }
        return result;
    }

    public static String createSign(Map<String,String> map, String uKey){
        String signPars = getSign(map);
        signPars += "key="+uKey;
        String sign = signPars.toUpperCase();

        return sign;
    }

    public static String createData(){
        Map<String,String> map = new HashMap<String,String>();
        map.put("key", "b36b5b4794f15d42");
        map.put("method", "anonymousPayOrder");
        map.put("merchant_id", "151010002");
        map.put("pr_id", "1012");
        map.put("pr_ver", "QuickPay0.21");

        map.put("step","p1");
        map.put("out_trade_no","20180828161936622123456789");
        map.put("orderBody", "手机");
        map.put("out_trade_date", "20180929");
        map.put("mercUserNo", "");
        map.put("total_fee","0.50");
        map.put("bank_code", "CMB");
        map.put("bank_no","1001");
        map.put("notify_url","http://www.baidu.com");
        map.put("cardNo","6214830122565251");
        map.put("cardNm","互联网");
        map.put("idTyp","00");
        map.put("idNo","123123123123");
        map.put("mblNo","15882094486");
        map.put("smsCode","123456");

        Map<String,String> map1 = map;

        map1.remove("pr_id");
        map1.remove("pr_ver");
        map1.remove("merchant_id");

        createSign(map1, "b36b5b4794f15d42");

        JSONObject jsonObject = JSONObject.fromObject(map1);
        byte[] bt = jsonObject.toString().getBytes();
        String trandate = (new BASE64Encoder()).encodeBuffer(bt);

        System.out.println(jsonObject);

        return null;
    }

    public static void main(String[] args){

        createData();
//        String url = "http://d-test.xadtsc.cn/gateway/method.do";
//        String jsonStr = "";
//
//
//        String httpOrgCreateTestRtn = HttpClientUtils.doPost(url, jsonStr);



    }
}