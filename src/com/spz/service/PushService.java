package com.spz.service;

import com.spz.entity.Push;

public interface PushService {
	/**
	 * 多条件分页查询
	 * @param push
	 * @return
	 */
	
	String selectPush(Push push);
}
