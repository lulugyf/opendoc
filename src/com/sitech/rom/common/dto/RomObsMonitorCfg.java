package com.sitech.rom.common.dto;

import java.io.Serializable;

public class RomObsMonitorCfg implements Serializable {
	private static final long serialVersionUID = 1L;

	private long id;
	private long type;
	private String name;
	private String remark;
	private long opType;//操作类型，取值为：>、<、=
	private long defaultValue;//默认判断值

	private String provinceCode;
	private String provinceName;
	private String tellType;
	private String tellcorpName;

	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}

	public String getTellType() {
		return tellType;
	}

	public void setTellType(String tellType) {
		this.tellType = tellType;
	}

	public String getProvinceName() {
		return provinceName;
	}

	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	public String getTellcorpName() {
		return tellcorpName;
	}

	public void setTellcorpName(String tellcorpName) {
		this.tellcorpName = tellcorpName;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getType() {
		return type;
	}

	public void setType(long type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public long getOpType() {
		return opType;
	}

	public void setOpType(long opType) {
		this.opType = opType;
	}
	
	public long getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(long defaultValue) {
		this.defaultValue = defaultValue;
	}
	
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("id=").append(id).append("\n");
		sb.append("type=").append(type).append("\n");
		sb.append("name=").append(name).append("\n");
		sb.append("opType=").append(opType).append("\n");
		sb.append("defaultValue=").append(defaultValue).append("\n");
		sb.append("remark").append(remark).append("\n");		
		sb.append("provinceCode=").append(provinceCode).append("\n");
		sb.append("provinceName=").append(provinceName).append("\n");
		sb.append("tellType=").append(tellType).append("\n");
		sb.append("tellcorpName=").append(tellcorpName).append("\n");
		return sb.toString();
	}




}
