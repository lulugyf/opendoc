package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomSysPopedom implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String functionCode;
	
	private String actionName;
	
	private String operationCode;
	

	public String getFunctionCode() {
		return functionCode;
	}
	public void setFunctionCode(String functionCode) {
		this.functionCode = functionCode;
	}
	public String getActionName() {
		return actionName;
	}
	public void setActionName(String actionName) {
		this.actionName = actionName;
	}
	public String getOperationCode() {
		return operationCode;
	}
	public void setOperationCode(String operationCode) {
		this.operationCode = operationCode;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("functionCode=").append(functionCode).append("\n");
		sb.append("actionName=").append(actionName).append("\n");
		sb.append("operationCode=").append(operationCode).append("\n");
		return sb.toString();
	}
	
}