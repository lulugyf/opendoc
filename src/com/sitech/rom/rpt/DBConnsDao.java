package com.sitech.rom.rpt; 
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sitech.jcf.core.dao.BaseDao;
import com.sitech.rom.common.bo.DataRightBo;
import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomTellcorpCode;
import com.sitech.rom.rpt.bo.DBConn;
 
@Repository("dbConnsDao")
public class DBConnsDao  extends BaseService 
{ 

	@Autowired
	private BaseDao baseDao;
 
	public List<DBConn> getDBConnsList(String label,String host,String db){
		DBConn qry = new DBConn();
		qry.setLabel(label);
		qry.setHost(host);
		qry.setDb(db);
		return (List<DBConn>) baseDao.queryForList("sdbconns.qryConns", qry);
	}
	
	public DBConn getInfo(String label,String host,String db){
		DBConn qry = new DBConn();
		qry.setLabel(label);
		qry.setHost(host);
		qry.setDb(db);
		return (DBConn) baseDao.queryForObject("sdbconns.qryConns", qry);
	}

	public void insert(DBConn db){
		baseDao.insert("sdbconns.insertConns", db);
	}
	public int update(Map params){
		return baseDao.update("sdbconns.updateConns", params);
	}
	public int delete(String label){
		return baseDao.delete("sdbconns.deleteConns", label);
	}
}
