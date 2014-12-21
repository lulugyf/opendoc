package com.sitech.rom.rpt.bo;

public class ParamData {
	private int paramid;
	private int typeid;
	private String paramValue;
	private String paramName;
	private int parentid;
	private String remarks;
	
	private String loginno;
	
	public String getLoginno() {
		return loginno;
	}
	public void setLoginno(String loginno) {
		this.loginno = loginno;
	}
	public int getParamid() {
		return paramid;
	}
	public void setParamid(int paramid) {
		this.paramid = paramid;
	}
	public int getTypeid() {
		return typeid;
	}
	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}
	public String getParamValue() {
		return paramValue;
	}
	public void setParamValue(String paramValue) {
		this.paramValue = paramValue;
	}
	public String getParamName() {
		return paramName;
	}
	public void setParamName(String paramName) {
		this.paramName = paramName;
	}
	public int getParentid() {
		return parentid;
	}
	public void setParentid(int parentid) {
		this.parentid = parentid;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String toString(){
		return String.format("id:%d type:%d parent:%d value:%s name:%s remarks:%s",
				paramid, typeid, parentid, paramValue, paramName, remarks);
	}
	
}
