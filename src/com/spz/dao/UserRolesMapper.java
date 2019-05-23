package com.spz.dao;


import java.util.List;

import com.spz.entity.UserRoles;

public interface UserRolesMapper {
	
	/**
	 * ���Ա���Ľ�ɫ
	 * @param r_id��ɫid
	 * @return
	 */
	Integer insertUserRoles(UserRoles usersRoles);
	
	/**
	 * ɾ��Ա���Ľ�ɫ
	 * @param u_id
	 * @return
	 */
	Integer deleteUserRoles(UserRoles usersRoles);
	
	/**
	 * ɾ��ǰ�鿴��ɾ���Ľ�ɫ�Ƿ���Ա����������
	 * @param r_id ��ɫ��id
	 * @return
	 */
	List<UserRoles> selectByR_id(Integer r_id);
}
