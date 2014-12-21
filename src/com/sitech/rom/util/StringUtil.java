package com.sitech.rom.util;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class StringUtil {
	private StringUtil() {
	}
	
	public static String encodeUrI(String str){
    	try {
    		str = java.net.URLEncoder.encode(str,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return str;
    }
	
	public static String decodeUrI(String str){
    	try {
    		str = java.net.URLDecoder.decode(str,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return str;
    }
	
	public static boolean isNull(Object obj) {
		if (obj == null) {
			return true;
		}
		return "".equals(obj.toString().trim());
	}

	public static boolean notNull(String str) {
		return str != null && !"".equals(str.trim());
	}

	public static Object safeValue(Object obj) {
		if (obj == null)
			return "";
		return obj; // text中双引号的输出转换
	}
	
	public static String safeValue(String str) {
		if (str == null)
			return "";
		return str.replaceAll("\"", "&#34;"); // text中双引号的输出转换
	}

	public static String safeValueArea(String str) {
		if (str == null)
			return "";
		return str.replaceAll("\"", "\\\\\""); // TextArea中双引号的输出转换
	}

	public static Object safeValueObj(Object obj) {
		if (obj == null)
			return "";
		return obj;
	}

	public static Long toLong(String value) {

		if (isNull(value)) {
			return null;
		} else {

			try {
				return new Long(Long.parseLong(value));
			} catch (Exception e) {
				return null;
			}
		}
	}

	public static Integer toInteger(String value) {

		if (isNull(value)) {
			return null;
		} else {
			try {
				return new Integer(Integer.parseInt(value));
			} catch (Exception e) {
				return null;
			}
		}
	}

	public static String printLong(Long value) {

		if (isNull(value)) {
			return "";
		} else {
			try {
				return value.longValue() + "";
			} catch (Exception e) {
				return "";
			}
		}
	}
	
	public static String[] delimitedListToStringArray(String str, String delimiter) {
		if (str == null) {
			return new String[0];
		}
		if (delimiter == null) {
			return new String[] {str};
		}

		List result = new ArrayList();
		if ("".equals(delimiter)) {
			for (int i = 0; i < str.length(); i++) {
				result.add(str.substring(i, i + 1));
			}
		}
		else {
			int pos = 0;
			int delPos = 0;
			while ((delPos = str.indexOf(delimiter, pos)) != -1) {
				result.add(str.substring(pos, delPos));
				pos = delPos + delimiter.length();
			}
			if (str.length() > 0 && pos <= str.length()) {				
				result.add(str.substring(pos));
			}
		}
		return toStringArray(result);
	}
	
	public static String[] toStringArray(Collection collection) {
		if (collection == null) {
			return null;
		}
		return (String[]) collection.toArray(new String[collection.size()]);
	}

	/**
	 * add by yl.
	 * 由于调用shell脚本后，使用以下方法都不行，才编写此方法进行空格字符转html空格字符的处理方法.
	 * result.replace(" ", "&nbsp;");
	 * result.replaceAll("\\s*", "&nbsp;");//\s 可以匹配空格、制表符、换页符等空白字符的其中任意一个
	 * @param src
	 * @return
	 */
	public static String spaceToHtmlSpace(String srcStr){
		String desStr="";
		for (int i = 0; i < srcStr.length(); i++) {
		  if ((int) srcStr.charAt(i) == 32){
			  desStr=desStr+"&nbsp;";
		  }else{
			  desStr=desStr+srcStr.charAt(i);
		  }
		}
		return desStr;		
	}
	
	public static String convertSafeValue(String str) {
		if (str == null)
			return "";
		return str.replaceAll("\"", "\\\\\"").replaceAll("'", "\\\\\'"); // 单引号双引号
	}
}
