package com.spz.service;

import java.util.List;

import com.spz.entity.Roles;

public interface RolesService {
	/**
	 * ������ѯ��ɫ
	 * @return
	 */
	String selectRolesByRole(Roles roles);
	
	/**
	 * ��ӽ�ɫ
	 * @param roles
	 * @return
	 */
	Integer insertRoles(Roles roles);
	
	/**
	 * �޸ý�ɫ
	 * @param roles
	 * @return
	 */
	Integer updateRoles(Roles roles);
	
	/**
	 * ɾ����ɫ
	 * @param r_id
	 * @return
	 */
	Integer deleteRoles(Integer r_id);
	
	/**
	 * �жϽ�ɫ�Ƿ���ͬ
	 * @param roles
	 * @return
	 */
	Roles selectRolesByName(Roles roles);
}
