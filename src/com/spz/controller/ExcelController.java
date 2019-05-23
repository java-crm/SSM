package com.spz.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.spz.entity.Student;
import com.spz.entity.Users;
import com.spz.util.ExportExcel;
import com.spz.util.InitDateTime;
import com.spz.util.Result;

@Controller
public class ExcelController {
	
	@RequestMapping(value="/dochu",method=RequestMethod.GET)
	@ResponseBody
	public void daochu(HttpServletResponse res,@RequestParam("stulist") String stulist,@RequestParam("title") String title) throws Exception{
		System.out.println("123");
		String name=InitDateTime.initTimes()+".xls";
		String[] split = title.split(",");
		Gson gson=new Gson();
		List<Users> stu=gson.fromJson(stulist, new TypeToken<List<Users>>() {}.getType());
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("title");
		HSSFRow row1 = sheet.createRow(0);
		HSSFCell cell = row1.createCell(0);
		
		for(int i=0;i<split.length-3;i++) {
			 cell=row1.createCell(i);
			 cell.setCellValue(split[i]);
		}
		//向表格写入内容 	调title的数组个数做循环条件
		
		for(int i=0;i<stu.size();i++) {
			 HSSFRow row = sheet.createRow(i+1);//创建行,从0开始
				String[] result = ExportExcel.getResult(stu.get(i),split.length-4,split);
				for(int j=0;j<result.length;j++) {
					row.createCell(j).setCellValue(result[j]);
				}
		}
		//将excel的数据写入所选的位置
		ExportExcel.myExcel(wb, res, name);
	}
}
