package com.sitech.rom.common.bo;

public class ProgressBo {
	private static final long serialVersionUID = 1L;
	
	private Long isOwn;
	
	//脚本信息
	private Long scriptsId;
	private Long hostId;
	private String scriptsDir;
	private String scriptsName;
	private String scriptsType;
	private java.util.Date beginTime;
	private java.util.Date beginTimeStart;
	private java.util.Date beginTimeEnd;
	private java.util.Date endTime;
	private java.util.Date endTimeStart;
	private java.util.Date endTimeEnd;
	private Long intervalTime;
	private String reqUrl;
	private String visitUser;
	private String visitPswd;
	private java.util.Date opTime;
	private java.util.Date opTimeStart;
	private java.util.Date opTimeEnd;
	private String opFlag;
	private String opRetncode;
	private String remarks;
	private String beginTimeStr;
	private String endTimeStr;
	
	//主机、运营商信息
	private String hostName;
	private String provinceCode;
	private String hostEnv;
	private String hostIp;
	private String hostOs;	
	private String provinceName;
	private String tellType;
	private String tellName;
	private String proId;
	private String proName;
	private String loginNo;
	
	//进程信息
	private String funcCode;
	private String dataFuncCode;
	private Long itemId;	
	private String itemName;	
	private String itemDesc;
	//工作条目动作
	private Long actionId;
	private String actionName;
	
	private String actionArr;
	
	public Long getIsOwn() {
		return isOwn;
	}

	public void setIsOwn(Long isOwn) {
		this.isOwn = isOwn;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getActionName() {
		return actionName;
	}

	public void setActionName(String actionName) {
		this.actionName = actionName;
	}

	public Long getItemId() {
		return itemId;
	}

	public void setItemId(Long itemId) {
		this.itemId = itemId;
	}

	public Long getActionId() {
		return actionId;
	}

	public void setActionId(Long actionId) {
		this.actionId = actionId;
	}

	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}

	public String getHostEnv() {
		return hostEnv;
	}

	public void setHostEnv(String hostEnv) {
		this.hostEnv = hostEnv;
	}

	public String getHostIp() {
		return hostIp;
	}

	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}

	public String getHostOs() {
		return hostOs;
	}

	public void setHostOs(String hostOs) {
		this.hostOs = hostOs;
	}

	public String getProvinceName() {
		return provinceName;
	}

	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}
 

	public String getTellName() {
		return tellName;
	}

	public void setTellName(String tellName) {
		this.tellName = tellName;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}

	public String getBeginTimeStr() {
		return beginTimeStr;
	}

	public void setBeginTimeStr(String beginTimeStr) {
		this.beginTimeStr = beginTimeStr;
	}

	public String getEndTimeStr() {
		return endTimeStr;
	}

	public void setEndTimeStr(String endTimeStr) {
		this.endTimeStr = endTimeStr;
	}

	public Long getScriptsId() {
		return scriptsId;
	}

	public void setScriptsId(Long scriptsId) {
		this.scriptsId = scriptsId;
	}

	public Long getHostId() {
		return hostId;
	}

	public void setHostId(Long hostId) {
		this.hostId = hostId;
	}

	public String getScriptsDir() {
		return scriptsDir;
	}

	public void setScriptsDir(String scriptsDir) {
		this.scriptsDir = scriptsDir;
	}

	public String getScriptsName() {
		return scriptsName;
	}

	public void setScriptsName(String scriptsName) {
		this.scriptsName = scriptsName;
	}

	public String getScriptsType() {
		return scriptsType;
	}

	public void setScriptsType(String scriptsType) {
		this.scriptsType = scriptsType;
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

	public String getReqUrl() {
		return reqUrl;
	}

	public void setReqUrl(String reqUrl) {
		this.reqUrl = reqUrl;
	}

	public java.util.Date getOpTime() {
		return opTime;
	}

	public void setOpTime(java.util.Date opTime) {
		this.opTime = opTime;
	}

	public java.util.Date getOpTimeStart() {
		return opTimeStart;
	}

	public void setOpTimeStart(java.util.Date opTimeStart) {
		this.opTimeStart = opTimeStart;
	}

	public java.util.Date getOpTimeEnd() {
		return opTimeEnd;
	}

	public void setOpTimeEnd(java.util.Date opTimeEnd) {
		this.opTimeEnd = opTimeEnd;
	}

	public String getOpFlag() {
		return opFlag;
	}

	public void setOpFlag(String opFlag) {
		this.opFlag = opFlag;
	}

	public String getOpRetncode() {
		return opRetncode;
	}

	public void setOpRetncode(String opRetncode) {
		this.opRetncode = opRetncode;
	}

 

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getTellType() {
		return tellType;
	}

	public void setTellType(String tellType) {
		this.tellType = tellType;
	}

	public String getVisitUser() {
		return visitUser;
	}

	public void setVisitUser(String visitUser) {
		this.visitUser = visitUser;
	}

	public String getVisitPswd() {
		return visitPswd;
	}

	public void setVisitPswd(String visitPswd) {
		this.visitPswd = visitPswd;
	}

	public String getFuncCode() {
		return funcCode;
	}

	public void setFuncCode(String funcCode) {
		this.funcCode = funcCode;
	}

	public String getItemDesc() {
		return itemDesc;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}

	public String getHostName() {
		return hostName;
	}

	public void setHostName(String hostName) {
		this.hostName = hostName;
	}

	public String getActionArr() {
		return actionArr;
	}

	public void setActionArr(String actionArr) {
		this.actionArr = actionArr;
	}

	public String getProId() {
		return proId;
	}

	public void setProId(String proId) {
		this.proId = proId;
	}

	public String getDataFuncCode() {
		return dataFuncCode;
	}

	public void setDataFuncCode(String dataFuncCode) {
		this.dataFuncCode = dataFuncCode;
	}

 

	
}
