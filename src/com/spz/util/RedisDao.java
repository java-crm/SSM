package com.spz.util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.dyuproject.protostuff.LinkedBuffer;
import com.dyuproject.protostuff.ProtostuffIOUtil;
import com.dyuproject.protostuff.runtime.RuntimeSchema;
import com.spz.entity.Push;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
public class RedisDao {
	private final Logger logger= LoggerFactory.getLogger(this.getClass());
	private final JedisPool jedisPool;
	
	public RedisDao(String ip, int port) {
		jedisPool = new JedisPool(ip,port);
	}
	
	private RuntimeSchema<Push> schema=RuntimeSchema.createFrom(Push.class);
		
	public Push getPush(String name) {
		//redis操作
		try {
			Jedis jedis=jedisPool.getResource();
			//jedis.auth("12345");
			try {
				String key="push:"+name;
				//并没有实现内部序列化
				//get->byte[] ->反序列化 ->OBject(stu_id)
				//采用自定义序列化
				byte[] bs = jedis.get(key.getBytes());
				//缓存中获取到数据
				if(bs != null ) {
					//空对象
					Push push=schema.newMessage();
					ProtostuffIOUtil.mergeFrom(bs, push, schema);
					//stu_id被反序列
					return push;
				}
			} finally {
				jedis.close();
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return null;
	}
	public String putPush(Push push) {
		// set OBject(Students) -> 序列化-> byte[] 
		try {
			Jedis jedis=jedisPool.getResource();
			//jedis.auth("12345");
				try {
					String key ="push:"+push.getZxname();//咨询师名字作为键值
					byte[] bytes=ProtostuffIOUtil.toByteArray(push, schema, //缓存器
							LinkedBuffer.allocate(LinkedBuffer.DEFAULT_BUFFER_SIZE));
					//超时缓存	
					int timeout=60*60;
					String result = jedis.setex(key.getBytes(), timeout, bytes);
					return result;
				} finally {
					jedis.close();
				}
			}catch (Exception e) {
				logger.error(e.getMessage(), e);
			}
		return null;
	}
}
