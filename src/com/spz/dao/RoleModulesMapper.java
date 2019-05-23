package com.spz.dao;

import java.util.List;

import com.spz.entity.RoleModules;
import com.spz.entity.Roles;

public interface RoleModulesMapper {
	
	/**
	 * ��ӽ�ɫ��ģ��
	 * @param roleModules ����Ҫ��ӵĽ�ɫid,�Լ�list��m_id
	 * @return
	 */
	Integer insertRoleModules(Integer r_id,Integer m_id);
	
	/**
	 * ɾ����ɫ�µ�����ģ��
	 * @param r_id  ��ɫid
	 * @return
	 */
	Integer deleteRoleModules(Integer r_id); 
	
	/**
	 * ɾ��ģ��ǰ�ж��Ƿ�����
	 * @param m_id
	 * @return
	 */
	List<Roles> selectRolesByModulesID(Integer m_id);
}
