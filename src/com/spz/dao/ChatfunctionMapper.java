package com.spz.dao;

import java.util.List;

import com.spz.entity.Chatfunction;

public interface ChatfunctionMapper {
	/**
	 * 添加一条聊天信息
	 * @param chatfunction
	 * @return
	 */
	Integer insertChatfunction(Chatfunction chatfunction);
	
	/**
	 * 点开查看某个人的聊天记录
	 * @param chatfunction
	 * @return
	 */
	List<Chatfunction> selectChatfunction(Chatfunction chatfunction);
}
