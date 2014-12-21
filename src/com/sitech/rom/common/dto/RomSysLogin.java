package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomSysLogin implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String loginNo;
	
	private String loginName;
	
	private String loginPwd;
	
	private String useFlg;
	
	private java.util.Date expireTime;
	
	private java.util.Date expireTimeStart;
	
	private java.util.Date expireTimeEnd;
	
	private String loginFlg;
	
	private String phoneNo;
	
	private String loginIp;
	
	private String remark;
	
	private String province_code;

	public String getProvince_code() {
		return province_code;
	}
	public void setProvince_code(String province_code) {
		this.province_code = province_code;
	}
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
	public String getLoginPwd() {
		return loginPwd;
	}
	public void setLoginPwd(String loginPwd) {
		this.loginPwd = loginPwd;
	}
	public String getUseFlg() {
		return useFlg;
	}
	public void setUseFlg(String useFlg) {
		this.useFlg = useFlg;
	}
	public java.util.Date getExpireTime() {
		return expireTime;
	}
	public void setExpireTime(java.util.Date expireTime) {
		this.expireTime = expireTime;
	}
	public java.util.Date getExpireTimeStart() {
		return expireTimeStart;
	}
	public void setExpireTimeStart(java.util.Date expireTimeStart) {
		this.expireTimeStart = expireTimeStart;
	}
	public java.util.Date getExpireTimeEnd() {
		return expireTimeEnd;
	}
	public void setExpireTimeEnd(java.util.Date expireTimeEnd) {
		this.expireTimeEnd = expireTimeEnd;
	}
	public String getLoginFlg() {
		return loginFlg;
	}
	public void setLoginFlg(String loginFlg) {
		this.loginFlg = loginFlg;
	}
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getLoginIp() {
		return loginIp;
	}
	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("loginNo=").append(loginNo).append("\n");
		sb.append("loginName=").append(loginName).append("\n");
		sb.append("loginPwd=").append(loginPwd).append("\n");
		sb.append("useFlg=").append(useFlg).append("\n");
		sb.append("expireTime=").append(expireTime).append("\n");
		sb.append("expireTimeStart=").append(expireTimeStart).append("\n");
		sb.append("expireTimeEnd=").append(expireTimeEnd).append("\n");
		sb.append("loginFlg=").append(loginFlg).append("\n");
		sb.append("phoneNo=").append(phoneNo).append("\n");
		sb.append("loginIp=").append(loginIp).append("\n");
		sb.append("remark=").append(remark).append("\n");
		sb.append("province_code=").append(province_code).append("\n");
		return sb.toString();
	}
	
}