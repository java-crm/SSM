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
	
	/**
	 * 
	 * �鿴����ʱ���ܵ���Ϣ���ε�¼������ʾ
	 * @param chatfunction
	 * @return
	 */
	List<Chatfunction> selectChatfunctionIsWeiDu(Chatfunction chatfunction);
	
	/**
	 * �޸�Ϊ����鿴��˭�������¼���޸�Ϊ�Ѷ�״̬
	 * @param chatfunction
	 * @return
	 */
	Integer updateChatfunctionIsYiDu(Chatfunction chatfunction);
	
	/**select * from chatfunction where  fszName=#{fszName} and jszName=#{jszName}  and isyidu='��'  ORDER BY fsTime desc limit 0,10
	 * ÿ�����һ��ʱ���鿴�����ߺͽ����ߵ��Ѷ���Ϣ����
	 * @param chatfunction
	 * @return
	 */
	List<Chatfunction> selectChatfunctionIsYiDuCount(Chatfunction chatfunction);
	
	/**
	 * ɾ�������ʮ�������¼
	 * @param chatfunction
	 * @return
	 */
	Integer deleteChatfunctionliaotyidu(Chatfunction chatfunction);
}
