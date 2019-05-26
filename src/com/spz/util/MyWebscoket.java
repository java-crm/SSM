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
		String[] split = message.split(",");
		String formName=split[0];
		String tomName=split[1];
		String content=split[2];
		//String studentid=split[3];
		if(map.containsKey(tomName)) {
			//���ߵ������ֱ����Ӧ��Ϣ
			map.get(tomName).session.getAsyncRemote().sendText(formName+" ����˵:"+content);
		}else {
			//�����ߵĻ��õ���Ϣ������ݿ��е����ߺ���֪ͨ
			ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext-dao.xml");
			StudentServiceImpl bean=(StudentServiceImpl)context.getBean("studentServiceImpl");
			/*Push push=new Push();
			push.setZxname(tomName);
			push.setStudentid(Integer.parseInt(studentid));
			push.setContext(content);
			push.setStudentname(formName);
			push.setIsreader(2);
			bean.addPush(push);*/
			bean.updatePushIsreader(bean.selectMaxId());
			System.out.println("������");
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