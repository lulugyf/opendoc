package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomProFtpsiteRelation implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String proCode;
	
	private Long siteId;
	
	private String remarks;
	

	public String getProCode() {
		return proCode;
	}
	public void setProCode(String proCode) {
		this.proCode = proCode;
	}
	public Long getSiteId() {
		return siteId;
	}
	public void setSiteId(Long siteId) {
		this.siteId = siteId;
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
		sb.append("siteId=").append(siteId).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}