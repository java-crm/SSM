package com.spz.dao;

import java.util.List;

import com.spz.entity.Netfollows;
import com.spz.entity.Push;
import com.spz.entity.Student;
import com.spz.entity.Users;

public interface StudentMapper {
	
	/**
	 * 删除员工时查询该员工手下是否还有关联的学生是未缴费的，如果有则不能删除，如果没有则可以删除了
	 * @param u_id
	 * @return
	 */
	List<Student> selectStudentByU_id(Integer u_id);
	
	/**
	 * 查看回收站的学生
	 * @return
	 */
	List<Student> selectStudentIsdel(Student student);
	
	/**
	 * 清空回收站
	 * @return
	 */
	Integer deleteStudenthsz();
	
	/**
	 * 根据id去从回收站删除学生
	 * @param u_id
	 * @return
	 */
	Integer deleteByIdStuhsz(Integer s_id);

	/**
	 * 根据id去从回收站恢复学生
	 * @param u_id
	 * @return
	 */
	Integer updateStudenthsz(Integer s_id);
	
	/**
	 * 查看回收站的学生数量
	 * @return
	 */
	Integer selectStudentIsdelCount(Student student);
	//岳治文
	/**
	 * 多条件分页查询数据y
	 * @param student
	 * @return
	 */
	List<Student> selectStudent(Student student);
	
	/**
	 * 多条件分页查询数据条数y
	 * @param student
	 * @return
	 */
	Integer CountStudent(Student Student);
	
	/**
	 * 添加学生y
	 * @param Student
	 * @return
	 */
	Integer insertStudent(Student Student);

	/**
	 * 通过当前登录的网络咨询师查询对应的咨询师，作为下拉框当搜索使用
	 * @param s_createUser
	 * @return
	 */
	List<Users> selectStudentUserName(String s_createUser);
	
	/**
	   *   添加推送
	 * @param push
	 * @return
	 */
	Integer addPush(Push push);
	
	/**
	 * 修改为已读状态
	 * @param id
	 * @return
	 */
	Integer updatePushIsreader(Integer id);
	
	/**
	 * 查询刚刚天津的最新的推送消息id
	 * @return
	 */
	Integer selectMaxId();

	//周炎
	
	/**
	 * 查询咨询师各自学生信息
	 * @param stu
	 * @return
	 */
	List<Student> selectStu(Student stu);
	/**
	 * 查询总条数	
	 * @param stu
	 * @return
	 */
	Integer selectStucount(Student stu);
	/**
	 * 修改学生信息	
	 * @param stu
	 * @return
	 */
	Integer updateStu(Student stu);
	
	/**
	 * 跟踪学生信息	
	 * @param stu
	 * @return
	 */
	Integer insertStugz(Netfollows net );


	//孙所蕾
	
	/**
	 * 多条件分页查询所有
	 * @param student
	 * @return
	 */
	List<Student> selectStuAll(Student student);
	/**
	 * 查询总条数
	 * @param student
	 * @return
	 */
	Integer selectStuCount(Student student);
	/**
	 * 修改客户无效
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
	List<Users> selectUsersByZixunShi();
	
	/**
	 * 查询修改删除中下拉框的咨询师
	 * @return
	 */
	List<Users> selectUsersByZXS();
	
	/**
	 * 查看未分配的学生
	 * @return
	 */
	List<Student> selectStudentWeriFenliang(Student student);
	
	/**
	 * 查看未分配的学生数量
	 * @param student
	 * @return
	 */
	Integer selectStudentWeriFenliangCount(Student student);

	/**
	 * wflxs手动分配客户给咨询师
	 * @param student
	 * @return
	 */
	Integer shoudongFenLiang(Student student);
}
