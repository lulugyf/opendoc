package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomHostInfo implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long hostId;
	
	private String provinceCode;
	
	private String tellType;
	
	private String hostEnv;
	
	private String hostIp;
	
	private String hostName;
	
	private String hostOs;
	
	private java.util.Date updateTime;
	
	private java.util.Date updateTimeStart;
	
	private java.util.Date updateTimeEnd;
	
	private String remark;
	

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
	public String getTellType() {
		return tellType;
	}
	public void setTellType(String tellType) {
		this.tellType = tellType;
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
	public String getHostName() {
		return hostName;
	}
	public void setHostName(String hostName) {
		this.hostName = hostName;
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("hostId=").append(hostId).append("\n");
		sb.append("provinceCode=").append(provinceCode).append("\n");
		sb.append("tellType=").append(tellType).append("\n");
		sb.append("hostEnv=").append(hostEnv).append("\n");
		sb.append("hostIp=").append(hostIp).append("\n");
		sb.append("hostName=").append(hostName).append("\n");
		sb.append("hostOs=").append(hostOs).append("\n");
		sb.append("updateTime=").append(updateTime).append("\n");
		sb.append("updateTimeStart=").append(updateTimeStart).append("\n");
		sb.append("updateTimeEnd=").append(updateTimeEnd).append("\n");
		sb.append("remark=").append(remark).append("\n");
		return sb.toString();
	}
	
}