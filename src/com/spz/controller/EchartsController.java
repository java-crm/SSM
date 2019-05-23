package com.spz.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spz.entity.Echarts;
import com.spz.entity.Student;
import com.spz.service.EchartsService;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;

@Controller
public class EchartsController {
	@Autowired EchartsService echartsService;
	
	@RequestMapping(value="/EchartsServlet")
	@ResponseBody
	public String EchartsServlet(Student student,HttpServletResponse response,HttpServletRequest request) {
		Integer id= (Integer)request.getSession().getAttribute("u_id");
		Integer echarts2 = echartsService.selectRolesEcharts(id);
		if(echarts2==9) {
			student.setS_createUser(id+"");
		}
		if(echarts2==10) {
			student.setU_id(id);
		}
		List<Echarts> echarts = echartsService.selectEcharts(student);
		
		String [] categories2 =new String[echarts.size()];
		for(int i=0;i<echarts.size();i++) {
			categories2[i]=echarts.get(i).getClick_date();
		}
		
		Integer[] values2 = new Integer[echarts.size()];
		for(int i=0;i<echarts.size();i++) {
			values2[i]=echarts.get(i).getCount();
		}
		
		JSONObject json = new JSONObject();
		 try {
			 json.put("categories2", categories2);
			 json.put("values2", values2);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		 return json!=null ? json.toString() : null;
	}
}
