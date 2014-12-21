package com.sitech.jcf.sample.service;

import java.util.HashMap;
import java.util.List;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

import com.sitech.jcf.sample.dto.Person;
@WebService(portName="PersonService",serviceName="PersonService")
public interface IPersonService {
	@WebMethod
	public void insertPerson(@WebParam(name="person")Person person);
	@WebMethod
	public int deletePerson(@WebParam(name="person")Person person) ;
	@WebMethod
	public int updatePerson(@WebParam(name="person")Person person) ;
	
	@WebMethod
	public Person queryPersonById(@WebParam(name="person")Person person);
	@WebMethod
	public List<Person> queryAllPerson();
	@WebMethod
	public HashMap queryPersonPageList(@WebParam(name="offsize")int offsize,@WebParam(name="limit")int limit);
	@WebMethod
	public HashMap queryPersonPageListForCount(@WebParam(name="id")Integer id,@WebParam(name = "offsize") Integer offsize,@WebParam(name="limit")Integer limit);
	@WebMethod
	public void allIjdbcNoExistConnectParaTest();
	@WebMethod
	public void allIjdbcExistConnectParaTest();
	@WebMethod
	public void allIbatisTest();	
	@WebMethod
	public void mixJdbcIbatis1();		
	@WebMethod
	public void mixJdbcIbatis2();	
	@WebMethod
	public void mixJdbcIbatis3();	
	@WebMethod
	public void mixJdbcIbatis4();	
	@WebMethod
	public void returnArrays();	
	@WebMethod
	public void mixIbatisJdbcCommit(String para,String key,String value);
	@WebMethod
	public void mixIbatisJdbcRollcack(String para,String key,String value);
	@WebMethod
	public void dbRoute(Person p, String key, String value);	
	
 
	
}
