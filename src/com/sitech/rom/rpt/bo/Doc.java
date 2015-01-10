package com.sitech.rom.rpt.bo;

public class Doc {
	private int docid;
	private String group_func;
	private String function_code;
	private String function_name;
	private String docname;
	private String baseurl;
	private int boid;
	private String boname;
	private String opendocid;
	private String remarks;
	
	
	public String getBoname() {
		return boname;
	}
	public void setBoname(String boname) {
		this.boname = boname;
	}
	public String getOpendocid() {
		return opendocid;
	}
	public void setOpendocid(String opendocid) {
		this.opendocid = opendocid;
	}
	public int getBoid() {
		return boid;
	}
	public void setBoid(int boid) {
		this.boid = boid;
	}
	public String getFunction_name() {
		return function_name;
	}
	public void setFunction_name(String function_name) {
		this.function_name = function_name;
	}
	public String getGroup_func() {
		return group_func;
	}
	public void setGroup_func(String group_func) {
		this.group_func = group_func;
	}
	public int getDocid() {
		return docid;
	}
	public void setDocid(int docid) {
		this.docid = docid;
	}
	public String getFunction_code() {
		return function_code;
	}
	public void setFunction_code(String function_code) {
		this.function_code = function_code;
	}
	public String getDocname() {
		return docname;
	}
	public void setDocname(String docname) {
		this.docname = docname;
	}
	public String getBaseurl() {
		return baseurl;
	}
	public void setBaseurl(String baseurl) {
		this.baseurl = baseurl;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}
