package com.sitech.rom.common.dto;

import java.io.Serializable;

public class CmsWorkOrderSaveRule implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String cellcode;
	private String hlrCode;
	private String saveCode;
	private String useFlag;
	private String remark;
	private String tableName;
	private String tabCount; //查询数据库中表存在的数目
	
	public String getCellcode() {
		return cellcode;
	}

	public void setCellcode(String cellcode) {
		this.cellcode = cellcode;
	}

	public String getHlrCode() {
		return hlrCode;
	}

	public void setHlrCode(String hlrCode) {
		this.hlrCode = hlrCode;
	}

	public String getSaveCode() {
		return saveCode;
	}

	public void setSaveCode(String saveCode) {
		this.saveCode = saveCode;
	}

	public String getUseFlag() {
		return useFlag;
	}

	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
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
	

	public String getTabCount() {
		return tabCount;
	}

	public void setTabCount(String tabCount) {
		this.tabCount = tabCount;
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("cellcode=").append(cellcode).append("\n");
		sb.append("hlrCode=").append(hlrCode).append("\n");
		sb.append("saveCode=").append(saveCode).append("\n");
		sb.append("useFlag=").append(useFlag).append("\n");
		sb.append("remark=").append(remark).append("\n");
		return sb.toString();
	}

}
