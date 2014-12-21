package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomHostCheckItem implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private Long seqId;
	
	private String provinceCode;
	
	private String tellType;
	
	private String proCode;
	
	private String fatherSection;
	
	private String childSection;
	
	private String kpiId;
	
	private String checkCycle;
	
	private String reserved1;
	
	private String reserved2;
	
	private String remark;
	
	

	public Long getSeqId() {
		return seqId;
	}

	public void setSeqId(Long seqId) {
		this.seqId = seqId;
	}

	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}

	public String getTellType() {
		return tellType;
	}

	public void setTellType(String tellType) {
		this.tellType = tellType;
	}

	public String getProCode() {
		return proCode;
	}

	public void setProCode(String proCode) {
		this.proCode = proCode;
	}

	public String getFatherSection() {
		return fatherSection;
	}

	public void setFatherSection(String fatherSection) {
		this.fatherSection = fatherSection;
	}

	public String getChildSection() {
		return childSection;
	}

	public void setChildSection(String childSection) {
		this.childSection = childSection;
	}

	public String getKpiId() {
		return kpiId;
	}

	public void setKpiId(String kpiId) {
		this.kpiId = kpiId;
	}

	public String getCheckCycle() {
		return checkCycle;
	}

	public void setCheckCycle(String checkCycle) {
		this.checkCycle = checkCycle;
	}

	public String getReserved1() {
		return reserved1;
	}

	public void setReserved1(String reserved1) {
		this.reserved1 = reserved1;
	}

	public String getReserved2() {
		return reserved2;
	}

	public void setReserved2(String reserved2) {
		this.reserved2 = reserved2;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("seqId=").append(seqId).append("\n");
		sb.append("proviceCode=").append(provinceCode).append("\n");
		sb.append("tellType=").append(tellType).append("\n");
		sb.append("proCode=").append(proCode).append("\n");
		sb.append("fatherSection=").append(fatherSection).append("\n");
		sb.append("childSection=").append(childSection).append("\n");
		sb.append("kpiId=").append(kpiId).append("\n");
		sb.append("reserved1=").append(reserved1).append("\n");
		sb.append("reserved2=").append(reserved2).append("\n");
		sb.append("remark=").append(remark).append("\n");
		return sb.toString();
	}

}
