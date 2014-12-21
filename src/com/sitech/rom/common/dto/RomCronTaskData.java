package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomCronTaskData implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long taskId;
	
	private java.util.Date createDate;
	
	private java.util.Date createDateStart;
	
	private java.util.Date createDateEnd;
	
	private String itemName;
	
	private String itemDesc;
	
	private String itemData;
	
	private String itemDimension;
	
	private String remark;
	
	//端口监控需要的参数
	private String portStatus;//端口状态
	private int delayedNum;//积压指令数
	private int errorNum;//错误指令数
	
	

	public Long getTaskId() {
		return taskId;
	}
	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}
	public java.util.Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(java.util.Date createDate) {
		this.createDate = createDate;
	}
	public java.util.Date getCreateDateStart() {
		return createDateStart;
	}
	public void setCreateDateStart(java.util.Date createDateStart) {
		this.createDateStart = createDateStart;
	}
	public java.util.Date getCreateDateEnd() {
		return createDateEnd;
	}
	public void setCreateDateEnd(java.util.Date createDateEnd) {
		this.createDateEnd = createDateEnd;
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
	public String getItemData() {
		return itemData;
	}
	public void setItemData(String itemData) {
		this.itemData = itemData;
	}
	public String getItemDimension() {
		return itemDimension;
	}
	public void setItemDimension(String itemDimension) {
		this.itemDimension = itemDimension;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getPortStatus() {
		return portStatus;
	}
	public void setPortStatus(String portStatus) {
		this.portStatus = portStatus;
	}
	public int getDelayedNum() {
		return delayedNum;
	}
	public void setDelayedNum(int delayedNum) {
		this.delayedNum = delayedNum;
	}
	public int getErrorNum() {
		return errorNum;
	}
	public void setErrorNum(int errorNum) {
		this.errorNum = errorNum;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("taskId=").append(taskId).append("\n");
		sb.append("createDate=").append(createDate).append("\n");
		sb.append("createDateStart=").append(createDateStart).append("\n");
		sb.append("createDateEnd=").append(createDateEnd).append("\n");
		sb.append("itemName=").append(itemName).append("\n");
		sb.append("itemDesc=").append(itemDesc).append("\n");
		sb.append("itemData=").append(itemData).append("\n");
		sb.append("itemDimension=").append(itemDimension).append("\n");
		sb.append("remark=").append(remark).append("\n");
		sb.append("portStatus=").append(portStatus).append("\n");
		sb.append("delayedNum=").append(delayedNum).append("\n");
		sb.append("errorNum=").append(errorNum).append("\n");
		return sb.toString();
	}
	
}