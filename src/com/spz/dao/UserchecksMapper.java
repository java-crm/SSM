package com.spz.dao;

import java.util.List;

import com.spz.entity.Userchecks;
import com.spz.entity.Users;

public interface UserchecksMapper {
	
	/**
	 * 查询用户是否已打卡
	 * @param u_id
	 * @return
	 */
	Userchecks selectUserchecks(Integer u_id);
	
	/**
	 * 修改用户打打卡状态（否：下班不会自动执行打卡操作，是：到下班时间修改状态为否和下班时间）
	 * us_isCancel修改为否之后 则不能统一的到下班时间一起打卡，需要员工手动打卡，（推出登录时判断用户是否签退）
	 * @param userchecks
	 * @return
	 */
	Integer updateUserchecks(Userchecks userchecks);
	
	/**
	 * 每次添加一个员工同时在签到表添加一条该员工的签到数据
	 * @param userchecks
	 * @return
	 */
	Integer insertUserchecks(Userchecks userchecks);
	
	/**
	 * 删除用户的时候签到表同时删除
	 * @param u_id
	 * @return
	 */
	Integer deleteUsersByUserId(Integer u_id);
	

	//孙所蕾
	/**
	 * 根据角色查询全部咨询师与网络咨询师（员工签到）
	 * @return
	 */
	List<Userchecks> selectUserCheckAll(Userchecks userchecks);
	/**
	 * 根据角色查询全部咨询师与网络咨询师（员工签到）总条数
	 * @param users
	 * @return
	 */
	Integer selectUserCheckCount(Userchecks userchecks);
	/**
	 * 批量签到or批量签退
	 * @param userchecks
	 * @return
	 */
	Integer updateUserchecksPL(Userchecks userchecks);
	
	/**
	 * 从角色表查询员工id=10 or id=9的所有咨询师，网络咨询师 
	 * @return
	 */
	List<Users> selectUsersByYuanGong();
}
