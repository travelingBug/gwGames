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
        map.put("pr_id", "1022");
        map.put("pr_ver", "Quickpay0.2");

        map.put("http","http");
        map.put("domain","dgw.xadtsc.cn");
        map.put("merchantid","151010005");
        map.put("step","p1");
        map.put("out_trade_no","201811231035070856");
        map.put("orderBody", "充值");
        map.put("out_trade_date", "20181123");
        map.put("mercUserNo", "99");
        map.put("total_fee","0.5");
        map.put("bank_code", "GDB");
        map.put("bank_no","1001");
        map.put("notify_url","http://192.168.9.189/zftd/return_url.php");
        map.put("cardNo","6214624021000108723");
        map.put("cardNm","胡洵");
        map.put("idTyp","00");
        map.put("idNo","430402197602031012");
        map.put("mblNo","15807156211");
        map.put("smsCode","");
        map.put("curType", "CNY");

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
//        map.put("method", "agreementPay");
        map.put("method", "QuickPay");
        map.put("merchant_id", "151010005");
        map.put("pr_id","1022");
        map.put("pr_ver","Quickpay0.2");

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

    public static String pay(Map<String,String> params){
        String customerid="303083";//商户在网关系统上的商户号
        String sdcustomno = params.get("orderNo");
        String orderAmount = params.get("amount");
        String cardno = params.get("cardno");
        String mark = params.get("level");
        String backurl = params.get("backurl");
//        String sdcustomno="2018122310425231164";//订单在商户系统中的流水号
//        String orderAmount="100";//金额,单位分
//        String cardno="32";//支付类型:32(微信扫码),41(微信WAP,微信公众号),42(支付宝),44(支付宝WAP),36(QQ扫码),45(QQ支付WAP),51,66(小程序)
//        String key="42C8938E4CF5777700700E642DC2A8CD";//key值请联系商务人员获取
//        String mark="test123";//数字+字母 不能存在中文 例如：test123
//        String noticeurl="http://2v316q1656.iok.la:53323/interface/vipsBankCard/orderInfo.shtml";//异步通知地址,不能带任何参数,否则异步通知不会成功
//        String backurl="http://2v316q1656.iok.la:53323/static/vips/vips_center.jsp";//付款成功,同步跳转（不带参数）
        String noticeurl = "http://zhgs.vips/interface/vipsBankCard/orderInfo.shtml";

        String key = "91F5738A827405B0F0BD80AF1B7E386C";
        String remarks="购票";//简短的中文说明,为空时,取mark
        try {
            remarks = URLEncoder.encode(remarks, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.getStackTrace();
        }
        String zftype="1";//返回类型 1:直接跳转 2:返回xml 3:返回json
        String Md5str= "customerid=" + customerid + "&sdcustomno=" + sdcustomno + "&orderAmount=" + orderAmount + "&cardno=" + cardno + "&noticeurl=" + noticeurl + "&backurl=" + backurl + key;

        String sign  = DigestUtils.md5Hex(Md5str).toUpperCase();

        String gourl="http://api.unpay.com/PayMegerHandler.ashx?customerid=" + customerid + "&sdcustomno=" + sdcustomno + "&orderAmount=" + orderAmount + "&cardno=" + cardno + "&noticeurl=" + noticeurl + "&backurl=" + backurl + "&sign=" + sign + "&mark=" + mark + "&remarks=" + remarks + "&zftype="+zftype;
//        response.sendRedirect(gourl);

        String url = "http://api.unpay.com/PayMegerHandler.ashx";
        String str = "customerid=" + customerid + "&sdcustomno=" + sdcustomno + "&orderAmount=" + orderAmount + "&cardno=" + cardno + "&noticeurl=" + noticeurl + "&backurl=" + backurl + "&sign=" + sign + "&mark=" + mark + "&remarks=" + remarks + "&zftype="+zftype;
        String returnStr = HttpClientUtils.doPost(url, str);

        return returnStr;
    }

    public static void main(String[] args){
//        Map<String,String> params = new HashMap<String,String>();
//        params.put("orderNo","2018122310425231173");
//        params.put("amount","100");
//        params.put("cardno","51");
//        params.put("level","level1");
//        System.out.println(pay(params));

//        String msg = HttpClientUtils.sendReq(createData());
//        JSONObject obj = JSONObject.fromObject(msg);
//        System.out.println(obj);
//        sendReq(createData());
//        sendQueryReq(createQueryData());
//        String json = "{\"merchantId\":\"80010001\",\"sys_trade_no\":\"d18082416484710228001000175854\",\"out_trade_no\":\"201808240050222702\",\"total_fee\":\"200.00\",\"curType\":\"CNY\",\"tradeDate\":\"20180824\",\"PayStatus\":\"PAY_SUCCESS\",\"OrderStatus\":\"1\",\"pr_ver\":\"b2c0.21\",\"signType\":\"MD5\"}";
//        JSONObject obj = JSONObject.fromObject(json);
//        System.out.println(obj.get("PayStatus"));


    }
}