package com.spz.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.entity.Push;
import com.spz.service.PushService;

@Controller
public class PushController {
	
	@Autowired
	private PushService pushService;
	
	@RequestMapping (value="/selectPushTwo",method=RequestMethod.POST)
	@ResponseBody
	public String selectPush(Push push) {
		System.out.println(push);
		String selectPush = pushService.selectPush(push);
		System.out.println(selectPush);
		return selectPush;
	}
}
	