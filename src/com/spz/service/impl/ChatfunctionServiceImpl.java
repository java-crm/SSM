package com.spz.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spz.dao.ChatfunctionMapper;
import com.spz.entity.Chatfunction;
import com.spz.service.ChatfunctionService;
@Service
public class ChatfunctionServiceImpl implements ChatfunctionService {
	
	@Autowired private ChatfunctionMapper chatfunctionMapper;
	
	@Override
	public void insertChatfunction(Chatfunction chatfunction) {
		chatfunctionMapper.insertChatfunction(chatfunction);
	}
	
	@Override
	public List<Chatfunction> selectChatfunction(Chatfunction chatfunction) {
		List<Chatfunction> chatfunction2 = chatfunctionMapper.selectChatfunction(chatfunction);
		for (Chatfunction chatfunction3 : chatfunction2) {
			System.out.println(chatfunction3.toString());
		}
		return chatfunction2;
	}
	
}
