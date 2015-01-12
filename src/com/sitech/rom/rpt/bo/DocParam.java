package com.sitech.rom.rpt.bo;

public class DocParam {

	private int paramid;
	private int docid;
	private String param;
	private String pnametype;
	private String default_value;
	private int typeid;
	private int filterflag;
	private int allowchange;
	private String remarks;
	
	private String typename;
	
	
	public int getAllowchange() {
		return allowchange;
	}
	public void setAllowchange(int allowchange) {
		this.allowchange = allowchange;
	}
	
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public int getDocid() {
		return docid;
	}
	public void setDocid(int docid) {
		this.docid = docid;
	}
	public String getParam() {
		return param;
	}
	public void setParam(String param) {
		this.param = param;
	}
	public String getDefault_value() {
		return default_value;
	}
	public void setDefault_value(String default_value) {
		this.default_value = default_value;
	}
	public int getTypeid() {
		return typeid;
	}
	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}
	public int getFilterflag() {
		return filterflag;
	}
	public void setFilterflag(int filterflag) {
		this.filterflag = filterflag;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public int getParamid() {
		return paramid;
	}
	public void setParamid(int paramid) {
		this.paramid = paramid;
	}
	public String getPnametype() {
		return pnametype;
	}
	public void setPnametype(String pnametype) {
		this.pnametype = pnametype;
	}
	

	
}
