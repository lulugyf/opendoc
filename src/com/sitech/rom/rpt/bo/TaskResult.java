package com.sitech.rom.rpt.bo;

import java.io.Serializable;

public class TaskResult extends MyBaseBO implements Serializable{
	private String job_seq;
	private String op_date;
	private int job_id;
	private String job_name;
	private String start_time;
	private String end_time;
	private String run_status;
	private String run_msg;
	public String getJob_seq() {
		return job_seq;
	}
	public void setJob_seq(String job_seq) {
		this.job_seq = job_seq;
	}
	public String getOp_date() {
		return op_date;
	}
	public void setOp_date(String op_date) {
		this.op_date = op_date;
	}
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
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getRun_status() {
		return run_status;
	}
	public void setRun_status(String run_status) {
		this.run_status = run_status;
	}
	public String getRun_msg() {
		return run_msg;
	}
	public void setRun_msg(String run_msg) {
		this.run_msg = run_msg;
	}
	
}
