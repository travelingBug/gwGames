package com.sojson.weChat.utils;

import com.sojson.weChat.common.GlobalConstants;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.util.LinkedCaseInsensitiveMap;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class WxseverUtils {

    private static Logger logger = Logger.getLogger(WxseverUtils.class);


    /**
     * 取得微信access_token
     * @return
     */
    public static String access_token(){
        return GlobalConstants.getInterfaceUrl("access_token");
    }

    /**
     * 调用微信接口--获取access_token
     */
    public static void getWxaccess_token(){
        String json = "";
        try{
            json = HttpUtils.sendGet("https://api.weixin.qq.com/cgi-bin/token","grant_type=client_credential&appid="+GlobalConstants.getInterfaceUrl("appid")+"&secret="+GlobalConstants.getInterfaceUrl("AppSecret"));
            //正确：{"access_token":"ACCESS_TOKEN","expires_in":7200}
            //错误：{"errcode":40013,"errmsg":"invalid appid"}
            JSONObject jsonObject = JSONObject.fromObject(json);
            if (null != jsonObject) {
                String access_token = jsonObject.getString("access_token");
                GlobalConstants.interfaceUrlProperties.put("access_token", access_token);
                System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())+"token 为=============================="+access_token);
            }
        }catch (Exception e) {
            logger.error("调用微信接口【获取access_token】后，数据处理异常，得到结果【"+json+"】，异常为："+e.getMessage());
        }
    }


    /**
     * 调用微信接口--自定义菜单创建接口（https协议）
     * json :参数格式 ： {"button":[{"type":"click","name":"今日歌曲","key":"V1001_TODAY_MUSIC"},{"name":"菜单","sub_button":[{"type":"view","name":"搜索","url":"http://www.soso.com/"},{"type":"view","name":"视频","url":"http://v.qq.com/"},{"type":"click","name":"赞一下我们","key":"V1001_GOOD"}]}]}
     * @return
     */
    public static boolean setWxMenus(String jsonparam){
        boolean result=false;
        try{
            JSONObject jsonObject = HttpUtils.httpRequest("https://api.weixin.qq.com/cgi-bin/menu/create?access_token="+access_token(), "POST", jsonparam);
//          正常时：{"errcode":0,"errmsg":"ok"}
//			错误时：{"errcode":40018,"errmsg":"invalid button name size"}
            if (null != jsonObject) {
                String errcode = jsonObject.getString("errcode");
                if("0".equals(errcode)){
                    result=true;
                    logger.error("调用微信接口【自定义菜单创建接口】成功。");
                }else{
                    logger.error("调用微信接口【自定义菜单创建接口】失败，得到结果【"+jsonObject.getInt("errcode")+"】");
                }
            }
        }catch (Exception e) {
            logger.error(e, e);
        }
        return result;
    }

    /**
     * 发送模板消息
     * json :参数格式 ：{"touser":"OPENID","template_id":"ngqIpbwh8bUfcSsECmogfXcV14J0tQlEpBO27izEYtY","url":"http://weixin.qq.com/download","data":{"first":{"value":"恭喜你购买成功！","color":"#173177"},"keynote1":{"value":"巧克力","color":"#173177"},"keynote2":{"value":"39.8元","color":"#173177"},"keynote3":{"value":"2014年9月22日","color":"#173177"},"remark":{"value":"欢迎再次购买！","color":"#173177"}}}
     * @return
     */
    public static boolean sendMsg(String jsonparam){
        boolean result=false;
        try{
            JSONObject jsonObject = HttpUtils.httpRequest("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+access_token(), "POST", jsonparam);
//          正常时：{"errcode":0,"errmsg":"ok","msgid":200228332}
//			错误时：
            if (null != jsonObject) {
                String errcode = jsonObject.getString("errcode");
                if("0".equals(errcode)){
                    result=true;
                }else{
                    logger.error("调用微信接口【自定义菜单创建接口】失败，得到结果【"+jsonObject.getInt("errcode")+"】");
                }
            }
        }catch (Exception e) {
            logger.error(e, e);
        }
        return result;
    }

    /**
     * 调用微信接口--获取单个用户基本信息(UnionID机制)
     * @return
     */
    public static Map<String,Object> getWxUserInfo(String openid){
        Map<String,Object> resultmap=new LinkedCaseInsensitiveMap<Object>();
        String subscribers="";
        try {
            subscribers=HttpUtils.sendGet("https://api.weixin.qq.com/cgi-bin/user/info","access_token="+access_token()+"&openid="+openid+"&lang=zh_CN");
//			正常时：{"subscribe":1,"openid":"o6_bmjrPTlm6_2sgVt7hMZOPfL2M","nickname":"Band","sex":1,"language":"zh_CN","city":"广州","province":"广东","country":"中国","headimgurl":"http://wx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/0","subscribe_time":1382694957,"unionid":" o6_bmasdasdsad6_2sgVt7hMZOPfL""remark":"","groupid":0}
//			错误时：{"errcode":40013,"errmsg":"invalid appid"}
            JSONObject jsonObject = JSONObject.fromObject(subscribers);
            if(jsonObject!=null){
                resultmap.put("nickname",jsonObject.getString("nickname")); //昵称
                resultmap.put("headimgurl",jsonObject.getString("headimgurl"));  //图像
                resultmap.put("sex", jsonObject.getString("sex"));  //性别
                System.out.println(subscribers);
            }else{
                logger.error("调用微信接口【获取单个用户基本信息(UnionID机制)】失败，得到结果【"+subscribers+"】");
            }
        } catch (Exception e) {
            logger.error("调用微信接口【获取单个用户基本信息(UnionID机制)】后，数据处理异常，得到结果【"+subscribers+"】，异常为："+e.getMessage());
        }
        return resultmap;
    }

}
