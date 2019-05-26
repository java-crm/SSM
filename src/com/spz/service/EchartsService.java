package com.spz.service;

import java.util.List;

import com.spz.entity.Echarts;
import com.spz.entity.Student;

public interface EchartsService {
	/**
	 * 查询登录者今天往前数过去七天用户的分配学生数量
	 * @param student （当做条件，有网络咨询师录入的学生，咨询师已缴费分配的学生，或者咨询师分配的学生未成功的学生，）
	 * @return
	 */
	List<Echarts> selectEcharts(Student student);
	
	/**
	 * 通过u_id去得到登录者是咨询师还是网络咨询师
	 * @param u_id
	 * @return
	 */
	Integer selectRolesEcharts(Integer u_id);
}
