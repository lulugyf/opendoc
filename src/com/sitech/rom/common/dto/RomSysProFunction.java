package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomSysProFunction implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String proCode;
	
	private String functionCode;
	
	private String remarks;
	

	public String getProCode() {
		return proCode;
	}
	public void setProCode(String proCode) {
		this.proCode = proCode;
	}
	public String getFunctionCode() {
		return functionCode;
	}
	public void setFunctionCode(String functionCode) {
		this.functionCode = functionCode;
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
		sb.append("functionCode=").append(functionCode).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}