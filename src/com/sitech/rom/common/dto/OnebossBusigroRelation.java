package com.sitech.rom.common.dto;

import java.io.Serializable;

public class OnebossBusigroRelation implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long groupId;
	
	private Long transId;
	
	private String reserve1;
	
	private String reserve2;
	
	private String reserve3;
	

	public Long getGroupId() {
		return groupId;
	}
	public void setGroupId(Long groupId) {
		this.groupId = groupId;
	}
	public Long getTransId() {
		return transId;
	}
	public void setTransId(Long transId) {
		this.transId = transId;
	}
	public String getReserve1() {
		return reserve1;
	}
	public void setReserve1(String reserve1) {
		this.reserve1 = reserve1;
	}
	public String getReserve2() {
		return reserve2;
	}
	public void setReserve2(String reserve2) {
		this.reserve2 = reserve2;
	}
	public String getReserve3() {
		return reserve3;
	}
	public void setReserve3(String reserve3) {
		this.reserve3 = reserve3;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("groupId=").append(groupId).append("\n");
		sb.append("transId=").append(transId).append("\n");
		sb.append("reserve1=").append(reserve1).append("\n");
		sb.append("reserve2=").append(reserve2).append("\n");
		sb.append("reserve3=").append(reserve3).append("\n");
		return sb.toString();
	}
	
}