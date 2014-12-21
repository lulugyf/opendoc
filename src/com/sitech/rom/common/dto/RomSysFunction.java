package com.sitech.rom.common.dto;

import java.io.Serializable;

import org.springframework.stereotype.Component;

public class RomSysFunction implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String functionCode;
	
	private String functionName;
	
	private String actionName;
	
	private String nodeType;
	
	private String parentCode;
	
	private String operationCode;
	
	private Long noteSeq;
	
	private String remarks;
	
	private String openType;//打开方式
	

	public String getFunctionCode() {
		return functionCode;
	}
	public void setFunctionCode(String functionCode) {
		this.functionCode = functionCode;
	}
	public String getFunctionName() {
		return functionName;
	}
	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}
	public String getActionName() {
		return actionName;
	}
	public void setActionName(String actionName) {
		this.actionName = actionName;
	}
	public String getNodeType() {
		return nodeType;
	}
	public void setNodeType(String nodeType) {
		this.nodeType = nodeType;
	}
	public String getParentCode() {
		return parentCode;
	}
	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}
	public String getOperationCode() {
		return operationCode;
	}
	public void setOperationCode(String operationCode) {
		this.operationCode = operationCode;
	}
	public Long getNoteSeq() {
		return noteSeq;
	}
	public void setNoteSeq(Long noteSeq) {
		this.noteSeq = noteSeq;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getOpenType() {
		return openType;
	}
	public void setOpenType(String openType) {
		this.openType = openType;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("functionCode=").append(functionCode).append("\n");
		sb.append("functionName=").append(functionName).append("\n");
		sb.append("actionName=").append(actionName).append("\n");
		sb.append("nodeType=").append(nodeType).append("\n");
		sb.append("parentCode=").append(parentCode).append("\n");
		sb.append("operationCode=").append(operationCode).append("\n");
		sb.append("noteSeq=").append(noteSeq).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		sb.append("openType=").append(openType).append("\n");
		return sb.toString();
	}

	
}