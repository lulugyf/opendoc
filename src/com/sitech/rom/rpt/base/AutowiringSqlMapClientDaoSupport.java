package com.sitech.rom.rpt.base;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapClient;

public class AutowiringSqlMapClientDaoSupport extends SqlMapClientDaoSupport {
	@Autowired
	public void injectSqlMapClient(SqlMapClient sqlMapClient) {
		setSqlMapClient(sqlMapClient);
	}
}
