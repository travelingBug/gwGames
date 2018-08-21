package com.sojson.common.utils;

import redis.clients.jedis.*;

import java.util.*;

/**
 * Created by lx on 2018/8/21.
 */
public class RedisUtil {

    private static Jedis jedis;//非切片额客户端连接
    private static JedisPool jedisPool;//非切片连接池
    private static RedisUtil instance;


    public synchronized static RedisUtil getRedis(){
        if(instance==null){
            instance = new RedisUtil();
        }
        return instance;
    }

    private RedisUtil(){
        initialPool();
        jedis = jedisPool.getResource();
    }

    /**
     * 初始化非切片池
     */
    private static void initialPool(){
        // 池基本配置
        JedisPoolConfig config = new JedisPoolConfig();
        config.setMaxIdle(100);
        config.setMaxTotal(100);
        config.setTestOnBorrow(false);

        jedisPool = new JedisPool(config,"127.0.0.1",6379);
    }

    /**
     * 刷新生命周期
     * @param sessionId
     */
    public static void reflushLifeCycle(String sessionId){
        jedis.expire(sessionId, 60*60*2);
    }

    /**
     * 新增
     * @param sessionId
     * @param userId
     */
    public static void save(String sessionId, String userId){
        jedis.set(sessionId, userId);
    }

    /**
     * 删除指定sessionId
     * @param sessionId
     */
    public static void delete(String sessionId){
        jedis.del(sessionId);
    }

    /**
     * 获取redis中所有键值对
     * @return map
     */
    public static Map<String,String> getAll(){
        Map<String,String> map = new HashMap<String,String>();

        Set<String> keys = jedis.keys("*");
        Iterator<String> it=keys.iterator() ;
        while(it.hasNext()){
            String key = it.next();
            String val = jedis.get(key);
            map.put(key, val);
        }

        return map;
    }

}
