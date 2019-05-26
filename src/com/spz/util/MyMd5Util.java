package com.spz.util;

import java.security.MessageDigest;

public class MyMd5Util {
	public static void main(String[] args) {
		String s = new String("song");
        System.out.println("原始：" + s);
        System.out.println("加密的：" + strMd5(s));
	}
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
			/*java.lang.Integer.toHexString() 方法的参数是int(32位)类型，如果输入一个byte(8位)类型的数字，这个
			方法会把这个数字的高24为也看作有效位，这就必然导致错误，使用& 0XFF操作，可以把高24位置0以避免这样错误
			的发生。*/
			int val=((int)md5Bytes[i]) & 0xff;
			if(val<16) {
				buffer.append("0");
			}
			/*这里面再调用了加密算法完成之后，会返回byte数组，大小为16，最终生成的是32位的加密数据。
			 * 总体的思路是把每一个byte替换为16进制的两个位的数据，至于为什么两位，是因为每个byte是8位
			 * 的数据最大不会超过两位的十六进制的数据去。*/
			buffer.append(Integer.toHexString(val));
		}
		/*那么这里之所以转为整形无非是整形的包装类中有Integer.toHexString()这个将其转为16进制的方法，
		 * 如果Byte中有的话，估计这里是不会转为整形的。如果结果小于十六的时候，要再前面加上一个0填满两位的十六进制*/
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
	 // 加密后解密   
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
			//a[i]^'t'是一个数，（char）就是将前面的数强制转化为字符型。
			a[i]=(char)(a[i] ^ 't');
			
			/* String s="中国人民很行";
				char a[]=s.toCharArray();
				for(int i=0;i<a.length;i++) 
				{ a[i]=(char)(a[i]^'t');
				}
			字符串转换成字符数组后，每个字符的ASC码与字符t的ASC码进行二进制异或运算，然后把结果转换回字符*/
		}
		String s=new String(a);
		return s;
	}
}
