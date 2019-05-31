package com.spz.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.spz.dao.PushMapper;
import com.spz.entity.Fenye;
import com.spz.entity.Push;
import com.spz.service.PushService;
@Service
public class PushServiceImpl implements PushService {
	@Autowired
	private PushMapper pushMapper;

	@Override
	public  String selectPush(Push push) {
		Fenye<Push> fy = new Fenye<Push>();
		push.setPage((push.getPage()-1)*push.getRows());
		fy.setRows(pushMapper.selectPush(push));
		fy.setTotal(pushMapper.selectPushcount(push));
		
		return new Gson().toJson(fy);
	}
	
	
}
