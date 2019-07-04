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
	Integer updateChatfunctionIsYiDu(Chatfunction chatfunction);
	
	/**select * from chatfunction where  fszName=#{fszName} and jszName=#{jszName}  and isyidu='是'  ORDER BY fsTime desc limit 0,10
	 * 每次添加一条时都查看发送者和接受者的已读消息数量
	 * @param chatfunction
	 * @return
	 */
	List<Chatfunction> selectChatfunctionIsYiDuCount(Chatfunction chatfunction);
	
	/**
	 * 删除较早的十条聊天记录
	 * @param chatfunction
	 * @return
	 */
	Integer deleteChatfunctionliaotyidu(Chatfunction chatfunction);
}
