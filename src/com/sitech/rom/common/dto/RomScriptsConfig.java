package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomScriptsConfig implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long scriptsId;
	
	private Long hostId;
	
	private String scriptsDir;
	
	private String scriptsName;
	
	private String scriptsType;
	
	private String reqUrl;
	
	private String visitUser;
	
	private String visitPswd;
	
	private String remarks;
	

	public Long getScriptsId() {
		return scriptsId;
	}
	public void setScriptsId(Long scriptsId) {
		this.scriptsId = scriptsId;
	}
	public Long getHostId() {
		return hostId;
	}
	public void setHostId(Long hostId) {
		this.hostId = hostId;
	}
	public String getScriptsDir() {
		return scriptsDir;
	}
	public void setScriptsDir(String scriptsDir) {
		this.scriptsDir = scriptsDir;
	}
	public String getScriptsName() {
		return scriptsName;
	}
	public void setScriptsName(String scriptsName) {
		this.scriptsName = scriptsName;
	}
	public String getScriptsType() {
		return scriptsType;
	}
	public void setScriptsType(String scriptsType) {
		this.scriptsType = scriptsType;
	}
	public String getReqUrl() {
		return reqUrl;
	}
	public void setReqUrl(String reqUrl) {
		this.reqUrl = reqUrl;
	}
	public String getVisitUser() {
		return visitUser;
	}
	public void setVisitUser(String visitUser) {
		this.visitUser = visitUser;
	}
	public String getVisitPswd() {
		return visitPswd;
	}
	public void setVisitPswd(String visitPswd) {
		this.visitPswd = visitPswd;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("scriptsId=").append(scriptsId).append("\n");
		sb.append("hostId=").append(hostId).append("\n");
		sb.append("scriptsDir=").append(scriptsDir).append("\n");
		sb.append("scriptsName=").append(scriptsName).append("\n");
		sb.append("scriptsType=").append(scriptsType).append("\n");
		sb.append("reqUrl=").append(reqUrl).append("\n");
		sb.append("visitUser=").append(visitUser).append("\n");
		sb.append("visitPswd=").append(visitPswd).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		return sb.toString();
	}
	
}