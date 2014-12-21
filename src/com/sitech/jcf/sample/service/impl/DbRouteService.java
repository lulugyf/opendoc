package com.sitech.jcf.sample.service.impl;

import com.sitech.jcf.core.dao.DbRoute;

public class DbRouteService implements DbRoute{

	public String getDBLabel(String beanName, String methodName, Object[] params) {
		return "A";
//		try{
//			int i = (Integer)params[0];
//			if (i<10) return "A";
//			else return "B";
//		}
//		catch(Exception e){
//			return "A";
//		}
		
	}

}
