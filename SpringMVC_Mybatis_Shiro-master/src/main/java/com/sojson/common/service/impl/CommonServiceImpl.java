package com.sojson.common.service.impl;/**
 * @Author: hy
 * @Description:
 * @Date:${Time} ${Date}
 **/

import com.sojson.common.IConstant;
import com.sojson.common.dao.UTbVipsMapper;
import com.sojson.common.service.CommonService;
import com.sojson.common.utils.EncryptUtils;
import com.sojson.common.utils.RedisUtil;
import org.apache.shiro.util.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName:CommonServiceImpl
 * @Description:TODO
 * @Author:yamol
 * @Date:2018-10-3 9:40
 * @VERSION: 1.0
 */
@Service
public class CommonServiceImpl implements CommonService {

    @Resource
    UTbVipsMapper uTbVipsMapper;

    @Override
    public String getTimeByToken(HttpServletRequest request) throws Exception{
        String token = request.getHeader("Authorization");
            String content = EncryptUtils.aesDecrypt(token, IConstant.key);
            //判断接收的参数格式是否正确
            String[] contentArr = content.split(",");
            Object phone = RedisUtil.get(contentArr[0]);
            SimpleDateFormat dft=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = new Date();
            Calendar dar=Calendar.getInstance();
            dar.setTime(date);

            int preHour = 0;
            byte level = uTbVipsMapper.getLevelByPhone(phone.toString().split(",")[0]);
            if (level == IConstant.VIP_LEVEL.VIP_A.v) {
                preHour = -48;
            } else if (level == IConstant.VIP_LEVEL.VIP_B.v) {
                preHour = -24;
            } else if (level == IConstant.VIP_LEVEL.VIP_C.v) {
                preHour = -2;
            } else { //没有开通会员
                return null;
            }
            dar.add(java.util.Calendar.HOUR_OF_DAY, preHour);
            return dft.format(dar.getTime());
    }

    @Override
    public String getUserPhone(HttpServletRequest request) throws Exception{
        String token = request.getHeader("Authorization");
        String content = EncryptUtils.aesDecrypt(token, IConstant.key);
        //判断接收的参数格式是否正确
        String[] contentArr = content.split(",");
        Object phone = RedisUtil.get(contentArr[0]);
        return phone.toString().split(",")[0];
    }

    @Override
    public String getNickName(HttpServletRequest request) throws Exception{
        String token = request.getHeader("Authorization");
        String content = EncryptUtils.aesDecrypt(token, IConstant.key);
        String[] contentArr = content.split(",");
        String value = RedisUtil.get(contentArr[0]);
        //判断接收的参数格式是否正确
        if (value.indexOf(",") >=0 ) {
            return value.substring(value.indexOf(",") + 1);
        }
        return null;
    }

    @Override
    public String getToken(HttpServletRequest request) throws Exception{
        String token = request.getHeader("Authorization");
        String content = EncryptUtils.aesDecrypt(token, IConstant.key);
        //判断接收的参数格式是否正确
        return content.split(",")[0];
    }
}
