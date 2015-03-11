package com.sitech.rom.common.dto;

import java.io.Serializable;

import com.sitech.rom.rpt.bo.MyBaseBO;

public class RomProCode extends MyBaseBO implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String proCode;
	
	private String proName;
	
	private String proVersion;
	
	private String remarks;
	

	public String getProCode() {
		return proCode;
	}
	public void setProCode(String proCode) {
		this.proCode = proCode;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public String getProVersion() {
		return proVersion;
	}
	public void setProVersion(String proVersion) {
		this.proVersion = proVersion;
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
		sb.append("proName=").append(proName).append("\n");
		sb.append("proVersion=").append(proVersion).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}