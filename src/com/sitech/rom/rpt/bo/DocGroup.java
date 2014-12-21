package com.sitech.rom.rpt.bo;

public class DocGroup {
	private String group_func;
	private String group_name;
	private String parent_group;
	
	public String getParent_group() {
		return parent_group;
	}
	public void setParent_group(String parent_group) {
		this.parent_group = parent_group;
	}
	public String getGroup_func() {
		return group_func;
	}
	public void setGroup_func(String group_func) {
		this.group_func = group_func;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
}
