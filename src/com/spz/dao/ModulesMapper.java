package com.spz.dao;

import java.util.List;

import com.spz.entity.Modules;

public interface ModulesMapper {
	
	/**
	 * ���ģ��
	 * @param modules
	 * @return
	 */
	Integer insertModules(Modules modules);
	
	/**
	 * �޸�ģ��
	 * @param modules
	 * @return
	 */
	Integer updateModules(Modules modules);
	
	/**
	 * ɾ��ģ��
	 * @param m_id ģ��id
	 * @return
	 */
	Integer deleteModules(Integer m_id);
	/**
	 * ɾ��������ģ��
	 * @param m_parentId 
	 * @return
	 */
	Integer deleteModulesByP_id(Integer m_parentId);

	/**
	 * ��ѯ����ģ��
	 * @return
	 */
	List<Modules> selectModulesAll();
	
	/**
	 * ����id�鿴
	 * @return
	 */
	Modules selectModulesById(Integer m_id);
	
	/**
	 * ��ѯ��ɫ�µ�ģ��
	 * @param r_id
	 * @return
	 */
	List<Modules> selectModulesByRolesId(Integer r_id);
}
