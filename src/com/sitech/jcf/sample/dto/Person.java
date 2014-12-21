package com.sitech.jcf.sample.dto;

import java.io.Serializable;
public class Person implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2362798379291999032L;
	private int id;
	private String name;
	private String add;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}
	public String getAdd() {
		return add;
	}
	public void setAdd(String add) {
		this.add = add;
	}	
	
}
