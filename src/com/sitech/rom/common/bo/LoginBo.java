package com.sitech.rom.common.bo;

import java.io.Serializable;

public class LoginBo implements Serializable {
	private static final long serialVersionUID = 1L;

	private String loginNo;
	private String loginName;
	private String provinceCode;
	private String tellType;
	private String proId;
	
	public String getLoginNo() {
		return loginNo;
	}
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getProvinceCode() {
		return provinceCode;
	}
	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}
	public String getTellType() {
		return tellType;
	}
	public void setTellType(String tellType) {
		this.tellType = tellType;
	}
	public String getProId() {
		return proId;
	}
	public void setProId(String proId) {
		this.proId = proId;
	}
}
