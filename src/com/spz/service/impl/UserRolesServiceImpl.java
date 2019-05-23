package com.spz.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spz.dao.UserRolesMapper;
import com.spz.entity.UserRoles;
import com.spz.service.UserRolesService;
@Service
public class UserRolesServiceImpl implements UserRolesService {
	@Autowired
	private UserRolesMapper userRolesMapper;
	
	@Override
	public Integer insertUserRoles(UserRoles usersRoles) {
		return userRolesMapper.insertUserRoles(usersRoles);
	}
	
	@Override
	public Integer deleteUserRoles(UserRoles usersRoles) {
		return userRolesMapper.deleteUserRoles(usersRoles);
	}

	@Override
	public List<UserRoles> selectByR_id(Integer r_id) {
		return userRolesMapper.selectByR_id(r_id);
	}

}
