package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomFtpsitesInfo implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long siteId;
	
	private String siteName;
	
	private Long hostId;
	
	private Long ftpPort;
	
	private String ftpUser;
	
	private String ftpPasswd;
	
	private String localPath;
	
	private String remotePath;
	
	private String agentAddr;
	
	private Long sslFlag;
	
	private String remarks;

	private String loginNo;

	private String grantLogins;
	
	private Long isGrant;

	public Long getSiteId() {
		return siteId;
	}
	public void setSiteId(Long siteId) {
		this.siteId = siteId;
	}
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public Long getHostId() {
		return hostId;
	}
	public void setHostId(Long hostId) {
		this.hostId = hostId;
	}
	public Long getFtpPort() {
		return ftpPort;
	}
	public void setFtpPort(Long ftpPort) {
		this.ftpPort = ftpPort;
	}
	public String getFtpUser() {
		return ftpUser;
	}
	public void setFtpUser(String ftpUser) {
		this.ftpUser = ftpUser;
	}
	public String getFtpPasswd() {
		return ftpPasswd;
	}
	public void setFtpPasswd(String ftpPasswd) {
		this.ftpPasswd = ftpPasswd;
	}
	public String getLocalPath() {
		return localPath;
	}
	public void setLocalPath(String localPath) {
		this.localPath = localPath;
	}
	public String getRemotePath() {
		return remotePath;
	}
	public void setRemotePath(String remotePath) {
		this.remotePath = remotePath;
	}
	public String getAgentAddr() {
		return agentAddr;
	}
	public void setAgentAddr(String agentAddr) {
		this.agentAddr = agentAddr;
	}
	public Long getSslFlag() {
		return sslFlag;
	}
	public void setSslFlag(Long sslFlag) {
		this.sslFlag = sslFlag;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
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
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("siteId=").append(siteId).append("\n");
		sb.append("siteName=").append(siteName).append("\n");
		sb.append("hostId=").append(hostId).append("\n");
		sb.append("ftpPort=").append(ftpPort).append("\n");
		sb.append("ftpUser=").append(ftpUser).append("\n");
		sb.append("ftpPasswd=").append(ftpPasswd).append("\n");
		sb.append("localPath=").append(localPath).append("\n");
		sb.append("remotePath=").append(remotePath).append("\n");
		sb.append("agentAddr=").append(agentAddr).append("\n");
		sb.append("sslFlag=").append(sslFlag).append("\n");
		sb.append("remarks=").append(remarks).append("\n");
		sb.append("loginNo=").append(loginNo).append("\n");
		sb.append("grantLogins=").append(grantLogins).append("\n");
		sb.append("isGrant=").append(isGrant).append("\n");
		return sb.toString();
	}
	
}