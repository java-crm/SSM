package com.spz.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.spz.dao.NetfollowsMapper;
import com.spz.entity.Fenye;
import com.spz.entity.Netfollows;
import com.spz.entity.Student;
import com.spz.service.NetfollowsService;

@Service
public class NetfollowsServiceImpl  implements NetfollowsService{

	@Autowired private NetfollowsMapper NetfollowsMapper;

	@Override
	public String selcetNet(Netfollows net) {
		// TODO Auto-generated method stub
		Fenye<Netfollows> fy = new Fenye<Netfollows>();
		net.setPage((net.getPage()-1)*net.getRows());
		
		fy.setRows(NetfollowsMapper.selectNet(net));
		fy.setTotal(NetfollowsMapper.selectNetcount(net));
		return new Gson().toJson(fy);
	}
}
