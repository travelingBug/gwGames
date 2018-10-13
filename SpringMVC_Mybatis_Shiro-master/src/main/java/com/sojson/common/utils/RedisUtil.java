package com.sojson.common.utils;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;
import redis.clients.jedis.exceptions.JedisDataException;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by lx on 2018/8/21.
 */
public class RedisUtil {

    static Map<String,String> jedis = new ConcurrentHashMap<String,String>();


    /**
     * 新增
     * @param sessionId
     * @param userId
     */
    public static void save(String sessionId, String userId){
        jedis.put(sessionId, userId);
    }

    /**
     * 删除指定sessionId
     * @param sessionId
     */
    public static void delete(String sessionId){
        jedis.remove(sessionId);
    }

    /**
     * 获取redis中所有键值对
     * @return map
     */
    public static Map<String,String> getAll(){
        Map<String,String> map = new HashMap<String,String>();

        Set<String> keys = jedis.keySet();
        for(String key : keys){
            String val = jedis.get(key);
            map.put(key, val);
        }

        return map;
    }

    public static String get(String key){
        String value = "";
        try {
            value = jedis.get(key);
        }catch (Exception e){
            return "";
        }
        return value;
    }





}
