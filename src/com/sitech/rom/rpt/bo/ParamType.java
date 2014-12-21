package com.sitech.rom.rpt.bo;

public class ParamType {
	private int typeid;
	private String name;
	private String datatype;
	private String remarks;
	
	public int getTypeid() {
		return typeid;
	}
	public void setTypeid(int typeid) {
		this.typeid = typeid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDatatype() {
		return datatype;
	}
	public void setDatatype(String datatype) {
		this.datatype = datatype;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public static String getDataTypeList(){
		StringBuffer bf = new StringBuffer();
		bf.append("<option value=\"String\">String</option>");
		bf.append("<option value=\"Long\">Long</option>");
		bf.append("<option value=\"Float\">Float</option>");
		bf.append("<option value=\"Date\">Date</option>");
		return bf.toString();
	}
}
