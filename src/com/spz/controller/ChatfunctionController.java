package com.spz.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.entity.Chatfunction;
import com.spz.service.ChatfunctionService;

@Controller
public class ChatfunctionController {
	@Autowired private ChatfunctionService chatfunctionService;
	
	@RequestMapping(value="/selectChatfunction",method=RequestMethod.POST)
	@ResponseBody
	public List<Chatfunction> selectChatfunction(Chatfunction chatfunction){
		return chatfunctionService.selectChatfunction(chatfunction);
	}
	
	@RequestMapping(value="/insertChatfunction",method=RequestMethod.POST)
	public void insertChatfunction(Chatfunction chatfunction){
		chatfunctionService.insertChatfunction(chatfunction);
	}
	
	@RequestMapping(value="/selectChatfunctionIsWeiDu",method=RequestMethod.POST)
	@ResponseBody
	public List<Chatfunction> selectChatfunctionIsWeiDu(Chatfunction chatfunction){
		return chatfunctionService.selectChatfunctionIsWeiDu(chatfunction);
	}
	
	@RequestMapping(value="/updateChatfunctionIsYiDu",method=RequestMethod.POST)
	public void updateChatfunctionIsYiDu(Chatfunction chatfunction){
		chatfunctionService.updateChatfunctionIsYiDu(chatfunction);
	}
}
