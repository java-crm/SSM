package com.spz.service;

import java.util.List;
import java.util.Map;

import com.spz.entity.Modules;


public interface ModulesService {
	/**
	 * ��ѯ����ģ��
	 * @return
	 */
	List<Map<String, Object>> selectModulesAll();
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
	 * ����id�鿴����ģ��
	 * @param m_id
	 * @return
	 */
	Modules selectModulesById(Integer m_id);
	
	/**
	 * ��ѯ��ɫ�µ�ģ��
	 * @param r_id
	 * @return
	 */
	List<Map<String, Object>> selectModulesByRolesId(Integer r_id);
}
