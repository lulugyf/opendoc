package com.sitech.rom.util;

import java.security.MessageDigest;

import org.apache.commons.codec.digest.DigestUtils;
 
/**
 * ��ϢժҪ�Ĺ�����
 * @author IBM
 *
 */
public class Digests {

	/**
	 * 目前使用在工号密码加密上
	 * @param s
	 * @return
	 */
	public static String md5Hex(String s) {
		return DigestUtils.md5Hex(s);
	}
	
	
	/**
	 * 与受控端交互上的加密使用，此方法是zhanghr提供。
	 * @param s
	 * @return
	 */
	public final static String MD5(String s) {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'A', 'B', 'C', 'D', 'E', 'F' };
		try {
			byte[] btInput = s.getBytes();
			// 获得MD5摘要算法的 MessageDigest 对象
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			// 使用指定的字节更新摘要
			mdInst.update(btInput);
			// 获得密文
			byte[] md = mdInst.digest();
			// 把密文转换成十六进制的字符串形式
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static void main(String[] args) {
		String s="test";
		String hashstr= Digests.md5Hex(s);
		System.out.println("-----hashstr="+hashstr);	
	}
	
	
}
