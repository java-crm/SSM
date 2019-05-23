package com.spz.dao;

import java.util.List;

import com.spz.entity.RoleModules;
import com.spz.entity.Roles;

public interface RoleModulesMapper {
	
	/**
	 * 添加角色的模块
	 * @param roleModules 包含要添加的角色id,以及list的m_id
	 * @return
	 */
	Integer insertRoleModules(Integer r_id,Integer m_id);
	
	/**
	 * 删除角色下的所有模块
	 * @param r_id  角色id
	 * @return
	 */
	Integer deleteRoleModules(Integer r_id); 
	
	/**
	 * 删除模块前判断是否被引用
	 * @param m_id
	 * @return
	 */
	List<Roles> selectRolesByModulesID(Integer m_id);
}
