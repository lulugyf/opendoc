package com.sitech.rom.common.dto;

import java.io.Serializable;

public class EaiBusiConfig implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long busiId;
	
	private String busiName;
	
	private oracle.sql.CLOB flowXml;
	
	private String remarks;
	

	public Long getBusiId() {
		return busiId;
	}
	public void setBusiId(Long busiId) {
		this.busiId = busiId;
	}
	public String getBusiName() {
		return busiName;
	}
	public void setBusiName(String busiName) {
		this.busiName = busiName;
	}
	public oracle.sql.CLOB getFlowXml() {
		return flowXml;
	}
	public void setFlowXml(oracle.sql.CLOB flowXml) {
		this.flowXml = flowXml;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("busiId=").append(busiId).append("\n");
		sb.append("busiName=").append(busiName).append("\n");
		sb.append("flowXml=").append(flowXml).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}