package com.sitech.jcf.sample.service;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService(serviceName="HelloService")
public interface HelloService {	
	@WebMethod
	String sayHi(String name,int sleep);

}
