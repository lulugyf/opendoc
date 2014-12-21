package com.sitech.rom.common.dto;

import java.io.Serializable;

public class OnebossBusiGroups implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long groupId;
	
	private String groupName;
	
	private Long isdefault;
	
	private String loginNo;
	
	private Long hostId;
	
	private String proCode;
	
	private String remarks;
	
	private String reserve1;
	
	private String reserve2;
	
	private String reserve3;
	

	public Long getGroupId() {
		return groupId;
	}
	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public Long getIsdefault() {
		return isdefault;
	}
	public void setIsdefault(Long isdefault) {
		this.isdefault = isdefault;
	}
	public String getLoginNo() {
		return loginNo;
	}
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}
	public Long getHostId() {
		return hostId;
	}
	public void setHostId(Long hostId) {
		this.hostId = hostId;
	}
	public String getProCode() {
		return proCode;
	}
	public void setProCode(String proCode) {
		this.proCode = proCode;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getReserve1() {
		return reserve1;
	}
	public void setReserve1(String reserve1) {
		this.reserve1 = reserve1;
	}
	public String getReserve2() {
		return reserve2;
	}
	public void setReserve2(String reserve2) {
		this.reserve2 = reserve2;
	}
	public String getReserve3() {
		return reserve3;
	}
	public void setReserve3(String reserve3) {
		this.reserve3 = reserve3;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("groupId=").append(groupId).append("\n");
		sb.append("groupName=").append(groupName).append("\n");
		sb.append("isdefault=").append(isdefault).append("\n");
		sb.append("loginNo=").append(loginNo).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		sb.append("reserve1=").append(reserve1).append("\n");
		sb.append("reserve2=").append(reserve2).append("\n");
		sb.append("reserve3=").append(reserve3).append("\n");
		return sb.toString();
	}
	
}