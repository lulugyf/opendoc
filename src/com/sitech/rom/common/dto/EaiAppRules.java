package com.sitech.rom.common.dto;

import java.io.Serializable;

public class EaiAppRules implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long instanceId;
	
	private Long minAppid;
	
	private Long maxAppid;
	

	public Long getInstanceId() {
		return instanceId;
	}
	public void setInstanceId(Long instanceId) {
		this.instanceId = instanceId;
	}
	public Long getMinAppid() {
		return minAppid;
	}
	public void setMinAppid(Long minAppid) {
		this.minAppid = minAppid;
	}
	public Long getMaxAppid() {
		return maxAppid;
	}
	public void setMaxAppid(Long maxAppid) {
		this.maxAppid = maxAppid;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("instanceId=").append(instanceId).append("\n");
		sb.append("minAppid=").append(minAppid).append("\n");
		sb.append("maxAppid=").append(maxAppid).append("\n");
		return sb.toString();
	}
	
}