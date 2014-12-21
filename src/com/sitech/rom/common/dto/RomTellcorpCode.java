package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomTellcorpCode implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String tellcorpCode;
	
	private String tellcorpName;
	
	private String remarks;
	

	public String getTellcorpCode() {
		return tellcorpCode;
	}
	public void setTellcorpCode(String tellcorpCode) {
		this.tellcorpCode = tellcorpCode;
	}
	public String getTellcorpName() {
		return tellcorpName;
	}
	public void setTellcorpName(String tellcorpName) {
		this.tellcorpName = tellcorpName;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("tellcorpCode=").append(tellcorpCode).append("\n");
		sb.append("tellcorpName=").append(tellcorpName).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}