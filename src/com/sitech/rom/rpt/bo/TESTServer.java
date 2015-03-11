package com.sitech.rom.rpt.bo;

import java.io.Serializable;

public class TESTServer implements Serializable{
	
	private String order_id;
	private String serv_ip;
	private String serv_name;
	private String serv_user;
	
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String order_id) {
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

}
