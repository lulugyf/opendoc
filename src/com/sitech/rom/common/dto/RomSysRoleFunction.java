package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomSysRoleFunction implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String roleId;
	
	private String functionCode;
	
	private String operationCode;
	

	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	public String getFunctionCode() {
		return functionCode;
	}
	public void setFunctionCode(String functionCode) {
		this.functionCode = functionCode;
	}
	public String getOperationCode() {
		return operationCode;
	}
	public void setOperationCode(String operationCode) {
		this.operationCode = operationCode;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("roleId=").append(roleId).append("\n");
		sb.append("functionCode=").append(functionCode).append("\n");
		sb.append("operationCode=").append(operationCode).append("\n");
		return sb.toString();
	}
	
}