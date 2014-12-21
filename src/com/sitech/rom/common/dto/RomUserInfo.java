package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomUserInfo implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long userId;
	
	private Long hostId;
	
	private String userName;
	
	private String passwd;
	
	private String homeDir;
	
	private String remark;
	

	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getHostId() {
		return hostId;
	}
	public void setHostId(Long hostId) {
		this.hostId = hostId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getHomeDir() {
		return homeDir;
	}
	public void setHomeDir(String homeDir) {
		this.homeDir = homeDir;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("userId=").append(userId).append("\n");
		sb.append("hostId=").append(hostId).append("\n");
		sb.append("userName=").append(userName).append("\n");
		sb.append("passwd=").append(passwd).append("\n");
		sb.append("homeDir=").append(homeDir).append("\n");
		sb.append("remark=").append(remark).append("\n");
		return sb.toString();
	}
	
}