package com.spz.util;

import java.util.HashMap;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;

import com.spz.entity.Push;
import com.spz.service.StudentService;
import com.spz.service.impl.StudentServiceImpl;
import com.spz.service.impl.UsersServiceImpl;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

@ServerEndpoint(value="/webscoket/{u_id}")
public class MyWebscoket {
	private static Map<String, MyWebscoket> map=new HashMap<>();
	private String u_id;
	private Session session=null;
	private static int count=0;
	
	@OnOpen
	public void onopen(@PathParam(value="u_id") String u_id,Session session) {
		this.session=session;
		this.u_id=u_id;
		map.put(u_id,this);
		count++; 
	}
	@OnMessage
	public void onmessage(String message) {
		System.out.println("message"+message);
		String[] split = message.split(",");
		System.out.println(split.length);
		String formName=split[0];
		String tomName=split[1];
		String content=split[2];
		if(split.length==3){
			System.out.println("������");
			if(map.containsKey(tomName)) {
				map.get(tomName).session.getAsyncRemote().sendText(content+",�����ƽ�");
			}else {
				System.out.println("�������ѯʦ������");
			}
		}
		if(split.length>3) {
			String studentid=split[3];
			ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext-dao.xml");
			StudentServiceImpl bean=(StudentServiceImpl)context.getBean("studentServiceImpl");
			UsersServiceImpl usersServiceImpl=(UsersServiceImpl)context.getBean("usersServiceImpl");
			RedisDao redisDao=(RedisDao)context.getBean("redisDao");
			Push push = usersServiceImpl.selectPushByName(studentid);
			if(map.containsKey(tomName)) {
				//���ߵ������ֱ����Ӧ��Ϣ
				map.get(tomName).session.getAsyncRemote().sendText(push.getId()+"");
			}else {
				//�����ߵĻ��õ���Ϣ������ݿ��е����ߺ���֪ͨ
				String result = redisDao.putPush(push);
				System.out.println("д��redis:"+result.toLowerCase());
				System.out.println("������");
			}
		}
		
	}
	
	@OnClose
	public void onclose() {
		System.out.println("�ر�������");
		map.remove(u_id);
		count--;
	}
	
	@OnError
	public void onerror(Session session,Throwable throwable) {
		
	}
}
