package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomMaintainItems implements Serializable { 
	private static final long serialVersionUID = 1L;

	private String proCode;
	
	private String funcCode;
	
	private Long hostId;
	
	private Long itemId;
	
	private String itemName;
	
	private String itemDesc;
	
	private String loginNo;

	private String grantLogins;
	
	private Long isGrant;

	private String remark;
	
	public String getProCode() {
		return proCode;
	}
	public void setProCode(String proCode) {
		this.proCode = proCode;
	}
	public String getFuncCode() {
		return funcCode;
	}
	public void setFuncCode(String funcCode) {
		this.funcCode = funcCode;
	}
	public Long getHostId() {
		return hostId;
	}
	public void setHostId(Long hostId) {
		this.hostId = hostId;
	}
	public Long getItemId() {
		return itemId;
	}
	public void setItemId(Long itemId) {
		this.itemId = itemId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemDesc() {
		return itemDesc;
	}
	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}
	public String getLoginNo() {
		return loginNo;
	}
	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}
	public String getGrantLogins() {
		return grantLogins;
	}
	public void setGrantLogins(String grantLogins) {
		this.grantLogins = grantLogins;
	}
	public Long getIsGrant() {
		return isGrant;
	}
	public void setIsGrant(Long isGrant) {
		this.isGrant = isGrant;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("proCode=").append(proCode).append("\n");
		sb.append("funcCode=").append(funcCode).append("\n");
		sb.append("hostId=").append(hostId).append("\n");
		sb.append("itemId=").append(itemId).append("\n");
		sb.append("itemName=").append(itemName).append("\n");
		sb.append("itemDesc=").append(itemDesc).append("\n");
		sb.append("remark=").append(remark).append("\n");
		sb.append("loginNo=").append(loginNo).append("\n");
		sb.append("grantLogins=").append(grantLogins).append("\n");
		sb.append("isGrant=").append(isGrant).append("\n");
		return sb.toString();
	}
	
}