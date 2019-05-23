package com.spz.util;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class ExportExcel {
	/**
	 * 
	 * @param wb 创建HSSFWorkbook对象(excel的文档对象)
	 * @param res HttpServletResponse相应
	 * @param name 需要保存的文件名称
	 * @throws IOException 异常抛出
	 */
	public static void myExcel(HSSFWorkbook wb,HttpServletResponse res,String name) throws IOException {
		ByteArrayOutputStream fos = null;
		byte[] retArr = null;
		try {
			fos = new ByteArrayOutputStream();
			wb.write(fos);
			retArr = fos.toByteArray();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				fos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		OutputStream os = res.getOutputStream();
		try {
			res.reset();
			res.setHeader("Content-Disposition", "attachment; filename="+name);//要保存的文件名
			res.setContentType("application/octet-stream;charset=ISO-8859-1");
			os.write(retArr);
			os.flush();
		} finally {
			if (os != null) {
				os.close();
			}
		}
	}
	
	public static String[] getResult(Object obj,int num, String[] split) throws Exception{
        //从stu对象取值
        String[] arr=new String[split.length];
        for(int i=0;i<split.length-4;i++) {
        	 String methodName=split[i].substring(0,1).toUpperCase()+split[i].substring(1);
        	 //获取stu类当前属性的getXXX方法（只能获取公有方法）
             Method getMethod=obj.getClass().getMethod("get"+methodName);
             Object result;
			try {
				result = getMethod.invoke(obj);// 得到所有get的值
				arr[i] = result != null ? result.toString() : "null";
			} catch (Exception e) {
				System.out.println("异常");
			}
		}
        
        /*for(int i=0;i<num;i++){
            //获取属相名
            String attributeName=f[i].getName();
            //将属性名的首字母变为大写，为执行set/get方法做准备
            String methodName=attributeName.substring(0,1).toUpperCase()+attributeName.substring(1);
            Object result;
            try{
                //获取stu类当前属性的setXXX方法（只能获取公有方法）
                Method getMethod=obj.getClass().getMethod("get"+methodName);
                //执行该get方法
                result=getMethod.invoke(obj);//得到所有get的值
                //System.out.println(result.toString());
                arr[i]=result.toString()!=null ? result.toString() : "null";
            }catch(NoSuchMethodException e){
                result=f[i].get(obj);
            }
            //System.out.println("属性："+attributeName+"="+result);
        }*/
	return arr;
 }
}
