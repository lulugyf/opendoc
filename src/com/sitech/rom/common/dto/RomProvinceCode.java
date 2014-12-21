package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomProvinceCode implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String provinceCode;
	
	private String provinceName;
	
	private String remarks;
	

	public String getProvinceCode() {
		return provinceCode;
	}
	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("provinceCode=").append(provinceCode).append("\n");
		sb.append("provinceName=").append(provinceName).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}