package com.sitech.jcf.sample.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.ibatis.sqlmap.engine.jcf.dymapping.parameter.DyParameter;
import com.ibatis.sqlmap.engine.jcf.dymapping.statement.StatementFactory;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcf.core.dao.DbRouteLabel;
import com.sitech.jcf.core.dao.IBaseDao;
import com.sitech.jcf.core.exception.AppException;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcf.ijdbc.SqlChange;

import com.sitech.jcf.ijdbc.SqlFind;
import com.sitech.jcf.ijdbc.util.DataSourceUtils;
import com.sitech.jcf.sample.dto.Person;
import com.sitech.jcf.sample.service.HelloService;
import com.sitech.jcf.sample.service.IPersonService;

public class PersonService implements IPersonService{
	private static final String mapId = "order.PersonMapper";
 	
	private IBaseDao baseDao;
    public void setBaseDao(IBaseDao baseDao) {
		this.baseDao = baseDao;
	}
    
    public void savePPP(int i){
    	Person p = new Person();
    	p.setId(1234);
    	p.setName("lilili");
//    	baseDao.insert(mapId+".insert", p);
    	DbRouteLabel d = SessionContext.get(DbRouteLabel.class);
    	System.out.println("#############"+ d);
    	
//    	HelloService hs = (HelloService)LocalContextFactory.getInstance().getBean("HelloSvc");
//    	hs.sayHi("licl", 0);
//    	//hs = (HelloService)LocalContextFactory.getInstance().getBean("HelloSvc");
//    	if (i==6) throw new AppException("caocaocao");
//    	hs.sayHi("licl", 0);
//    	p = new Person();
//    	p.setId(1235);
//    	p.setName("qqqqqqqqq");
//    	baseDao.insert(mapId+".insert", p);
    }
    
	public void insertPerson(Person person) {
		baseDao.insert(mapId+".insert", person);
		
//		String[] para = new String[2];
//		para[0] = ""+person.getId();
//		para[1] = person.getName();
//		DyParameter dp = new DyParameter();
//		dp.addSets("id", new Long(100));
//		dp.addSets("name", "aaaaaa");
//		baseDao.insert(StatementFactory.genDyInsertSqlId("person"),dp);
	}

	public int deletePerson(Person person) {		
		//return baseDao.delete(mapId+".delete",person);
		DyParameter dp = new DyParameter();
//		dp.addSets("name", "xxxxx");
		dp.addWhere("id", new Long(100));
		return baseDao.update(StatementFactory.genDyDeleteSqlId("person"),dp);
	}

	public int updatePerson(Person person) {
		//return baseDao.update(mapId+".update",person);
		DyParameter dp = new DyParameter();
		dp.addSets("name", person.getName());
		dp.addWhere("id", person.getName());		
		return baseDao.update(StatementFactory.genDyUpdateSqlId("person"),dp);
	}

	public Person queryPersonById(Person person) {
		//return (Person)baseDao.queryForObject(mapId+".queryById", person);
		DyParameter dp = new DyParameter();
		dp.addWhere("id", new Long(person.getId()));
		List rtn = baseDao.queryForList(StatementFactory.genDySelectSqlId("person"), dp);
//		System.out.println("xxxxxxxxxxxxxx" + rtn.size());
		for (int i=0; i< rtn.size(); i++){
			String[] arr = (String[])rtn.get(i);
//			System.out.println(arr[0]+"|"+arr[1]);
			person.setName(arr[1]);
		}
		return person;
	}

	public List<Person> queryAllPerson() {
		return baseDao.queryForList(mapId+".queryAll");
	}

	public HashMap queryPersonPageList(int offsize, int limit) {
		return (HashMap) baseDao.queryForPagingList(mapId+".queryAll", null, offsize, limit);
	}


	public HashMap queryPersonPageListForCount(Integer id,Integer offsize, Integer limit) {
		// TODO Auto-generated method stub
		Person p=new Person();
		p.setId(id);
		return (HashMap) baseDao.queryForPagingList(mapId+".queryAll", p, offsize, limit);
	}
	
	//ijdbc:不带连接参数
	public void allIjdbcNoExistConnectParaTest(){
		String num="";
		//jdbc
		SqlFind sf=new SqlFind();
		num=sf.findString("select count(*) from person");
		System.out.println("======================num1="+num);	
		sf.findList("select * from person");
		System.out.println("======================list=");		

	}
	
