package com.sitech.rom.rpt.bo;

import java.io.Serializable;

public class DBConn implements Serializable{
	private String label;
	private String host;
	private String user;
	private String pswd;
	private String dbtype;
	private String db;
	private String remarks;

	public String getDbtype() {
		return dbtype;
	}
	public void setDbtype(String dbtype) {
		this.dbtype = dbtype;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPswd() {
		return pswd;
	}
	public void setPswd(String pswd) {
		this.pswd = pswd;
	}
	public String getDb() {
		return db;
	}
	public void setDb(String db) {
		this.db = db;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}
