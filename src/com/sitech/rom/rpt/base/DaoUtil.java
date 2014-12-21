package com.sitech.rom.rpt.base;

import java.util.List;
import java.util.Properties;

import com.sitech.rom.rpt.bo.ConfParameter;

public final class DaoUtil {
	
	
	public static  long nextval(IMyBaseDao dao, String name){
		Object o = dao.queryForObject("rptparam.nextval", name);
		if(o instanceof Long){
			return (Long)o;
		}else{
			return -1;
		}
    }
	
	public static int count(IMyBaseDao dao, String sqlid, Object param){
		Object o = dao.queryForObject(sqlid, param);
		if(o instanceof Long){
			return (int)((Long)o).longValue();
		}
		if(o instanceof Integer){
			return ((Integer)o).intValue();
		}else{
			return -1;
		}
	}
	
	static Properties parameters = null;
	public static Properties getParameters(IMyBaseDao dao){
		if(parameters == null)
			parameters = new Properties();
		Properties p = parameters;
		
		List<ConfParameter> list = dao.queryForList("rptconf.qryParam");
		for(ConfParameter c: list){
			p.setProperty(c.getPname(), c.getPvalue());
		}
		return p;
	}
	public static String getParameter(IMyBaseDao dao, String pname){
		if(parameters == null)
			getParameters(dao);
		return parameters.getProperty(pname);
	}
}
