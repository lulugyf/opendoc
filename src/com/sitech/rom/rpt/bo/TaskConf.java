package com.sitech.rom.rpt.bo;

import java.io.Serializable;

public class TaskConf extends MyBaseBO implements Serializable{

	private int job_id;
	private String job_name;
	private String job_mode;
	private int job_run_freq;
	private String job_run_mode;
	private String job_enable;
	private String job_type;
	private String job_run_time;
	private int h_order_id;
	private String serv_ip;
	private String s_tab;
	private String d_tab;
	private String etl_sql;
	
	private String job_run_time_M;
	private String job_run_time_H;
	private String job_run_time_m;
	private String job_run_time_S;
	
	public int getJob_id() {
		return job_id;
	}
	public void setJob_id(int job_id) {
		this.job_id = job_id;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getJob_mode() {
		return job_mode;
	}
	public void setJob_mode(String job_mode) {
		this.job_mode = job_mode;
	}
	public int getJob_run_freq() {
		return job_run_freq;
	}
	public void setJob_run_freq(int job_run_freq) {
		this.job_run_freq = job_run_freq;
	}
	public String getJob_run_mode() {
		return job_run_mode;
	}
	public void setJob_run_mode(String job_run_mode) {
		this.job_run_mode = job_run_mode;
	}
	public String getJob_enable() {
		return job_enable;
	}
	public void setJob_enable(String job_enable) {
		this.job_enable = job_enable;
	}
	public String getJob_type() {
		return job_type;
	}
	public void setJob_type(String job_type) {
		this.job_type = job_type;
	}
	public String getJob_run_time() {
		return job_run_time;
	}
	public void setJob_run_time(String job_run_time) {
		this.job_run_time = job_run_time;
	}
	public int getH_order_id() {
		return h_order_id;
	}
	public void setH_order_id(int h_order_id) {
		this.h_order_id = h_order_id;
	}
	public String getS_tab() {
		return s_tab;
	}
	public void setS_tab(String s_tab) {
		this.s_tab = s_tab;
	}
	public String getD_tab() {
		return d_tab;
	}
	public void setD_tab(String d_tab) {
		this.d_tab = d_tab;
	}
	public String getEtl_sql() {
		return etl_sql;
	}
	public void setEtl_sql(String etl_sql) {
		this.etl_sql = etl_sql;
	}
	public String getServ_ip() {
		return serv_ip;
	}
	public void setServ_ip(String serv_ip) {
		this.serv_ip = serv_ip;
	}
	public String getJob_run_time_M() {
		return job_run_time_M;
	}
	public void setJob_run_time_M(String job_run_time_M) {
		this.job_run_time_M = job_run_time_M;
	}
	public String getJob_run_time_H() {
		return job_run_time_H;
	}
	public void setJob_run_time_H(String job_run_time_H) {
		this.job_run_time_H = job_run_time_H;
	}
	public String getJob_run_time_m() {
		return job_run_time_m;
	}
	public void setJob_run_time_m(String job_run_time_m) {
		this.job_run_time_m = job_run_time_m;
	}
	public String getJob_run_time_S() {
		return job_run_time_S;
	}
	public void setJob_run_time_S(String job_run_time_S) {
		this.job_run_time_S = job_run_time_S;
	}
	
}
