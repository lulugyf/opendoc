package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomOperaCode implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String operaCode;
	
	private String operaName;
	
	private String remarks;
	

	public String getOperaCode() {
		return operaCode;
	}
	public void setOperaCode(String operaCode) {
		this.operaCode = operaCode;
	}
	public String getOperaName() {
		return operaName;
	}
	public void setOperaName(String operaName) {
		this.operaName = operaName;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("operaCode=").append(operaCode).append("\n");
		sb.append("operaName=").append(operaName).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}