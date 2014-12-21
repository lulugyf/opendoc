package com.sitech.rom.common.dto;

import java.io.Serializable;
import java.util.Date;

public class WSndCmdDay implements Serializable {
	private static final long serialVersionUID = 1L;

	private String ackCode;
	private String ackInfo;
	private String ackTime;
	private String belongCode;
	private String businessStatus;
	private String commandCode;
	private Long commandId;
	private Long commandOrder;
	private String crmOrderId;
	private String fromId;
	private String groupId;
	private String hlrCode;
	private Long idNo;
	private String imsiNo;
	private String loginAccept;
	private String loginNo;
	private String newImsi;
	private String newPhone;
	private String opCode;
	private String opTime;
	private String orgCode;
	private String orgId;
	private String otherChar;
	private String phoneNo;
	private String requestTime;
	private String sendStatus;
	private String sendTime;
	private String smCode;
	private Long totalDate;
	
	//工单统计查询
	private Long totalNum;
	private Long succNum;
	private Long failNum;
	private Date opTimeStart;
	private Date opTimeEnd;
	private String tableName;
	private Double suceccPerc;
	private Double failPerc;
	
	//工单明细查询,flag 用于查询工单选择状态，0，表示成功，1. 表示失败
	private String flag; 
	
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("ackCode=").append(ackCode).append("\n");
		sb.append("ackInfo=").append(ackInfo).append("\n");
		sb.append("ackTime=").append(ackTime).append("\n");
		sb.append("belongCode=").append(belongCode).append("\n");
		sb.append("businessStatus=").append(businessStatus).append("\n");
		sb.append("commandCode=").append(commandCode).append("\n");
		sb.append("commandId=").append(commandId).append("\n");
		sb.append("commandOrder=").append(commandOrder).append("\n");
		sb.append("crmOrderId=").append(crmOrderId).append("\n");
		sb.append("fromId=").append(fromId).append("\n");
		sb.append("groupId=").append(groupId).append("\n");
		sb.append("hlrCode=").append(hlrCode).append("\n");
		sb.append("idNo=").append(idNo).append("\n");
		sb.append("imsiNo=").append(imsiNo).append("\n");
		sb.append("loginAccept=").append(loginAccept).append("\n");
		sb.append("loginNo=").append(loginNo).append("\n");
		sb.append("newImsi=").append(newImsi).append("\n");
		sb.append("newPhone=").append(newPhone).append("\n");
		sb.append("opCode=").append(opCode).append("\n");
		sb.append("opTime=").append(opTime).append("\n");
		sb.append("orgCode=").append(orgCode).append("\n");
		sb.append("orgId=").append(orgId).append("\n");
		sb.append("otherChar=").append(otherChar).append("\n");
		sb.append("phoneNo=").append(phoneNo).append("\n");
		sb.append("requestTime=").append(requestTime).append("\n");
		sb.append("sendStatus=").append(sendStatus).append("\n");
		sb.append("sendTime=").append(sendTime).append("\n");
		sb.append("smCode=").append(smCode).append("\n");
		sb.append("totalDate=").append(totalDate).append("\n");
		sb.append("totalNum=").append(totalNum).append("\n");
		sb.append("succNum=").append(succNum).append("\n");
		sb.append("failNum=").append(failNum).append("\n");
		sb.append("opTimeStart=").append(opTimeStart).append("\n");
		sb.append("opTimeEnd=").append(opTimeEnd).append("\n");

		return sb.toString();
	}

	public String getAckCode() {
		return ackCode;
	}

	public void setAckCode(String ackCode) {
		this.ackCode = ackCode;
	}

	public String getAckInfo() {
		return ackInfo;
	}

	public void setAckInfo(String ackInfo) {
		this.ackInfo = ackInfo;
	}

	public String getAckTime() {
		return ackTime;
	}

	public void setAckTime(String ackTime) {
		this.ackTime = ackTime;
	}

	public String getBelongCode() {
		return belongCode;
	}

	public void setBelongCode(String belongCode) {
		this.belongCode = belongCode;
	}

	public String getBusinessStatus() {
		return businessStatus;
	}

	public void setBusinessStatus(String businessStatus) {
		this.businessStatus = businessStatus;
	}

	public String getCommandCode() {
		return commandCode;
	}

	public void setCommandCode(String commandCode) {
		this.commandCode = commandCode;
	}

	public Long getCommandId() {
		return commandId;
	}

	public void setCommandId(Long commandId) {
		this.commandId = commandId;
	}

	public Long getCommandOrder() {
		return commandOrder;
	}

	public void setCommandOrder(Long commandOrder) {
		this.commandOrder = commandOrder;
	}

	public String getCrmOrderId() {
		return crmOrderId;
	}

	public void setCrmOrderId(String crmOrderId) {
		this.crmOrderId = crmOrderId;
	}

	public String getFromId() {
		return fromId;
	}

	public void setFromId(String fromId) {
		this.fromId = fromId;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getHlrCode() {
		return hlrCode;
	}

	public void setHlrCode(String hlrCode) {
		this.hlrCode = hlrCode;
	}

	public Long getIdNo() {
		return idNo;
	}

	public void setIdNo(Long idNo) {
		this.idNo = idNo;
	}

	public String getImsiNo() {
		return imsiNo;
	}

	public void setImsiNo(String imsiNo) {
		this.imsiNo = imsiNo;
	}

	public String getLoginAccept() {
		return loginAccept;
	}

	public void setLoginAccept(String loginAccept) {
		this.loginAccept = loginAccept;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getNewImsi() {
		return newImsi;
	}

	public void setNewImsi(String newImsi) {
		this.newImsi = newImsi;
	}

	public String getNewPhone() {
		return newPhone;
	}

	public void setNewPhone(String newPhone) {
		this.newPhone = newPhone;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}

	public String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getOtherChar() {
		return otherChar;
	}

	public void setOtherChar(String otherChar) {
		this.otherChar = otherChar;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getRequestTime() {
		return requestTime;
	}

	public void setRequestTime(String requestTime) {
		this.requestTime = requestTime;
	}

	public String getSendStatus() {
		return sendStatus;
	}

	public void setSendStatus(String sendStatus) {
		this.sendStatus = sendStatus;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public String getSmCode() {
		return smCode;
	}

	public void setSmCode(String smCode) {
		this.smCode = smCode;
	}

	public Long getTotalDate() {
		return totalDate;
	}

	public void setTotalDate(Long totalDate) {
		this.totalDate = totalDate;
	}

	public Long getTotalNum() {
		return totalNum;
	}

	public void setTotalNum(Long totalNum) {
		this.totalNum = totalNum;
	}

	public Long getSuccNum() {
		return succNum;
	}

	public void setSuccNum(Long succNum) {
		this.succNum = succNum;
	}

	public Long getFailNum() {
		return failNum;
	}

	public void setFailNum(Long failNum) {
		this.failNum = failNum;
	}

	public Date getOpTimeStart() {
		return opTimeStart;
	}

	public void setOpTimeStart(Date opTimeStart) {
		this.opTimeStart = opTimeStart;
	}

	public Date getOpTimeEnd() {
		return opTimeEnd;
	}

	public void setOpTimeEnd(Date opTimeEnd) {
		this.opTimeEnd = opTimeEnd;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public Double getSuceccPerc() {
		return suceccPerc;
	}

	public void setSuceccPerc(Double suceccPerc) {
		this.suceccPerc = suceccPerc;
	}

	public Double getFailPerc() {
		return failPerc;
	}

	public void setFailPerc(Double failPerc) {
		this.failPerc = failPerc;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	
}
