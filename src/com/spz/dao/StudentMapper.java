package com.spz.dao;

import java.util.List;

import com.spz.entity.Netfollows;
import com.spz.entity.Student;
import com.spz.entity.Users;

public interface StudentMapper {
	
	/**
	 * ɾ��Ա��ʱ��ѯ��Ա�������Ƿ��й�����ѧ����δ�ɷѵģ����������ɾ�������û�������ɾ����
	 * @param u_id
	 * @return
	 */
	List<Student> selectStudentByU_id(Integer u_id);
	
	//������
	/**
	 * ��������ҳ��ѯ����y
	 * @param student
	 * @return
	 */
	List<Student> selectStudent(Student student);
	
	/**
	 * ��������ҳ��ѯ��������y
	 * @param student
	 * @return
	 */
	Integer CountStudent(Student Student);
	
	/**
	 * ���ѧ��y
	 * @param Student
	 * @return
	 */
	Integer insertStudent(Student Student);

	/**
	 * ͨ����ǰ��¼��������ѯʦ��ѯ��Ӧ����ѯʦ����Ϊ����������ʹ��
	 * @param s_createUser
	 * @return
	 */
	List<Users> selectStudentUserName(Integer s_createUser);
	//����
	
	/**
	 * ��ѯ��ѯʦ����ѧ����Ϣ
	 * @param stu
	 * @return
	 */
	List<Student> selectStu(Student stu);
	/**
	 * ��ѯ������	
	 * @param stu
	 * @return
	 */
	Integer selectStucount(Student stu);
	/**
	 * �޸�ѧ����Ϣ	
	 * @param stu
	 * @return
	 */
	Integer updateStu(Student stu);
	
	/**
	 * ����ѧ����Ϣ	
	 * @param stu
	 * @return
	 */
		Integer insertStugz(Netfollows net );


	//������
	
	/**
	 * ��������ҳ��ѯ����
	 * @param student
	 * @return
	 */
	List<Student> selectStuAll(Student student);
	/**
	 * ��ѯ������
	 * @param student
	 * @return
	 */
	Integer selectStuCount(Student student);
	/**
	 * �޸Ŀͻ���Ч
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
	List<Users> selectUsersByZixunShi();
	
	/**
	 * ��ѯ�޸�ɾ�������������ѯʦ
	 * @return
	 */
	List<Student> selectUsersByZXS(Integer s_id);
}
