package com.sitech.rom.common.dto;

import java.io.Serializable;

public class EaiNodesInstance implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long instanceId;
	
	private String section;
	
	private String itemName;
	
	private String itemValue;
	
	private Long itemSeq;
	
	private String reserve1;
	
	private String reserve2;
	

	public Long getInstanceId() {
		return instanceId;
	}
	public void setInstanceId(Long instanceId) {
		this.instanceId = instanceId;
	}
	public String getSection() {
		return section;
	}
	public void setSection(String section) {
		this.section = section;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public String getItemValue() {
		return itemValue;
	}
	public void setItemValue(String itemValue) {
		this.itemValue = itemValue;
	}
	public Long getItemSeq() {
		return itemSeq;
	}
	public void setItemSeq(Long itemSeq) {
		this.itemSeq = itemSeq;
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
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("instanceId=").append(instanceId).append("\n");
		sb.append("section=").append(section).append("\n");
		sb.append("itemName=").append(itemName).append("\n");
		sb.append("itemValue=").append(itemValue).append("\n");
		sb.append("itemSeq=").append(itemSeq).append("\n");
		sb.append("reserve1=").append(reserve1).append("\n");
		sb.append("reserve2=").append(reserve2).append("\n");
		return sb.toString();
	}
	
}