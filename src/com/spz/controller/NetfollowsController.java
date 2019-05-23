package com.spz.controller;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.entity.Netfollows;

import com.spz.service.NetfollowsService;

@Controller
public class NetfollowsController {
	@Resource private NetfollowsService netfollowsService;
	
	@RequestMapping (value="selectNet",method=RequestMethod.POST)
	@ResponseBody
	public String selectNet(Netfollows net) {
		String selectNet = netfollowsService.selcetNet(net);
		return selectNet;
	}
}
