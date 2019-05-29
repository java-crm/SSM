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

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.spz.entity.Chatfunction;
import com.spz.service.impl.ChatfunctionServiceImpl;
import com.spz.service.impl.StudentServiceImpl;


@ServerEndpoint(value="/webscoketRescore/{name}")
public class Webscoket {
	private static Map<String, Webscoket> map=new HashMap<>();
	private String name;
	private Session session=null;
	private static int count=0;
	
	@OnOpen
	public void onopen(@PathParam(value="name") String name,Session session) {
		this.session=session;
		this.name=name;
		map.put(name,this);
		count++; 
	}
	
	@OnMessage
	public void onmessage(String message) {
		String[] split = message.split(",");
		String formName=split[0];
		String tomName=split[1];
		String content=split[2];
		ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext-dao.xml");
		ChatfunctionServiceImpl bean=(ChatfunctionServiceImpl)context.getBean("chatfunctionServiceImpl");
		Chatfunction chatfunction=new Chatfunction();
		chatfunction.setFszName(formName);
		chatfunction.setJszName(tomName);
		chatfunction.setFsContext(content);
		if(map.containsKey(tomName)) {
			//在线的情况下直接相应消息
			map.get(tomName).session.getAsyncRemote().sendText(content+","+formName);
			chatfunction.setIsyidu("是");
			bean.insertChatfunction(chatfunction);
		}else {
			//不在线的话得到消息后存数据库中等上线后再通知
			chatfunction.setIsyidu("否");
			bean.insertChatfunction(chatfunction);
			System.out.println("不在线");
		}
	}
	
	@OnClose
	public void onclose() {
		System.out.println("关闭了连接");
		map.remove(name);
		count--;
	}
	
	@OnError
	public void onerror(Session session,Throwable throwable) {
		
	}
}
