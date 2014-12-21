package com.sitech.rom.util;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateFormat {
	 public static String shortDate(Date str){
		 SimpleDateFormat shortDate= new SimpleDateFormat("yyyy-MM-dd");
		 String str1=shortDate.format(str);
		 return str1; 
	 } 
	 public static String longDate(Date str){
		 if(str==null) return "";
		 SimpleDateFormat longDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 String str1=longDate.format(str);
		 return str1; 
	 }
	 public static String ymDate(Date str){
		 SimpleDateFormat ymDate= new SimpleDateFormat("yyyy-MM");
		 String str1=ymDate.format(str);
		 return str1; 
	 }
	 public static String yyDate(Date str){
		 SimpleDateFormat yyDate= new SimpleDateFormat("yyyy");
		 String str1=yyDate.format(str);
		 return str1; 
	 }
	 public static String mmDate(Date str){
		 SimpleDateFormat mmDate= new SimpleDateFormat("MM");
		 String str1=mmDate.format(str);
		 return str1; 
	 }
	 public static String ddDate(Date str){
		 SimpleDateFormat ddDate= new SimpleDateFormat("dd");
		 String str1=ddDate.format(str);
		 return str1; 
	 }
	 public static String ymdhmDate(Date str){
		 SimpleDateFormat ymdhmDate= new SimpleDateFormat("yyyy-MM-dd HH:mm");
		 String str1=ymdhmDate.format(str);
		 return str1; 
	 }
	 public static String ymdhmsDate(Date str){
		 SimpleDateFormat ymdhmDate= new SimpleDateFormat("yyyyMMddHHmmss");
		 String str1=ymdhmDate.format(str);
		 return str1; 
	 }
	 
	 public static Date tolongDate( String date ){
		 if (date == null) return null;
		 SimpleDateFormat longDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 Date dater = null;
		 try {
			dater = longDate.parse(date);
		 } catch (ParseException e) {
			 //throw new RuntimeException(e.getMessage());
			 e.printStackTrace();
		 }
		 return dater;
	 }

	 public static Date toseriesDate( String date ){
		 if (date == null) return null;
		 SimpleDateFormat longDate = new SimpleDateFormat("yyyyMMddHHmmss");
		 Date dater = null;
		 try {
			dater = longDate.parse(date);
		 } catch (ParseException e) {
			 //throw new RuntimeException(e.getMessage());
			 e.printStackTrace();
		 }
		 return dater;
	 }
	 
	 public static String toyyyymmddHHmmss(String date){
		 if( null!=date && !"".equals(date)){
			 String str = "";
			 try {
				str = longDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse((date)));
			 } catch (ParseException e) {
				// TODO Auto-generated catch block
			 }
			 return str;
		 }else{
			 return null;
		 }
	 }
	 
	 public static String toseriesDateStr(String date){
		 if( null!=date && !"".equals(date)){
			 String str = "";
			 try {
				str = longDate(new SimpleDateFormat("yyyyMMddHHmmss").parse((date)));
			 } catch (ParseException e) {
				// TODO Auto-generated catch block
			 }
			 return str;
		 }else{
			 return null;
		 }
	 }
	 public static void main(String[] args) throws ParseException {
//		Date dates = new Date();
//		System.out.println(dates);
//		System.out.println(longDate(dates));
//		System.out.println(tolongDate(longDate(dates)));
//		System.out.println(toyyyymmddHHmmss("2010-11-23 15.33.12.750000000"));
		String tmp = "2013-05-10 16:53:35 +0800 (星期二, 2011-05-10)";
		System.out.println("-------------"+tolongDate(tmp));
		Date a = tolongDate(tmp);
		Date b = new Date();
		System.out.println(""+a.compareTo(b));
	 }
}
