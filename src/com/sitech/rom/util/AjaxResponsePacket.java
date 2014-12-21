package com.sitech.rom.util;

import java.lang.reflect.Method;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.sitech.rom.rpt.bo.ParamType;

import net.sf.json.JSONObject;

public class AjaxResponsePacket {
	
	public Map data = new HashMap();
	
	private String dataPacketed(){
		StringBuilder sb = new StringBuilder();
		sb.append("var response = new AJAXPacket();");
		String type;
		for (Iterator iterator = data.keySet().iterator(); iterator.hasNext();) {
			type = (String) iterator.next();
			sb.append("response.data.add('").append(type).append("','").append(data.get(type)).append("');");
		}
		sb.append("core.ajax.receivePacket(response);");
		return sb.toString();
	}

	public String getAjaxPacketText(){
		return dataPacketed();
	}
	
	

	
	public static void main(String[] args){
//		Map<String, String> m = new HashMap<String, String>();
//		m.put("_", "11231232");
//		m.put("typeid", "123");
//		m.put("name", "hehe");
//		m.put("datatype", "S");
//		ParamType t = (ParamType)mapToObject(m, ParamType.class);
//		System.out.println(t.getName());
	}
	
}
