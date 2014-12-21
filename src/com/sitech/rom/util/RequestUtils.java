package com.sitech.rom.util;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.sitech.rom.rpt.bo.ParamType;

import net.sf.json.JSONObject;

public class RequestUtils {
	public  static <T> T requestToObject(HttpServletRequest r, Class<T> c){
		Map<String, String> m = new HashMap<String, String>();
		for(Enumeration enu = r.getParameterNames(); enu.hasMoreElements(); ){
			String pname = (String)enu.nextElement();
			if("opCode".equals(pname) || "proId".equals(pname))
				continue;
			m.put(pname, r.getParameter(pname));
		}
		JSONObject obj = JSONObject.fromObject(m);
		return (T)JSONObject.toBean(obj, c);
	}
	
	public static Map<String, String> getMap(HttpServletRequest r, String ...args){
		Map<String, String> m = new HashMap<String, String>();
		for(String n: args){
			String v = r.getParameter(n);
			if(v == null)
				v = "";
			m.put(n,  v);
		}
		return m;
	}
	
	public static void main(String[] args){
		ParamType p = new ParamType();
    	p.setTypeid(111);
    	p.setName("hello2");
    	p.setDatatype("S");
    	p.setRemarks("hello2");
    	JSONObject j = JSONObject.fromObject(p);
    	System.out.println(j.toString());
	}
}
