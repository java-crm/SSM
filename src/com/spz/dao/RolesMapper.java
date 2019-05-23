package com.spz.dao;

import java.util.List;

import com.spz.entity.Roles;

public interface RolesMapper {
	
	/**
	 * ��ѯȫ����ɫ
	 * @return
	 */
	List<Roles> selectRolesAll();
	
	/**
	 * ��ѯ�û����ھ��еĽ�ɫ
	 * @return
	 */
	List<Roles> selectRolesAllbyU_id(Integer u_id);
	
	//ǰ���� UsersService��
	
	/**
	 * ������ѯ��ɫ
	 * @return
	 */
	List<Roles> selectRolesByRole(Roles roles);
	
	/**
	 * ������ѯ��ɫ����
	 * @return
	 */
	Integer selectRolesByRoleCount(Roles roles);
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
