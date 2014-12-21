package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomExpandInfo implements Serializable {


	private static final long serialVersionUID = 1L;

	private long expandId = 0l;
	private long recordId = 0l;
	private String propertyKey;
	private String propertyValue;
	private int propertyOrder;		
	private String remark;
	
	private String tableName;
	
	
	public long getExpandId() {
		return expandId;
	}
	public void setExpandId(long expandId) {
		this.expandId = expandId;
	}
	public long getRecordId() {
		return recordId;
	}
	public void setRecordId(long recordId) {
		this.recordId = recordId;
	}
	public String getPropertyKey() {
		return propertyKey;
	}
	public void setPropertyKey(String propertyKey) {
		this.propertyKey = propertyKey;
	}
	public String getPropertyValue() {
		return propertyValue;
	}
	public void setPropertyValue(String propertyValue) {
		this.propertyValue = propertyValue;
	}
	public int getPropertyOrder() {
		return propertyOrder;
	}
	public void setPropertyOrder(int propertyOrder) {
		this.propertyOrder = propertyOrder;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("expandId=").append(expandId).append("\n");
		sb.append("recordId=").append(recordId).append("\n");
		sb.append("propertyKey=").append(propertyKey).append("\n");
		sb.append("propertyValue=").append(propertyValue).append("\n");
		sb.append("remark=").append(remark).append("\n");
		sb.append("tableName=").append(tableName).append("\n");

		return sb.toString();
	}

	
}
