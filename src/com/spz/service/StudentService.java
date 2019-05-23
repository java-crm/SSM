package com.spz.service;

import java.util.List;

import com.spz.entity.Netfollows;
import com.spz.entity.Student;
import com.spz.entity.Users;

public interface StudentService {
	/**
	 * 删除员工时查询该员工手下是否还有关联的学生是未缴费的，如果有则不能删除，如果没有则可以删除了
	 * @param u_id
	 * @return
	 */
	List<Student> selectStudentByU_id(Integer u_id);
	
	//岳治文
	/**
	 * 查询全部数据y
	 * @param student
	 * @return
	 */
	String selectAll(Student student);
	
	/**
	 * 录入学生y
	 * @param student 
	 * @param fenliang  前台传递是否开启分量标识 开启：1 or 未开启：0
	 * @return
	 */
	Integer insertStu(Student student,Integer fenliang);
	
	/**
	 * 通过当前登录的网络咨询师查询对应的咨询师，作为下拉框当搜索使用
	 * @param s_createUser
	 * @return
	 */
	List<Users> selectStudentUserName(Integer s_createUser);

	//周炎
	/**
	 * 多条件分页查询
	 * @param stu
	 * @return
	 */
	String selectStu(Student stu);
	/**
	 * 修改学生信息
	 * @param stu
	 * @return
	 */
	Integer updateStu(Student stu);
	
	/**
	 * 跟踪信息
	 * @param net
	 * @return
	 */
	Integer insertStugz(Netfollows net);

	
	//孙所蕾

	/**
	 * 咨询经理分页查询全部的学生
	 * @param student
	 * @return
	 */
	String selectStuAll(Student student);
	/**
	 * 根据客户id删除（修改状态未无效）
	 * @param s_id
	 * @return
	 */
	Integer deleteStu(Student student);
	
	/**
	 * 修改客户
	 * @param student
	 * @return
	 */
	Integer updateStus(Student student);
	
	/**
	 * 添加客户
	 * @param student
	 * @return
	 */
	Integer insertStus(Student student);
	
	/**
	 * 根据客户id查询
	 * @param s_id
	 * @return
	 */
	Student selectStuByid(Integer s_id);
	
	/**
	 * 从角色表查询咨询师id=10的所有员工 
	 * @return
	 */
	String selectUsersByZixunShi();
	
	
	/**
	 * 查询修改删除中下拉框的咨询师
	 * @return
	 */
	String selectUsersByZXS(Integer s_id);
}
