package com.sitech.rom.common.bo;

import java.io.Serializable;

public class FunctionBo implements Serializable {
	private static final long serialVersionUID = 1L;

	private String functionCode;
	private String functionName;
	private String actionName;
	private String nodeType;
	private String parentCode;
	private String parentName;
	private String operationName;
	private Long noteSeq;
	private String openType;
	
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
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public String getOperationName() {
		return operationName;
	}
	public void setOperationName(String operationName) {
		this.operationName = operationName;
	}
	public Long getNoteSeq() {
		return noteSeq;
	}
	public void setNoteSeq(Long noteSeq) {
		this.noteSeq = noteSeq;
	}
	public String getOpenType() {
		return openType;
	}
	public void setOpenType(String openType) {
		this.openType = openType;
	}
}
