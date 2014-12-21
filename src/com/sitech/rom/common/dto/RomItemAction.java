package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomItemAction implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long actionId;
	
	private String actionName;
	
	private String remarks;
	

	public Long getActionId() {
		return actionId;
	}
	public void setActionId(Long actionId) {
		this.actionId = actionId;
	}
	public String getActionName() {
		return actionName;
	}
	public void setActionName(String actionName) {
		this.actionName = actionName;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("actionId=").append(actionId).append("\n");
		sb.append("actionName=").append(actionName).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}