	//ijdbc:带连接参数
	public void allIjdbcExistConnectParaTest(){
		String num="";
		//jdbc
		SqlFind sf=new SqlFind();
		Connection conn=baseDao.getConnection();
		num=sf.findString(conn,"select count(*) from person");
		System.out.println("======================num1="+num);	
		sf.findList(conn,"select count(*) from person");
		System.out.println("======================list=");		
		//DataSourceUtils.closeConnection(conn);	
	}	
	
	//ibatis
	public void allIbatisTest(){
		//spring
		this.queryAllPerson();	
		this.queryAllPerson();
	}
	
	//组合使用方式ibatis/jdbc/jdbc
	public void mixJdbcIbatis1(){
		String num="";
		//ibatis
		this.queryAllPerson();	
		//jdbc
		SqlFind sf=new SqlFind();
		Connection conn=baseDao.getConnection();
		num=sf.findString(conn,"select count(*) from person");
		System.out.println("======================num1="+num);	
		sf.findList(conn,"select count(*) from person");
		System.out.println("======================list=");			
	}
	
	//组合使用方式ibatis/jdbc/ibatis
	public void mixJdbcIbatis2(){
		String num="";
		//ibatis
		this.queryAllPerson();	
		//jdbc
		SqlFind sf=new SqlFind();
		Connection conn=baseDao.getConnection();
		num=sf.findString(conn,"select count(*) from person");
		System.out.println("======================num1="+num);	
		//ibatis
		this.queryAllPerson();			
	}	

	//组合使用方式jdbc/ibatis/ibatis
	public void mixJdbcIbatis3(){
		String num="";
		//jdbc
		SqlFind sf=new SqlFind();
		Connection conn=baseDao.getConnection();
		num=sf.findString(conn,"select count(*) from person");
		System.out.println("======================num1="+num);	
		//ibatis
		this.queryAllPerson();	
		this.queryAllPerson();			
	}	

	//组合使用方式jdbc/ibatis/jdbc
	public void mixJdbcIbatis4(){
		String num="";
		//jdbc
		SqlFind sf=new SqlFind();
		Connection conn=baseDao.getConnection();
		num=sf.findString(conn,"select count(*) from person");
		System.out.println("======================num1="+num);	
		//ibatis
		this.queryAllPerson();	
		//jdbc
		sf.findList(conn,"select count(*) from person");
		System.out.println("======================list=");			
	}	
	
	//组合使用方式ibatis/jdbc
	public void mixIbatisJdbcCommit(String para,String key,String value){
		//ibatis:insert
		Person p=new Person();
		p.setId(123);
		p.setName("test123");
		this.insertPerson(p);
		
		//ijdbc:insert
		SqlChange sc=new SqlChange();
		Connection conn=baseDao.getConnection();
		try {
			sc.execute(conn,"insert into person(id,name) values(1234,'test1234')");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
	}
	
	//组合使用方式ibatis/jdbc
	public void mixIbatisJdbcRollcack(String para,String key,String value){
		//ibatis:insert
		Person p=new Person();
		p.setId(321);
		p.setName("test321");
		this.insertPerson(p);
		
		//ijdbc:insert
		SqlChange sc=new SqlChange();
		Connection conn=baseDao.getConnection();
		try {
			sc.execute(conn,"insert into person(id,name) values(4321,'test4321')");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		throw new BusiException("测试回滚！");	
		
	}
	
	//ibatis返回数组
	public void returnArrays(){
		System.out.println("======returnArrays test=====");
		List l=baseDao.queryForList(mapId+".queryAllToArray");
		for(int i=0;i<l.size();i++){
			Object[] arr=(Object[])l.get(i);
			for(Object o:arr){
				System.out.println("list item=["+o+"]");
			} 
		}
		System.out.println(l);
		Map m= (HashMap) baseDao.queryForPagingList(mapId+".queryAllToArray", null, 1, 10);
		List ml=(List)m.get("result");
		for(int i=0;i<ml.size();i++){
		Object[] arr=(Object[])ml.get(i);
		for(Object o:arr){
			System.out.println("map item=["+o+"]");
		}
	}		
		System.out.println(m);
		
		Person p=new Person();
		p.setId(1);
		Object[] arr=(Object[])baseDao.queryForObject(mapId+".queryToArrayById",p);
		for(Object o:arr){
			System.out.println("queryForObject item=["+o+"]");
		}
	}
 
	//数据库路由
	public void dbRoute(Person p, String key, String value){
		//ibatis:insert
		p.setName("testDbRoute");
		this.insertPerson(p);
		
	}
	
	
 	
}
