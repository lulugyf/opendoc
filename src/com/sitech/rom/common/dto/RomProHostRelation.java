package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomProHostRelation implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String proCode;
	
	private Long hostId;
	
	private String remarks;
	

	public String getProCode() {
		return proCode;
	}
	public void setProCode(String proCode) {
		this.proCode = proCode;
	}
	public Long getHostId() {
		return hostId;
	}
	public void setHostId(Long hostId) {
		this.hostId = hostId;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("proCode=").append(proCode).append("\n");
		sb.append("hostId=").append(hostId).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}