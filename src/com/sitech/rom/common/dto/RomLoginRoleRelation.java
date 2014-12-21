package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomLoginRoleRelation implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String loginNo;
	
	private Long roleId;
	
	private String remarks;
	

	public String getLoginNo() {
		return loginNo;
	}
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}
	public Long getRoleId() {
		return roleId;
	}
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("loginNo=").append(loginNo).append("\n");
		sb.append("roleId=").append(roleId).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}