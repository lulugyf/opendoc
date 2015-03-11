package com.sitech.rom.rpt.bo;

import java.io.Serializable;

public class BOServer extends MyBaseBO implements Serializable{
	
	private int boid;
	private String boname;
	private String authaddr;
	private String username;
	private String password;
	private String opendocaddr;
	private String remarks;
	
	public int getBoid() {
		return boid;
	}
	public void setBoid(int boid) {
		this.boid = boid;
	}
	public String getBoname() {
		return boname;
	}
	public void setBoname(String boname) {
		this.boname = boname;
	}
	public String getAuthaddr() {
		return authaddr;
	}
	public void setAuthaddr(String authaddr) {
		this.authaddr = authaddr;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getOpendocaddr() {
		return opendocaddr;
	}
	public void setOpendocaddr(String opendocaddr) {
		this.opendocaddr = opendocaddr;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}
