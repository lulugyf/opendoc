package com.sitech.rom.common.bo;

import java.io.Serializable;

public class HostBo implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long hostId;
	
	private String provinceCode;
	
	private String hostEnv;
	
	private String hostIp;
	private String hostName;
	
	private String hostOs;
	
	private java.util.Date updateTime;
	
	private java.util.Date updateTimeStart;
	
	private java.util.Date updateTimeEnd; 
	
	private String remark;
	//
	private String provinceName;
	private String tellType;
	private String tellName;
	private String proCode;
	private String proName;
	private String loginNo;
 
	public String getTellName() {
		return tellName;
	}
	public void setTellName(String tellName) {
		this.tellName = tellName;
	}
	public Long getHostId() {
		return hostId;
	}
	public void setHostId(Long hostId) {
		this.hostId = hostId;
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
	public java.util.Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(java.util.Date updateTime) {
		this.updateTime = updateTime;
	}
	public java.util.Date getUpdateTimeStart() {
		return updateTimeStart;
	}
	public void setUpdateTimeStart(java.util.Date updateTimeStart) {
		this.updateTimeStart = updateTimeStart;
	}
	public java.util.Date getUpdateTimeEnd() {
		return updateTimeEnd;
	}
	public void setUpdateTimeEnd(java.util.Date updateTimeEnd) {
		this.updateTimeEnd = updateTimeEnd;
	}
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getTellType() {
		return tellType;
	}
	public void setTellType(String tellType) {
		this.tellType = tellType;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public String getHostName() {
		return hostName;
	}
	public void setHostName(String hostName) {
		this.hostName = hostName;
	}
	public String getLoginNo() {
		return loginNo;
	}
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}
	public String getProCode() {
		return proCode;
	}
	public void setProCode(String proCode) {
		this.proCode = proCode;
	}
	
	
}
