package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomNetCell implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long cellId;
	
	private String provinceCode;
	private String provinceName;	
	private String tellType;
	private String tellcorpName;
	
	private String cellCode;
	private String cellName;
	private String hlrCode;
	private String ipAddr;
	private int port;
	private String useFlag;
	private String reserved1;
	private String reserved2;
	private String remark;
	
	
	
	
	public String getCellCode() {
		return cellCode;
	}
	public void setCellCode(String cellCode) {
		this.cellCode = cellCode;
	}
	public String getCellName() {
		return cellName;
	}
	public void setCellName(String cellName) {
		this.cellName = cellName;
	}
	public String getHlrCode() {
		return hlrCode;
	}
	public void setHlrCode(String hlrCode) {
		this.hlrCode = hlrCode;
	}
	public String getIpAddr() {
		return ipAddr;
	}
	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}
	public int getPort() {
		return port;
	}
	public void setPort(int port) {
		this.port = port;
	}
	public String getUseFlag() {
		return useFlag;
	}
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
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
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}
	public String getTellcorpName() {
		return tellcorpName;
	}
	public void setTellcorpName(String tellcorpName) {
		this.tellcorpName = tellcorpName;
	}
	public long getCellId() {
		return cellId;
	}
	public void setCellId(long cellId) {
		this.cellId = cellId;
	}
	
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("cellId=").append(cellId).append("\n");
		sb.append("provinceCode=").append(provinceCode).append("\n");
		sb.append("provinceName=").append(provinceName).append("\n");
		sb.append("tellType=").append(tellType).append("\n");
		sb.append("tellcorpName=").append(tellcorpName).append("\n");
		sb.append("cellCode=").append(cellCode).append("\n");
		sb.append("cellName=").append(cellName).append("\n");
		sb.append("hlrCode=").append(hlrCode).append("\n");
		sb.append("ipAddr=").append(ipAddr).append("\n");
		sb.append("port=").append(port).append("\n");
		sb.append("useFlag=").append(useFlag).append("\n");
		sb.append("reserved1=").append(reserved1).append("\n");
		sb.append("reserved2=").append(reserved2).append("\n");
		sb.append("remark=").append(remark).append("\n");
		return sb.toString();
	}


	
	
}
