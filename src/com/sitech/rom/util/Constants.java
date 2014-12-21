
package com.sitech.rom.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.sitech.crmpd.core.config.Configuration;

public class Constants {
	
	public final static String SEQ_COMMON="seq_common";
	public final static String SEQ_HOSTCHECK="SEQ_HOSTCHECK";
	public final static String SEQ_EXPAND = "SEQ_EXPAND";
	
	public final static String ROM_SALT="romSalt";//安全加密的盐
	public final static String VALID="0";//有效
	public final static String INVALID="1";//无效
	public final static String FUNC_SHOW="0";//可见功能
	public final static String OPER_NULL="NULL"; //角色功能关系表操作项空标识
	public final static String TREE_PARENT="0"; //功能树顶级父节点
	public final static String TREE_PARENT_NAME="根节点"; //功能树顶级父节点
	public final static String INIT_PWD="000000"; //初始密码
	public final static String OPER_NULL_NAME="查询"; //权限注册表操作项空标识名称
	
	public final static String PROD_SYSTEM=Configuration.getValue("PROD_SYSTEM");; //产品表中后台管理功能编码
	public final static String PROD_HOSTCHECK=Configuration.getValue("PROD_HOSTCHECK"); //产品表中后台管理功能编码
	public final static String BUSI_FUNCCODE=Configuration.getValue("BUSI_FUNCCODE"); //业务监控对应的funcCode
	public final static String HOSTCHECK_FUNCCODE=Configuration.getValue("HOSTCHECK_FUNCCODE"); //主机巡检对应的funcCode
	public final static String ORDER_FUNCCODE=Configuration.getValue("ORDER_FUNCCODE"); //工单监控对应的funcCode
	public final static String MS_CFG=Configuration.getValue("MS_CFG"); //日检消息通知配置文件文件名
	
	public final static String TASK_STATE0="0";//任务执行状态
	

	
	public static final String DATE_MODEL_1 = "yyyy-MM-dd HH:mm:ss.SSS";
	public static final String DATE_MODEL_2 = "yyyy-MM-dd HH:mm:ss";
	public static final String DATE_MODEL_3 = "yyyy-MM-dd HH:mm";
	public static final String DATE_MODEL_4 = "yyyy-MM-dd HH";
	public static final String DATE_MODEL_5 = "yyyy-MM-dd";
	public static final String DATE_MODEL_6 = "yyyy-MM";
	
	public static final String DATE_MODEL_7 = "yyyyMMddHHmmss.SSS";
	public static final String DATE_MODEL_8 = "yyyyMMddHHmmss";
	public static final String DATE_MODEL_9 = "yyyyMMddHHmm";
	public static final String DATE_MODEL_10 = "yyyyMMddHH";
	public static final String DATE_MODEL_11 = "yyyyMMdd";
	public static final String DATE_MODEL_12 = "yyyyMM";
	
	public static final String DATE_MODEL_13 = "yyyy/MM/dd HH:mm:ss.SSS";
	public static final String DATE_MODEL_14 = "yyyy/MM/dd HH:mm:ss";
	public static final String DATE_MODEL_15 = "yyyy/MM/dd HH:mm";
	public static final String DATE_MODEL_16 = "yyyy/MM/dd HH";
	public static final String DATE_MODEL_17 = "yyyy/MM/dd";
	public static final String DATE_MODEL_18 = "yyyy/MM";
	
	public static final String DATE_MODEL_99 = "yyyy";
	
	public static String getType(String date){
		String result=null;
		if(date.matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}.\\d+")){
			result=Constants.DATE_MODEL_1;
		}else if(date.matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}")){
			result=Constants.DATE_MODEL_2;
		}else if(date.matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}")){
			result=Constants.DATE_MODEL_3;
		}else if(date.matches("\\d{4}-\\d{2}-\\d{2} \\d{2}")){
			result=Constants.DATE_MODEL_4;
		}else if(date.matches("\\d{4}-\\d{2}-\\d{2}")){
			result=Constants.DATE_MODEL_5;
		}else if(date.matches("\\d{4}-\\d{2}")){
			result=Constants.DATE_MODEL_6;
		}else if(date.matches("\\d{14}.\\d+")){
			result=Constants.DATE_MODEL_7;
		}else if(date.matches("\\d{14}")){
			result=Constants.DATE_MODEL_8;
		}else if(date.matches("\\d{12}")){
			result=Constants.DATE_MODEL_9;
		}else if(date.matches("\\d{10}")){
			result=Constants.DATE_MODEL_10;
		}else if(date.matches("\\d{8}")){
			result=Constants.DATE_MODEL_11;
		}else if(date.matches("\\d{6}")){
			result=Constants.DATE_MODEL_12;
		}else if(date.matches("\\d{4}/\\d{2}/\\d{2} \\d{2}:\\d{2}:\\d{2}.\\d+")){
			result=Constants.DATE_MODEL_13;
		}else if(date.matches("\\d{4}/\\d{2}/\\d{2} \\d{2}:\\d{2}:\\d{2}")){
			result=Constants.DATE_MODEL_14;
		}else if(date.matches("\\d{4}/\\d{2}/\\d{2} \\d{2}:\\d{2}")){
			result=Constants.DATE_MODEL_15;
		}else if(date.matches("\\d{4}/\\d{2}/\\d{2} \\d{2}")){
			result=Constants.DATE_MODEL_16;
		}else if(date.matches("\\d{4}/\\d{2}/\\d{2}")){
			result=Constants.DATE_MODEL_17;
		}else if(date.matches("\\d{4}/\\d{2}")){
			result=Constants.DATE_MODEL_18;
		}
		return result;
	}
	
	public  static  void  main(String[] args) throws ParseException{
		String d = "2011-09-09 12:10:10.12910";
		String t = getType(d);
		Date dd = new SimpleDateFormat(t).parse(d);
		System.out.print(dd);
	}
	
	

}
