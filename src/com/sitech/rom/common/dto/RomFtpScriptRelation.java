package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomFtpScriptRelation implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long siteId;
	
	private Long scriptId;
	
	private Long actionId;
	

	public Long getSiteId() {
		return siteId;
	}
	public void setSiteId(Long siteId) {
		this.siteId = siteId;
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
		sb.append("siteId=").append(siteId).append("\n");
		sb.append("scriptId=").append(scriptId).append("\n");
		sb.append("actionId=").append(actionId).append("\n");
		return sb.toString();
	}
	
}