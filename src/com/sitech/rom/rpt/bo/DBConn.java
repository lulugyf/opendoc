package com.sitech.rom.rpt.bo;

import java.io.Serializable;

public class DBConn extends MyBaseBO implements Serializable{
	
	private int order_id;
	private String serv_ip;
	private String serv_name;
	private String serv_user;
	private String serv_pwd;
	private String db_type;
	private String db_name;
	private int db_port;
	private String db_user;
	private String db_pwd;
	private String data_dir;
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public String getServ_ip() {
		return serv_ip;
	}
	public void setServ_ip(String serv_ip) {
		this.serv_ip = serv_ip;
	}
	public String getServ_name() {
		return serv_name;
	}
	public void setServ_name(String serv_name) {
		this.serv_name = serv_name;
	}
	public String getServ_user() {
		return serv_user;
	}
	public void setServ_user(String serv_user) {
		this.serv_user = serv_user;
	}
	public String getServ_pwd() {
		return serv_pwd;
	}
	public void setServ_pwd(String serv_pwd) {
		this.serv_pwd = serv_pwd;
	}
	public String getDb_type() {
		return db_type;
	}
	public void setDb_type(String db_type) {
		this.db_type = db_type;
	}
	public String getDb_name() {
		return db_name;
	}
	public void setDb_name(String db_name) {
		this.db_name = db_name;
	}
	public int getDb_port() {
		return db_port;
	}
	public void setDb_port(int db_port) {
		this.db_port = db_port;
	}
	public String getDb_user() {
		return db_user;
	}
	public void setDb_user(String db_user) {
		this.db_user = db_user;
	}
	public String getDb_pwd() {
		return db_pwd;
	}
	public void setDb_pwd(String db_pwd) {
		this.db_pwd = db_pwd;
	}
	public String getData_dir() {
		return data_dir;
	}
	public void setData_dir(String data_dir) {
		this.data_dir = data_dir;
	}


}
