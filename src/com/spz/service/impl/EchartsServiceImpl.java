package com.spz.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spz.dao.EchartsMapper;
import com.spz.entity.Echarts;
import com.spz.entity.Student;
import com.spz.service.EchartsService;
@Service
public class EchartsServiceImpl implements EchartsService {
	
	@Autowired EchartsMapper echartsMapper;
	
	@Override
	public List<Echarts> selectEcharts(Student student) {
		List<Echarts> echarts = echartsMapper.selectEcharts(student);
		return echarts;
	}

	@Override
	public Integer selectRolesEcharts(Integer u_id) {
		return echartsMapper.selectRolesEcharts(u_id);
	}

}
