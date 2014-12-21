package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomSysRole implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long roleId;
	
	private String roleName;
	
	private String roleType;
	
	private String roleState;
	
	private String proCode;
	
	private String provinceCode;
	
	private String tellType;
	
	private String remarks;
	

	public Long getRoleId() {
		return roleId;
	}
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getRoleType() {
		return roleType;
	}
	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
	public String getRoleState() {
		return roleState;
	}
	public void setRoleState(String roleState) {
		this.roleState = roleState;
	}
	public String getProCode() {
		return proCode;
	}
	public void setProCode(String proCode) {
		this.proCode = proCode;
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
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("roleId=").append(roleId).append("\n");
		sb.append("roleName=").append(roleName).append("\n");
		sb.append("roleType=").append(roleType).append("\n");
		sb.append("roleState=").append(roleState).append("\n");
		sb.append("proCode=").append(proCode).append("\n");
		sb.append("provinceCode=").append(provinceCode).append("\n");
		sb.append("tellType=").append(tellType).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}