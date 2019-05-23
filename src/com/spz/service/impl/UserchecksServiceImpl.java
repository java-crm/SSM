package com.spz.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.spz.dao.UserchecksMapper;
import com.spz.entity.Fenye;
import com.spz.entity.Userchecks;
import com.spz.service.UserchecksService;
@Service
public class UserchecksServiceImpl implements UserchecksService {

	@Autowired private UserchecksMapper userchecksMapper;
	
	@Override
	public Userchecks selectUserchecks(Integer u_id) {
		return userchecksMapper.selectUserchecks(u_id);
	}
	@Override
	public Integer updateUserchecks(Userchecks userchecks) {
		return userchecksMapper.updateUserchecks(userchecks);
	}
	@Override
	public Integer insertUserchecks(Userchecks userchecks) {
		return userchecksMapper.insertUserchecks(userchecks);
	}
	
	
	
	/*ÀÔÀ˘¿Ÿ*/
	@Override
	public String selectUserCheckAll(Userchecks userchecks) {
		Fenye<Userchecks> fenye=new Fenye<Userchecks>();
		userchecks.setPage((userchecks.getPage()-1)*userchecks.getRows());
		fenye.setRows(userchecksMapper.selectUserCheckAll(userchecks));
		fenye.setTotal(userchecksMapper.selectUserCheckCount(userchecks));
		
		return new Gson().toJson(fenye);
	}
	
	@Override
	public Integer updateUserchecksPL(Userchecks userchecks) {
		return userchecksMapper.updateUserchecksPL(userchecks);
	}
	
	@Override
	public String selectUsersByYuanGong() {
		return new Gson().toJson(userchecksMapper.selectUsersByYuanGong());
	}

}
