package com.sitech.rom.common.dto;

import java.io.Serializable;

public class WObspanprovOprAll implements Serializable {
	private static final long serialVersionUID = 1L;

	private String opType;
	private String backFlag;
	private String smCode;
	private String osnduns;
	private String hsnduns;
	private String rspcode;
	private String activitycode;
	private String cutoffday;
	private String phoneNo;
	private String note;
	private String loginNo;
	private String opTime;

	private long loginAccept;
	private long payMoney;

	/////////////////////////////////////////
	private String type;//策略类型
	private int count1;// 用于查询“24小时50次”这样的策略查询中的次数
	private String opFlag;//判断方式，如<>=
	
	
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("opType=").append(opType).append("\n");
		sb.append("backFlag=").append(backFlag).append("\n");
		sb.append("smCode=").append(smCode).append("\n");
		sb.append("osnduns=").append(osnduns).append("\n");
		sb.append("hsnduns=").append(hsnduns).append("\n");
		sb.append("rspcode=").append(rspcode).append("\n");
		sb.append("activitycode=").append(activitycode).append("\n");
		sb.append("cutoffday=").append(cutoffday).append("\n");
		sb.append("phoneNo=").append(phoneNo).append("\n");
		sb.append("note=").append(note).append("\n");
		sb.append("loginNo=").append(loginNo).append("\n");
		sb.append("opTime=").append(opTime).append("\n");
		sb.append("loginAccept=").append(loginAccept).append("\n");
		sb.append("payMoney=").append(payMoney).append("\n");
		sb.append("count1=").append(count1).append("\n");
		sb.append("type=").append(type).append("\n");
		sb.append("opFlag=").append(opFlag).append("\n");

		return sb.toString();
	}

	public String getOpType() {
		return opType;
	}

	public void setOpType(String opType) {
		this.opType = opType;
	}

	public String getBackFlag() {
		return backFlag;
	}

	public void setBackFlag(String backFlag) {
		this.backFlag = backFlag;
	}

	public String getSmCode() {
		return smCode;
	}

	public void setSmCode(String smCode) {
		this.smCode = smCode;
	}

	public String getOsnduns() {
		return osnduns;
	}

	public void setOsnduns(String osnduns) {
		this.osnduns = osnduns;
	}

	public String getHsnduns() {
		return hsnduns;
	}

	public void setHsnduns(String hsnduns) {
		this.hsnduns = hsnduns;
	}

	public String getRspcode() {
		return rspcode;
	}

	public void setRspcode(String rspcode) {
		this.rspcode = rspcode;
	}

	public String getActivitycode() {
		return activitycode;
	}

	public void setActivitycode(String activitycode) {
		this.activitycode = activitycode;
	}

	public String getCutoffday() {
		return cutoffday;
	}

	public void setCutoffday(String cutoffday) {
		this.cutoffday = cutoffday;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public long getLoginAccept() {
		return loginAccept;
	}

	public void setLoginAccept(long loginAccept) {
		this.loginAccept = loginAccept;
	}

	public long getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(long payMoney) {
		this.payMoney = payMoney;
	}

	public int getCount1() {
		return count1;
	}

	public void setCount1(int count1) {
		this.count1 = count1;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getOpFlag() {
		return opFlag;
	}

	public void setOpFlag(String opFlag) {
		this.opFlag = opFlag;
	}

}
