package com.spz.service;

import java.util.List;

import com.spz.entity.Chatfunction;

public interface ChatfunctionService {
	/**
	 * ���һ��������Ϣ
	 * @param chatfunction
	 * @return
	 */
	void insertChatfunction(Chatfunction chatfunction);
	
	/**
	 * �㿪�鿴ĳ���˵������¼
	 * @param chatfunction
	 * @return
	 */
	List<Chatfunction> selectChatfunction(Chatfunction chatfunction);
}
