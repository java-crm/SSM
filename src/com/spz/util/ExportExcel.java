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
	 * @param wb ����HSSFWorkbook����(excel���ĵ�����)
	 * @param res HttpServletResponse��Ӧ
	 * @param name ��Ҫ������ļ�����
	 * @throws IOException �쳣�׳�
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
			res.setHeader("Content-Disposition", "attachment; filename="+name);//Ҫ������ļ���
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
        //��stu����ȡֵ
        String[] arr=new String[split.length];
        for(int i=0;i<split.length-4;i++) {
        	 String methodName=split[i].substring(0,1).toUpperCase()+split[i].substring(1);
        	 //��ȡstu�൱ǰ���Ե�getXXX������ֻ�ܻ�ȡ���з�����
             Method getMethod=obj.getClass().getMethod("get"+methodName);
             Object result;
			try {
				result = getMethod.invoke(obj);// �õ�����get��ֵ
				arr[i] = result != null ? result.toString() : "null";
			} catch (Exception e) {
				System.out.println("�쳣");
			}
		}
        
        /*for(int i=0;i<num;i++){
            //��ȡ������
            String attributeName=f[i].getName();
            //��������������ĸ��Ϊ��д��Ϊִ��set/get������׼��
            String methodName=attributeName.substring(0,1).toUpperCase()+attributeName.substring(1);
            Object result;
            try{
                //��ȡstu�൱ǰ���Ե�setXXX������ֻ�ܻ�ȡ���з�����
                Method getMethod=obj.getClass().getMethod("get"+methodName);
                //ִ�и�get����
                result=getMethod.invoke(obj);//�õ�����get��ֵ
                //System.out.println(result.toString());
                arr[i]=result.toString()!=null ? result.toString() : "null";
            }catch(NoSuchMethodException e){
                result=f[i].get(obj);
            }
            //System.out.println("���ԣ�"+attributeName+"="+result);
        }*/
	return arr;
 }
}
