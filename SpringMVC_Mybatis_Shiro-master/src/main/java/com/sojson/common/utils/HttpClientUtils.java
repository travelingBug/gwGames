package com.sojson.common.utils;

import net.sf.json.JSONObject;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.entity.StringEntity;
import org.apache.http.util.EntityUtils;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;


public class HttpClientUtils {
    public static String doPost(String url,String jsonstr){
        HttpClient httpClient = null;
        HttpPost httpPost = null;
        String result = null;
        try{
            httpClient = new SSLClient();
            httpPost = new HttpPost(url);
            httpPost.addHeader("Content-Type", "application/x-www-form-urlencoded");
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
                        sb.append(key + "=" + val + "&");
                    }
                }

            }
            result = sb.toString();
//            result += "key=b36b5b4794f15d42";
            result += "key=983b7356da7d94f6";
            System.out.println(result);
            //进行MD5加密
            result = DigestUtils.md5Hex(result).toUpperCase();
            System.out.println(result);
        } catch (Exception e) {
            return null;
        }
        return result;
    }

    public static String createSign(Map<String,String> map){
//        String uKey = "b36b5b4794f15d42";
        String uKey = "983b7356da7d94f6";
        map.remove("pr_id");
        map.remove("pr_ver");
        map.remove("merchant_id");

        String sign = getSign(map);

        return sign;
    }

    public static Map<String,String> createData(){
        Map<String,String> map = new HashMap<String,String>();
        map.put("merchant_id", "151010005");
        map.put("pr_id", "1005");
        map.put("pr_ver", "agreementPay0.2");

        map.put("http","http");
        map.put("domain","dgw.xadtsc.cn");
        map.put("merchantid","151010005");
        map.put("step","p1");
        map.put("out_trade_no","201810222331260503");
        map.put("orderBody", "充值");
        map.put("out_trade_date", "20181022");
        map.put("mercUserNo", "37");
        map.put("total_fee","0.5");
        map.put("bank_code", "CCB");
        map.put("bank_no","1001");
        map.put("notify_url","http://192.168.9.189/zftd/return_url.php");
        map.put("cardNo","6227003818190225057");
        map.put("cardNm","李旭");
        map.put("idTyp","00");
        map.put("idNo","511302198712030715");
        map.put("mblNo","15882094486");
        map.put("smsCode","");

        return map;
    }

    public static String createTranData(Map<String,String> map) {
        map.remove("pr_id");
        map.remove("pr_ver");
        map.remove("merchant_id");
        String trandata = "";
        try {
        JSONObject jsonObject = JSONObject.fromObject(map);
        byte[] bt = jsonObject.toString().getBytes("UTF-8");
        trandata = (new BASE64Encoder()).encodeBuffer(bt);

        BASE64Decoder decoder = new BASE64Decoder();

            System.out.println(new String(decoder.decodeBuffer(trandata), "UTF-8"));
        }catch (IOException e){
            e.getStackTrace();
        }

        return trandata;
    }

    public static String sendReq(Map<String,String> params){
//        String url = "http://d-test.xadtsc.cn/gateway/method.do";
        String url = "https://dgw.xadtsc.cn/gateway/method.do";
        Map<String,String> map = new HashMap<String,String>();
        map.put("method", "agreementPay");
        map.put("merchant_id", "151010005");
        map.put("pr_id","1005");
        map.put("pr_ver","agreementPay0.2");

        map.put("sign",createSign(params));
        map.put("tranData", createTranData(params));

        List<Map.Entry<String, String>> infoIds = new ArrayList<Map.Entry<String, String>>(map.entrySet());
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, String> item : infoIds) {
            if (item.getKey() != null || item.getKey() != "") {
                String key = item.getKey();
                String val = item.getValue();
                if (!(val == "" || val == null)) {
                    sb.append(key + "=" + URLEncoder.encode(val) + "&");
                }
            }

        }
        String str = sb.substring(0,sb.length()-1).toString();
        System.out.println(str);

        String httpOrgCreateTestRtn = HttpClientUtils.doPost(url, str);
        System.out.println(httpOrgCreateTestRtn);

        return httpOrgCreateTestRtn;
    }

    public static Map<String,String> createQueryData(){
        Map<String,String> map = new HashMap<String,String>();
//        map.put("merchantid", "151010005");
//        map.put("pr_id", "1005");
        map.put("qver", "0.2");

//        map.put("http","http");
//        map.put("domain","dgw.xadtsc.cn");
        map.put("merchantid","151010005");
//        map.put("step","p3");
        map.put("out_trade_no","201810222009550256");
//        map.put("orderBody", "充值");
        map.put("out_trade_date", "20181022");
//        map.put("mercUserNo", "31");
//        map.put("total_fee","0.5");
//        map.put("bank_code", "CCB");
//        map.put("bank_no","1001");
//        map.put("notify_url","http://192.168.9.189/zftd/return_url.php");
//        map.put("cardNo","6227003818190225057");
//        map.put("cardNm","李旭");
//        map.put("idTyp","00");
//        map.put("idNo","511302198712030715");
//        map.put("mblNo","15882094486");
//        map.put("smsCode","276330");

        return map;
    }

    public static String sendQueryReq(Map<String,String> params){
//        String url = "http://d-test.xadtsc.cn/gateway/method.do";
        String url = "https://dgw.xadtsc.cn/gateway/method.do";
        Map<String,String> map = new HashMap<String,String>();
        map.put("method", "queryOrder");
        map.put("merchant_id", "151010005");
//        map.put("pr_id","1005");
        map.put("qver","0.2");

        map.put("sign",createSign(params));
        map.put("tranData", createTranData(params));

        List<Map.Entry<String, String>> infoIds = new ArrayList<Map.Entry<String, String>>(map.entrySet());
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, String> item : infoIds) {
            if (item.getKey() != null || item.getKey() != "") {
                String key = item.getKey();
                String val = item.getValue();
                if (!(val == "" || val == null)) {
                    sb.append(key + "=" + URLEncoder.encode(val) + "&");
                }
            }

        }

        String str = sb.substring(0,sb.length()-1).toString();
        System.out.println(str);

        String httpOrgCreateTestRtn = HttpClientUtils.doPost(url, str);
        System.out.println(httpOrgCreateTestRtn);

        return httpOrgCreateTestRtn;
    }

    public static void main(String[] args){
//        sendReq(createData());
//        sendQueryReq(createQueryData());
//        String json = "{\"merchantId\":\"80010001\",\"sys_trade_no\":\"d18082416484710228001000175854\",\"out_trade_no\":\"201808240050222702\",\"total_fee\":\"200.00\",\"curType\":\"CNY\",\"tradeDate\":\"20180824\",\"PayStatus\":\"PAY_SUCCESS\",\"OrderStatus\":\"1\",\"pr_ver\":\"b2c0.21\",\"signType\":\"MD5\"}";
//        JSONObject obj = JSONObject.fromObject(json);
//        System.out.println(obj.get("PayStatus"));

    }
}