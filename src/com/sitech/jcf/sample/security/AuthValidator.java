package com.sitech.jcf.sample.security;

import javax.xml.namespace.QName;

import com.sitech.jcf.ws.security.IAuthValidator;

public class AuthValidator implements IAuthValidator{

	public boolean validate(String username, String password,QName serviceName) {
		return true;
	}
}
