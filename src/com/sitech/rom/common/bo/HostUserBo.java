package com.sitech.rom.common.bo;

import java.io.Serializable;

public class HostUserBo implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long userId;
	
	private Long hostId;
	
	private String userName;
	
	private String passwd;
	
	private String homeDir;
	
	private String remark; 
	
	//
	private String provinceCode;
	
	private String tellType;
	
	private String hostEnv;
	
	private String hostIp;
	
	private String hostOs;

	private String provinceName;
	private String tellName;
	private String proName;
	private String loginNo;
	private String proCode;
	
 
	public String getProCode() {
		return proCode;
	}

	public void setProCode(String proCode) {
		this.proCode = proCode;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getHostId() {
		return hostId;
	}

	public void setHostId(Long hostId) {
		this.hostId = hostId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getHomeDir() {
		return homeDir;
	}

	public void setHomeDir(String homeDir) {
		this.homeDir = homeDir;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}

	public String getHostEnv() {
		return hostEnv;
	}

	public void setHostEnv(String hostEnv) {
		this.hostEnv = hostEnv;
	}

	public String getHostIp() {
		return hostIp;
	}

	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}

	public String getHostOs() {
		return hostOs;
	}

	public void setHostOs(String hostOs) {
		this.hostOs = hostOs;
	}

	public String getProvinceName() {
		return provinceName;
	}

	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	public String getTellType() {
		return tellType;
	}

	public void setTellType(String tellType) {
		this.tellType = tellType;
	}

	public String getTellName() {
		return tellName;
	}

	public void setTellName(String tellName) {
		this.tellName = tellName;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}
 
	
}
