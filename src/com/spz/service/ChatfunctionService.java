package com.spz.service;

import java.util.List;

import com.spz.entity.Chatfunction;

public interface ChatfunctionService {
	/**
	 * 添加一条聊天信息
	 * @param chatfunction
	 * @return
	 */
	void insertChatfunction(Chatfunction chatfunction);
	
	/**
	 * 点开查看某个人的聊天记录
	 * @param chatfunction
	 * @return
	 */
	List<Chatfunction> selectChatfunction(Chatfunction chatfunction);
}
