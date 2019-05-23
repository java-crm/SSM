package com.spz.util;

import java.security.MessageDigest;

public class MyMd5Util {
	public static String strMd5(String str) {
		MessageDigest md5;
		try {
			md5=MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			return "";
		}
		char[] charArray = str.toCharArray();
		byte[] byteArray= new byte[charArray.length];
		for(int i=0;i<charArray.length;i++) {
			byteArray[i]=(byte)charArray[i];
		}
		byte[] md5Bytes = md5.digest(byteArray);
		StringBuffer buffer=new StringBuffer();
		for(int i=0;i<md5Bytes.length;i++) {
			/*java.lang.Integer.toHexString() �����Ĳ�����int(32λ)���ͣ��������һ��byte(8λ)���͵����֣����
			�������������ֵĸ�24ΪҲ������Чλ����ͱ�Ȼ���´���ʹ��& 0XFF���������԰Ѹ�24λ��0�Ա�����������
			�ķ�����*/
			int val=((int)md5Bytes[i]) & 0xff;
			if(val<16) {
				buffer.append("0");
			}
			/*�������ٵ����˼����㷨���֮�󣬻᷵��byte���飬��СΪ16���������ɵ���32λ�ļ������ݡ�
			 * �����˼·�ǰ�ÿһ��byte�滻Ϊ16���Ƶ�����λ�����ݣ�����Ϊʲô��λ������Ϊÿ��byte��8λ
			 * ��������󲻻ᳬ����λ��ʮ�����Ƶ�����ȥ��*/
			buffer.append(Integer.toHexString(val));
		}
		/*��ô����֮����תΪ�����޷������εİ�װ������Integer.toHexString()�������תΪ16���Ƶķ�����
		 * ���Byte���еĻ������������ǲ���תΪ���εġ�������С��ʮ����ʱ��Ҫ��ǰ�����һ��0������λ��ʮ������*/
		return buffer.toString();
	}
	
	/*public static String KL(String inStr) {   
		  // String s = new String(inStr);   
		  char[] a = inStr.toCharArray();   
		  for (int i = 0; i < a.length; i++) {   
		   a[i] = (char) (a[i] ^ 't');   
		  }   
		  String s = new String(a);   
		  return s;   
	}
	
	 * 
	 // ���ܺ����   
	 public static String JM(String inStr) {   
	  char[] a = inStr.toCharArray();   
	  for (int i = 0; i < a.length; i++) {   
	   a[i] = (char) (a[i] ^ 't');   
	  }   
	  String k = new String(a);   
	  return k;   
	 }
	 *
	 */ 
	public static String converMd5(String instr) {
		
		char[] a = instr.toCharArray();
		for(int i=0;i<a.length;i++) {
			//a[i]^'t'��һ��������char�����ǽ�ǰ�����ǿ��ת��Ϊ�ַ��͡�
			a[i]=(char)(a[i] ^ 't');
			
			/* String s="�й��������";
				char a[]=s.toCharArray();
				for(int i=0;i<a.length;i++) 
				{ a[i]=(char)(a[i]^'t');
				}
			�ַ���ת�����ַ������ÿ���ַ���ASC�����ַ�t��ASC����ж�����������㣬Ȼ��ѽ��ת�����ַ�*/
		}
		String s=new String(a);
		return s;
	}
}
