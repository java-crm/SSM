package com.spz.dao;


import java.util.List;

import com.spz.entity.UserRoles;

public interface UserRolesMapper {
	
	/**
	 * 添加员工的角色
	 * @param r_id角色id
	 * @return
	 */
	Integer insertUserRoles(UserRoles usersRoles);
	
	/**
	 * 删除员工的角色
	 * @param u_id
	 * @return
	 */
	Integer deleteUserRoles(UserRoles usersRoles);
	
	/**
	 * 删除前查看被删除的角色是否有员工正在引用
	 * @param r_id 角色的id
	 * @return
	 */
	List<UserRoles> selectByR_id(Integer r_id);
}
