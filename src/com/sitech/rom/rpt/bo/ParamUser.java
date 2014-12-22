package com.sitech.rom.rpt.bo;

public class ParamUser {
	private int paramid;
	private String loginno;
	private String loginname;
	private String typename;
	private int typeid;
	private String paramName;
	private String paramValue;
	private int docid;
	private String ex_flag;
	
	
//	select a.paramid, a.login_no loginno, b.login_name loginname, d.name typename, c.typeid typeid, c.paramName, c.paramValue
//	 from t_paramuser_rel a, rom_sys_login b, t_paramdata c, t_paramtype d
//	where a.login_no=b.login_no and a.paramid=c.paramid and c.typeid=d.typeid	
	
	
	
	public String getEx_flag() {
		return ex_flag;
	}
	public void setEx_flag(String ex_flag) {
		this.ex_flag = ex_flag;
	}
	public int getDocid() {
		return docid;
	}
	public void setDocid(int docid) {
		this.docid = docid;
	}
	public int getParamid() {
		return paramid;
	}
	public void setParamid(int paramid) {
		this.paramid = paramid;
	}
	public String getLoginno() {
		return loginno;
	}
	public void setLoginno(String loginno) {
		this.loginno = loginno;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public int getTypeid() {
		return typeid;
	}
	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}
	public String getParamName() {
		return paramName;
	}
	public void setParamName(String paramName) {
		this.paramName = paramName;
	}
	public String getParamValue() {
		return paramValue;
	}
	public void setParamValue(String paramValue) {
		this.paramValue = paramValue;
	}

}
