package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomSysOpLog implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String opDate;
	
	private String opStaff;
	
	private String staffName;
	
	private String proCode;
	
	private String functionCode;
	
	private java.util.Date opTime;
	
	private java.util.Date opTimeStart;
	
	private java.util.Date opTimeEnd;
	
	private String opContent;
	
	private String remarks;
	

	public String getOpDate() {
		return opDate;
	}
	public void setOpDate(String opDate) {
		this.opDate = opDate;
	}
	public String getOpStaff() {
		return opStaff;
	}
	public void setOpStaff(String opStaff) {
		this.opStaff = opStaff;
	}
	public String getStaffName() {
		return staffName;
	}
	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}
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
	public java.util.Date getOpTime() {
		return opTime;
	}
	public void setOpTime(java.util.Date opTime) {
		this.opTime = opTime;
	}
	public java.util.Date getOpTimeStart() {
		return opTimeStart;
	}
	public void setOpTimeStart(java.util.Date opTimeStart) {
		this.opTimeStart = opTimeStart;
	}
	public java.util.Date getOpTimeEnd() {
		return opTimeEnd;
	}
	public void setOpTimeEnd(java.util.Date opTimeEnd) {
		this.opTimeEnd = opTimeEnd;
	}
	public String getOpContent() {
		return opContent;
	}
	public void setOpContent(String opContent) {
		this.opContent = opContent;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("opDate=").append(opDate).append("\n");
		sb.append("opStaff=").append(opStaff).append("\n");
		sb.append("staffName=").append(staffName).append("\n");
		sb.append("proCode=").append(proCode).append("\n");
		sb.append("functionCode=").append(functionCode).append("\n");
		sb.append("opTime=").append(opTime).append("\n");
		sb.append("opTimeStart=").append(opTimeStart).append("\n");
		sb.append("opTimeEnd=").append(opTimeEnd).append("\n");
		sb.append("opContent=").append(opContent).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}