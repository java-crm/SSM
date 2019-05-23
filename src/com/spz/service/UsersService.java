package com.spz.service;

import java.util.List;
import java.util.Map;

import com.spz.entity.Roles;
import com.spz.entity.Users;

public interface UsersService {
	/**
	 * ��������ҳ��ѯ
	 * @param users
	 * @return
	 */
	String selectUsersByUsers(Users users);
	
	/**
	 * ���Ա��
	 * @param users
	 * @return
	 */
	Integer insertUsers(Users users);
	
	/**
	 * �޸�Ա��
	 * @param users
	 * @return
	 */
	Integer updateUsers(Users users);	
	
	/**
	 * ɾ��Ա��
	 * @param u_id
	 * @return
	 */
	Integer deleteUsers(Integer u_id);
	
	/**
	 * ��½ʱ(ע��ʱ)ʹ�ò�ѯԱ��
	 * @param users
	 * @return
	 */
	Users selectUserBylogin(Users users);
	
	/**
	 * ��ѯ��¼���û���ģ��
	 * @param u_id
	 * @return
	 */
	List<Map<String, Object>> selectUserModuls(Integer u_id);
	
	/**
	 * ��ѯȫ����ɫand�û����ھ��еĽ�ɫ
	 * @return
	 */
	List<Roles> selectRolesAll();
	
	/**
	 * ��ѯ�û����ھ��еĽ�ɫ
	 * @return
	 */
	List<Roles> selectRolesAllbyU_id(Integer u_id);
	
	/**
	 *  ��ѯ�Ѵ���ѯʦ�ɽ���ѧ���ܸ���������¼���δ�ɽ��ĸ������Լ��ɹ���,���챻�����ѧ������
	 * @return Users��������ά����count����ѯʦ��ȫ��ѧ��������counts����ѯʦ�Ļ�δ�ɽ���ѧ��������counts/count=bfb ��ѯʦ�ĳɹ���
	 */
	List<Users> selectUsersByFenLiang(Users users);
	
	/**
	 * ͨ��idȥ�鿴����ѯʦ�Ƿ񱻿����Զ�����
	 * @param u_id
	 * @return
	 */
	Users selectUsersByKaiQi(Integer u_id);
	
	/**
	 * �鿴������ѯʦ�ķ������
	 * @return
	 */
	String selectUsersByflczAll(Users users);
	
	/**
	 * �޸��û�����Ϊ������ѯʦ���û���״̬��Ϊ�Ƿ��Զ�����
	 * @param u_state
	 * @return
	 */
	Integer updateUsersByu_state(Integer u_state);
	
	/**
	 * �Ա��Ա����Ӿ���Ľ�ɫ��ʱ�����жϾ����Ƿ�������
	 * @return
	 */
	String selectUsersJingLi();
	
}
