package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomBusicheckConf implements Serializable {
	
	/**
	 * 
	 */	
	private static final long serialVersionUID = 1L;	

	private Long seqId;
	private Long busiType;
	private Long isGrant;
	private String provinceCode;
	private String tellType;
	private String busiIdentify;
	private String busiName;
	private String checkNodes;
	private String childNode;
	private String hostIp;
	private String userName;
	private String hostDir;
	private String checkLimitValue;
	private String loginNo;
	private String grantLogins;
	private String reserved1;
	private String reserved2;
	private String reserved3;
	private String remark;
	
	
	public Long getSeqId() {
		return seqId;
	}
	public void setSeqId(Long seqId) {
		this.seqId = seqId;
	}
	public Long getBusiType() {
		return busiType;
	}
	public void setBusiType(Long busiType) {
		this.busiType = busiType;
	}
	public Long getIsGrant() {
		return isGrant;
	}
	public void setIsGrant(Long isGrant) {
		this.isGrant = isGrant;
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
	public String getBusiIdentify() {
		return busiIdentify;
	}
	public void setBusiIdentify(String busiIdentify) {
		this.busiIdentify = busiIdentify;
	}
	public String getBusiName() {
		return busiName;
	}
	public void setBusiName(String busiName) {
		this.busiName = busiName;
	}
	public String getCheckNodes() {
		return checkNodes;
	}
	public void setCheckNodes(String checkNodes) {
		this.checkNodes = checkNodes;
	}
	public String getChildNode() {
		return childNode;
	}
	public void setChildNode(String childNode) {
		this.childNode = childNode;
	}
	public String getHostIp() {
		return hostIp;
	}
	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getHostDir() {
		return hostDir;
	}
	public void setHostDir(String hostDir) {
		this.hostDir = hostDir;
	}
	public String getCheckLimitValue() {
		return checkLimitValue;
	}
	public void setCheckLimitValue(String checkLimitValue) {
		this.checkLimitValue = checkLimitValue;
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
	public String getReserved3() {
		return reserved3;
	}
	public void setReserved3(String reserved3) {
		this.reserved3 = reserved3;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
		
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("seqId=").append(seqId).append("\n");
		sb.append("busiType=").append(busiType).append("\n");
		sb.append("isGrant=").append(isGrant).append("\n");
		sb.append("provinceCode=").append(provinceCode).append("\n");
		sb.append("tellType=").append(tellType).append("\n");
		sb.append("busiIdentify=").append(busiIdentify).append("\n");
		sb.append("busiName=").append(busiName).append("\n");
		sb.append("checkNodes=").append(checkNodes).append("\n");
		sb.append("childNode=").append(childNode).append("\n");
		sb.append("hostIp=").append(hostIp).append("\n");
		sb.append("userName=").append(userName).append("\n");
		sb.append("hostDir=").append(hostDir).append("\n");
		sb.append("checkLimitValue=").append(checkLimitValue).append("\n");
		sb.append("loginNo=").append(loginNo).append("\n");
		sb.append("grantLogins=").append(grantLogins).append("\n");
		sb.append("reserved1=").append(reserved1).append("\n");
		sb.append("reserved2=").append(reserved2).append("\n");
		sb.append("reserved3=").append(reserved3).append("\n");
		sb.append("remark=").append(remark).append("\n");
		return sb.toString();
	}
	
	
}
