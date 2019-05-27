package com.spz.service;

import java.util.List;
import java.util.Map;

import com.spz.entity.Roles;
import com.spz.entity.Users;

public interface UsersService {
	/**
	 * 多条件分页查询
	 * @param users
	 * @return
	 */
	String selectUsersByUsers(Users users);
	
	/**
	 * 添加员工
	 * @param users
	 * @return
	 */
	Integer insertUsers(Users users);
	
	/**
	 * 修改员工
	 * @param users
	 * @return
	 */
	Integer updateUsers(Users users);	
	
	/**
	 * 删除员工
	 * @param u_id
	 * @return
	 */
	Integer deleteUsers(Integer u_id);
	
	/**
	 * 登陆时(注册时)使用查询员工
	 * @param users
	 * @return
	 */
	Users selectUserBylogin(Users users);
	
	/**
	 * 查询登录的用户的模块
	 * @param u_id
	 * @return
	 */
	List<Map<String, Object>> selectUserModuls(Integer u_id);
	
	/**
	 * 查询全部角色and用户现在具有的角色
	 * @return
	 */
	List<Roles> selectRolesAll();
	
	/**
	 * 查询用户现在具有的角色
	 * @return
	 */
	List<Roles> selectRolesAllbyU_id(Integer u_id);
	
	/**
	 *  查询已打卡咨询师成交的学生总个数，和已录入的未成交的个数，以及成功率,当天被分配的学生个数
	 * @return Users对象里面维护了count打卡咨询师的全部学生个数，counts打卡咨询师的还未成交的学生个数，counts/count=bfb 咨询师的成功率
	 */
	List<Users> selectUsersByFenLiang(Users users);
	
	/**
	 * 通过id去查看该咨询师是否被开启自动分配
	 * @param u_id
	 * @return
	 */
	Users selectUsersByKaiQi(Integer u_id);
	
	/**
	 * 查看网络咨询师的分量情况
	 * @return
	 */
	String selectUsersByflczAll(Users users);
	
	/**
	 * 修改用户表中为网络咨询师的用户的状态作为是否自动分量
	 * @param u_state
	 * @return
	 */
	Integer updateUsersByu_state(Integer u_state);
	
	/**
	 * 对别的员工添加经理的角色的时候做判断经理是否被人引用
	 * @return
	 */
	String selectUsersJingLi();
	
	/**
	 * 根据登录的咨询师名字去查有多少条未读数据
	 * @param u_name 登录的咨询师的名称
	 * @return
	 */
	Integer selectUserAndPushIsreaderCount(String u_name);
	
}
