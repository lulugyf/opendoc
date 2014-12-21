package com.sitech.rom.common.dto;

import java.io.Serializable;

public class EaiBusAdaptRelation implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long busId;
	
	private Long adaptId;
	
	private String inFlag;
	
	private Long appid;
	
	private String transcode;
	
	private Long serverCount;
	
	private String reserver1;
	
	private String reserver2;
	

	public Long getBusId() {
		return busId;
	}
	public void setBusId(Long busId) {
		this.busId = busId;
	}
	public Long getAdaptId() {
		return adaptId;
	}
	public void setAdaptId(Long adaptId) {
		this.adaptId = adaptId;
	}
	public String getInFlag() {
		return inFlag;
	}
	public void setInFlag(String inFlag) {
		this.inFlag = inFlag;
	}
	public Long getAppid() {
		return appid;
	}
	public void setAppid(Long appid) {
		this.appid = appid;
	}
	public String getTranscode() {
		return transcode;
	}
	public void setTranscode(String transcode) {
		this.transcode = transcode;
	}
	public Long getServerCount() {
		return serverCount;
	}
	public void setServerCount(Long serverCount) {
		this.serverCount = serverCount;
	}
	public String getReserver1() {
		return reserver1;
	}
	public void setReserver1(String reserver1) {
		this.reserver1 = reserver1;
	}
	public String getReserver2() {
		return reserver2;
	}
	public void setReserver2(String reserver2) {
		this.reserver2 = reserver2;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("busId=").append(busId).append("\n");
		sb.append("adaptId=").append(adaptId).append("\n");
		sb.append("inFlag=").append(inFlag).append("\n");
		sb.append("appid=").append(appid).append("\n");
		sb.append("transcode=").append(transcode).append("\n");
		sb.append("serverCount=").append(serverCount).append("\n");
		sb.append("reserver1=").append(reserver1).append("\n");
		sb.append("reserver2=").append(reserver2).append("\n");
		return sb.toString();
	}
	
}