package com.spz.controller;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.spz.entity.Netfollows;
import com.spz.entity.Push;
import com.spz.entity.Student;
import com.spz.entity.Users;
import com.spz.service.StudentService;
import com.spz.util.ExportExcel;
import com.spz.util.InitDateTime;
import com.spz.util.Result;
@Controller
public class StudentController {
	//岳治文
	@Resource
	private StudentService studentService;
	

	@RequestMapping(value="/selectAll")
	@ResponseBody
	public String selectAll(Student student) {
		return studentService.selectAll(student);
		
	}
	@RequestMapping(value="/insertStu",method=RequestMethod.POST)
	@ResponseBody
	public Integer insertStu(Student student,Integer fenliang) {
		System.out.println("111111111111111111111111111111111111");
		System.out.println("11111111111111111"+student.toString());
		return studentService.insertStu(student,fenliang);
		
	}
	@RequestMapping(value="/selectUserName",method=RequestMethod.POST)
	@ResponseBody
	public List<Users> selectUserName(Integer s_createUser) {
		return studentService.selectStudentUserName(s_createUser);
		
	}
	@RequestMapping(value="/addPush",method=RequestMethod.POST)
	@ResponseBody
	public Integer addPush(Push Push) {
		Integer addPush = studentService.addPush(Push);
		return addPush;
	}
	
	//周炎
	
	
	@RequestMapping (value="selectStu",method=RequestMethod.POST)
	@ResponseBody
	public String selectStu(Student stu) {
		String selectStu = studentService.selectStu(stu);
		System.out.println(selectStu);
		return selectStu;
	}
	
	@RequestMapping (value="/updateStu",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateStu(Student stu) {
		
		return studentService.updateStu(stu);
		
		
	}
	
	@RequestMapping (value="/insertStugz",method=RequestMethod.POST)
	@ResponseBody
	public Integer insertStugz(Netfollows net) {
		return studentService.insertStugz(net);
	}


	//孙所蕾
	
	@RequestMapping(value="/selectStuAll")
	@ResponseBody
	public String selectStuAll(Student student) {
		return studentService.selectStuAll(student);
	}
	
	@RequestMapping(value="/deleteStu")
	@ResponseBody
	public String deleteStu(Student student) {
		
		/*return studentService.deleteStu(student);*/
		Student stuByid = studentService.selectStuByid(student.getS_id());
		if("否".equals(stuByid.getS_isValid())) {
			 Integer updateStus = studentService.deleteStu(student);
			 return Result.toClient(true,updateStus>0 ? "删除成功" : "删除失败","0");
		}else {
			 return Result.toClient(true,"该学生咨询师未放弃您不能删除！","1");
		}
	}
	
	
	@RequestMapping(value="/updateStus")
	@ResponseBody
	public Integer updateStus(Student student) {
		return studentService.updateStus(student);
	}
	
	
	@RequestMapping(value="/insertStus")
	@ResponseBody
	public Integer insertStus(Student student) {
		/*if(zdfl!=null && "on".equals(zdfl)) {
			studentService.insertStu(student, zdfl);
		}*/
		return studentService.insertStus(student);
	}
	
	
	@RequestMapping(value="/selectStuByid")
	@ResponseBody
	public Student selectStuByid(Integer s_id) {
		return studentService.selectStuByid(s_id);
	}
	
	@RequestMapping(value="/selectUsersZiXunShi")
	@ResponseBody
	public String selectUsersZiXunShi() {
		return studentService.selectUsersByZixunShi();
	}
	
	
	@RequestMapping(value="/selectUsersByZXS")
	@ResponseBody
	public String selectUsersByZXS() {
		return studentService.selectUsersByZXS();
	}
	
	@RequestMapping(value="/selectweifnInfo")
	@ResponseBody
	public String selectweifnInfo(Student student) {
		return studentService.selectStudentWeriFenliang(student);
	}
	
	@RequestMapping(value="/insertjingliFenPei")
	@ResponseBody
	public Integer insertjingliFenPei(String s_id) {
		return studentService.insertjingliFenPei(s_id);
	}
	

	@RequestMapping(value="/shoudongFenLiang")
	@ResponseBody
	public Integer shoudongFenLiang(Student student,String u_ids) {
		String[] ssid=u_ids.split(",");
		Integer ii =0;
		for (int i = 0; i < ssid.length; i++) {
			Integer sid = Integer.parseInt(ssid[i]);
			student.setS_id(sid);
			ii=studentService.shoudongFenLiang(student);
		}
		return ii;

	@RequestMapping(value="/selectStudentIsdelAll",method=RequestMethod.POST)
	@ResponseBody
	public String selectStudentIsdelAll(Student student) {
		return studentService.selectStudentIsdelAll(student);
	}
	@RequestMapping(value="/deleteStudenthsz",method=RequestMethod.POST)
	@ResponseBody
	public Integer deleteStudenthsz() {
		return studentService.deleteStudenthsz();
	}
	@RequestMapping(value="/deleteByIdStuhsz",method=RequestMethod.POST)
	@ResponseBody
	public Integer deleteByIdStuhsz(Integer s_id) {
		return studentService.deleteByIdStuhsz(s_id);
	}
	@RequestMapping(value="/updateStudenthsz",method=RequestMethod.POST)
	@ResponseBody
	public Integer updateStudenthsz(Integer s_id) {
		return studentService.updateStudenthsz(s_id);
	}
	@RequestMapping(value="/plczhsz",method=RequestMethod.POST)
	@ResponseBody
	public Integer plczhsz(String s_id,Integer a) {
		String[] split = s_id.split(",");
		Integer num=null;
		for(int i=0;i<split.length;i++) {
			if(a==1) {//全部清除
				num=studentService.deleteByIdStuhsz(Integer.parseInt(split[i]));
			}else {//全部恢复
				num=studentService.updateStudenthsz(Integer.parseInt(split[i]));
			}
		}
		return num;

	}
}
