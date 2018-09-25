package com.sojson.weChat.task;

import com.sojson.weChat.utils.WxseverUtils;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class MyTask {

    /***
     * 每1个小时获取 token
     **/
    @Scheduled(cron = "0 0 */1 * * *")
    public void run() {
        System.out.println("MyTask执行....");
        WxseverUtils.getWxaccess_token();
    }
}
