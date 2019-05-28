package com.spz.dao;

import java.util.List;

import com.spz.entity.Push;

public interface PushMapper {
		List<Push>  selectPush(Push push);
		 
		Integer selectPushcount(Push push);
}
