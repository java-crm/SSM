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
	
	/**
	 * 
	 * 查看离线时接受的信息二次登录后做提示
	 * @param chatfunction
	 * @return
	 */
	List<Chatfunction> selectChatfunctionIsWeiDu(Chatfunction chatfunction);
	
	/**
	 * 修改为点击查看与谁的聊天记录就修改为已读状态
	 * @param chatfunction
	 * @return
	 */
	void updateChatfunctionIsYiDu(Chatfunction chatfunction);
	
}
