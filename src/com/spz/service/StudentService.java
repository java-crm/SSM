package com.spz.service;

import java.util.List;

import com.spz.entity.Netfollows;
import com.spz.entity.Student;
import com.spz.entity.Users;

public interface StudentService {
	/**
	 * ɾ��Ա��ʱ��ѯ��Ա�������Ƿ��й�����ѧ����δ�ɷѵģ����������ɾ�������û�������ɾ����
	 * @param u_id
	 * @return
	 */
	List<Student> selectStudentByU_id(Integer u_id);
	
	//������
	/**
	 * ��ѯȫ������y
	 * @param student
	 * @return
	 */
	String selectAll(Student student);
	
	/**
	 * ¼��ѧ��y
	 * @param student 
	 * @param fenliang  ǰ̨�����Ƿ���������ʶ ������1 or δ������0
	 * @return
	 */
	Integer insertStu(Student student,Integer fenliang);
	
	/**
	 * ͨ����ǰ��¼��������ѯʦ��ѯ��Ӧ����ѯʦ����Ϊ����������ʹ��
	 * @param s_createUser
	 * @return
	 */
	List<Users> selectStudentUserName(Integer s_createUser);

	//����
	/**
	 * ��������ҳ��ѯ
	 * @param stu
	 * @return
	 */
	String selectStu(Student stu);
	/**
	 * �޸�ѧ����Ϣ
	 * @param stu
	 * @return
	 */
	Integer updateStu(Student stu);
	
	/**
	 * ������Ϣ
	 * @param net
	 * @return
	 */
	Integer insertStugz(Netfollows net);

	
	//������

	/**
	 * ��ѯ�����ҳ��ѯȫ����ѧ��
	 * @param student
	 * @return
	 */
	String selectStuAll(Student student);
	/**
	 * ���ݿͻ�idɾ�����޸�״̬δ��Ч��
	 * @param s_id
	 * @return
	 */
	Integer deleteStu(Student student);
	
	/**
	 * �޸Ŀͻ�
	 * @param student
	 * @return
	 */
	Integer updateStus(Student student);
	
	/**
	 * ��ӿͻ�
	 * @param student
	 * @return
	 */
	Integer insertStus(Student student);
	
	/**
	 * ���ݿͻ�id��ѯ
	 * @param s_id
	 * @return
	 */
	Student selectStuByid(Integer s_id);
	
	/**
	 * �ӽ�ɫ���ѯ��ѯʦid=10������Ա�� 
	 * @return
	 */
	String selectUsersByZixunShi();
	
	
	/**
	 * ��ѯ�޸�ɾ�������������ѯʦ
	 * @return
	 */
	String selectUsersByZXS(Integer s_id);
}
