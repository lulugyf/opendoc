package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomItemScriptRelation implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long itemId;
	
	private Long scriptId;
	
	private Long actionId;
	

	public Long getItemId() {
		return itemId;
	}
	public void setItemId(Long itemId) {
		this.itemId = itemId;
	}
	public Long getScriptId() {
		return scriptId;
	}
	public void setScriptId(Long scriptId) {
		this.scriptId = scriptId;
	}
	public Long getActionId() {
		return actionId;
	}
	public void setActionId(Long actionId) {
		this.actionId = actionId;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("itemId=").append(itemId).append("\n");
		sb.append("scriptId=").append(scriptId).append("\n");
		sb.append("actionId=").append(actionId).append("\n");
		return sb.toString();
	}
	
}