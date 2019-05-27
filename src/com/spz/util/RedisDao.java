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
		//redis����
		try {
			Jedis jedis=jedisPool.getResource();
			//jedis.auth("12345");
			try {
				String key="push:"+name;
				//��û��ʵ���ڲ����л�
				//get->byte[] ->�����л� ->OBject(stu_id)
				//�����Զ������л�
				byte[] bs = jedis.get(key.getBytes());
				//�����л�ȡ������
				if(bs != null ) {
					//�ն���
					Push push=schema.newMessage();
					ProtostuffIOUtil.mergeFrom(bs, push, schema);
					//stu_id��������
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
		// set OBject(Students) -> ���л�-> byte[] 
		try {
			Jedis jedis=jedisPool.getResource();
			//jedis.auth("12345");
				try {
					String key ="push:"+push.getZxname();//��ѯʦ������Ϊ��ֵ
					byte[] bytes=ProtostuffIOUtil.toByteArray(push, schema, //������
							LinkedBuffer.allocate(LinkedBuffer.DEFAULT_BUFFER_SIZE));
					//��ʱ����	
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
