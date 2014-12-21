package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomCronTaskConf implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long taskId;
	
	private String proCode;
	
	private String funcCode;
	
	private Long scriptsId;
	
	private java.util.Date beginTime;
	
	private java.util.Date beginTimeStart;
	
	private java.util.Date beginTimeEnd;
	
	private java.util.Date endTime;
	
	private java.util.Date endTimeStart;
	
	private java.util.Date endTimeEnd;
	
	private Long intervalTime;
	
	private java.util.Date nextRunTime;
	
	private java.util.Date nextRunTimeStart;
	
	private java.util.Date nextRunTimeEnd;
	
	private String taskState;
	
	private String userFlag;
	
	private String remark;
	

	public Long getTaskId() {
		return taskId;
	}
	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}
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
	public Long getScriptsId() {
		return scriptsId;
	}
	public void setScriptsId(Long scriptsId) {
		this.scriptsId = scriptsId;
	}
	public java.util.Date getBeginTime() {
		return beginTime;
	}
	public void setBeginTime(java.util.Date beginTime) {
		this.beginTime = beginTime;
	}
	public java.util.Date getBeginTimeStart() {
		return beginTimeStart;
	}
	public void setBeginTimeStart(java.util.Date beginTimeStart) {
		this.beginTimeStart = beginTimeStart;
	}
	public java.util.Date getBeginTimeEnd() {
		return beginTimeEnd;
	}
	public void setBeginTimeEnd(java.util.Date beginTimeEnd) {
		this.beginTimeEnd = beginTimeEnd;
	}
	public java.util.Date getEndTime() {
		return endTime;
	}
	public void setEndTime(java.util.Date endTime) {
		this.endTime = endTime;
	}
	public java.util.Date getEndTimeStart() {
		return endTimeStart;
	}
	public void setEndTimeStart(java.util.Date endTimeStart) {
		this.endTimeStart = endTimeStart;
	}
	public java.util.Date getEndTimeEnd() {
		return endTimeEnd;
	}
	public void setEndTimeEnd(java.util.Date endTimeEnd) {
		this.endTimeEnd = endTimeEnd;
	}
	public Long getIntervalTime() {
		return intervalTime;
	}
	public void setIntervalTime(Long intervalTime) {
		this.intervalTime = intervalTime;
	}
	public java.util.Date getNextRunTime() {
		return nextRunTime;
	}
	public void setNextRunTime(java.util.Date nextRunTime) {
		this.nextRunTime = nextRunTime;
	}
	public java.util.Date getNextRunTimeStart() {
		return nextRunTimeStart;
	}
	public void setNextRunTimeStart(java.util.Date nextRunTimeStart) {
		this.nextRunTimeStart = nextRunTimeStart;
	}
	public java.util.Date getNextRunTimeEnd() {
		return nextRunTimeEnd;
	}
	public void setNextRunTimeEnd(java.util.Date nextRunTimeEnd) {
		this.nextRunTimeEnd = nextRunTimeEnd;
	}
	public String getTaskState() {
		return taskState;
	}
	public void setTaskState(String taskState) {
		this.taskState = taskState;
	}
	public String getUserFlag() {
		return userFlag;
	}
	public void setUserFlag(String userFlag) {
		this.userFlag = userFlag;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("taskId=").append(taskId).append("\n");
		sb.append("proCode=").append(proCode).append("\n");
		sb.append("funcCode=").append(funcCode).append("\n");
		sb.append("scriptsId=").append(scriptsId).append("\n");
		sb.append("beginTime=").append(beginTime).append("\n");
		sb.append("beginTimeStart=").append(beginTimeStart).append("\n");
		sb.append("beginTimeEnd=").append(beginTimeEnd).append("\n");
		sb.append("endTime=").append(endTime).append("\n");
		sb.append("endTimeStart=").append(endTimeStart).append("\n");
		sb.append("endTimeEnd=").append(endTimeEnd).append("\n");
		sb.append("intervalTime=").append(intervalTime).append("\n");
		sb.append("nextRunTime=").append(nextRunTime).append("\n");
		sb.append("nextRunTimeStart=").append(nextRunTimeStart).append("\n");
		sb.append("nextRunTimeEnd=").append(nextRunTimeEnd).append("\n");
		sb.append("taskState=").append(taskState).append("\n");
		sb.append("userFlag=").append(userFlag).append("\n");
		sb.append("remark=").append(remark).append("\n");
		return sb.toString();
	}
	
}