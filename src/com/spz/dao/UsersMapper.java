package com.spz.dao;

import java.util.List;

import com.spz.entity.Modules;
import com.spz.entity.Users;

public interface UsersMapper {
	
	/**
	 * ��������ҳ��ѯ
	 * @param users
	 * @return
	 */
	List<Users> selectUsersByUsers(Users users);
	
	/**
	 *  ��������ҳ��ѯ������
	 * @param users
	 * @return
	 */
	Integer selectUsersByUsersCount(Users users);
	
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
	 * ��½ʱ��ѯʹ��
	 * @param users
	 * @return
	 */
	Users selectUserBylogin(Users users);
	
	
	/**
	 * ��ѯ��¼�û���ģ�� 
	 * @param u_id
	 * @return
	 */
	List<Modules> selectUserModuls(Integer u_id);
	
	/**
	 * ��id�����е���ģ��
	 * @return
	 */
	List<Modules> selectModulsByid(Integer m_id,Integer u_id);
	
	/**
	 *  ��ѯ�Ѵ���ѯʦ�ɽ���ѧ���ܸ���������¼���δ�ɽ��ĸ������Լ��ɹ���
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
	List<Users> selectUsersByflcz(Users users);
	
	/**
	 * �鿴������ѯʦ�ķ����������
	 * @return
	 */
	Integer selectUsersByflczCount(Users users);
	
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
	Users selectUsersJingLi();
	
	/**
	 * ��ѯ������ӵ�Ա��
	 * @return
	 */
	Users selecuMaxUserId();
	
	//������
	/**
	 * ��ѯ����Ա��
	 * @return
	 */
	List<Users> selectUsers();
}
