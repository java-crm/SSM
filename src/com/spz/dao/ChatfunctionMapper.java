package com.spz.dao;

import java.util.List;

import com.spz.entity.Chatfunction;

public interface ChatfunctionMapper {
	/**
	 * ���һ��������Ϣ
	 * @param chatfunction
	 * @return
	 */
	Integer insertChatfunction(Chatfunction chatfunction);
	
	/**
	 * �㿪�鿴ĳ���˵������¼
	 * @param chatfunction
	 * @return
	 */
	List<Chatfunction> selectChatfunction(Chatfunction chatfunction);
}
