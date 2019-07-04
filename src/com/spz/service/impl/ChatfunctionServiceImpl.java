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
		/*List<Chatfunction> isYiDuCount = chatfunctionMapper.selectChatfunctionIsYiDuCount(chatfunction);
		System.out.println("这俩人俩天记录已读的共："+isYiDuCount);
		chatfunction.setFsTime(isYiDuCount.get(isYiDuCount.size()-1).getFsTime());
		System.out.println("删除的数据"+chatfunction.toString());
		chatfunctionMapper.deleteChatfunctionliaotyidu(chatfunction);*/
	}
	
	@Override
	public List<Chatfunction> selectChatfunction(Chatfunction chatfunction) {
		List<Chatfunction> chatfunction2 = chatfunctionMapper.selectChatfunction(chatfunction);
		return chatfunction2;
	}

	@Override
	public List<Chatfunction> selectChatfunctionIsWeiDu(Chatfunction chatfunction) {
		return chatfunctionMapper.selectChatfunctionIsWeiDu(chatfunction);
	}

	@Override
	public void updateChatfunctionIsYiDu(Chatfunction chatfunction) {
		 chatfunctionMapper.updateChatfunctionIsYiDu(chatfunction);
	}
}
