package com.sojson.weChat.init;

import com.sojson.weChat.common.GlobalConstants;
import com.sojson.weChat.utils.WxseverUtils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * ClassName: InterfaceUrlInti
 * @Description: 项目启动初始化方法
 * @author hwj
 */
public class InterfaceUrlInit {

    public synchronized static void init(){
        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        Properties props = new Properties();
        if(GlobalConstants.interfaceUrlProperties==null){
            GlobalConstants.interfaceUrlProperties = new Properties();
        }
        InputStream in = null;
        try {
            in = cl.getResourceAsStream("wechat.properties");
            props.load(in);
            for(Object key : props.keySet()){
                System.out.println(key+"--------"+props.get(key));
                GlobalConstants.interfaceUrlProperties.put(key, props.get(key));
            }
            WxseverUtils.getWxaccess_token();
        } catch (IOException e) {
            e.printStackTrace();
        }finally{
            if(in!=null){
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return;
    }
}
