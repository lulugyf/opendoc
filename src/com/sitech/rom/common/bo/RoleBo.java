package com.sitech.rom.common.bo;

import java.io.Serializable;

public class RoleBo implements Serializable {
	private static final long serialVersionUID = 1L;

	private Long roleId;
	
	private String roleName;
	
	private String roleType;
	
	private String roleState;
	
	private String provinceCode;
	
	private String tellType;
	
	private String remarks;
	
	private String provinceName;
	
	private String tellcorpName;
	
	private String proName;

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

	public String getProvinceName() {
		return provinceName;
	}

	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	public String getTellcorpName() {
		return tellcorpName;
	}

	public void setTellcorpName(String tellcorpName) {
		this.tellcorpName = tellcorpName;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}
}
