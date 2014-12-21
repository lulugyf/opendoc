package com.sitech.rom.common.dto;

import java.io.Serializable;

public class EaiBusiConfInstance implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long busiId;
	
	private Long nodeId;
	
	private Long instanceId;
	
	private Long seq;

	private String staticFlag;
	
	private String endFlag;
	
	public Long getBusiId() {
		return busiId;
	}

	public void setBusiId(Long busiId) {
		this.busiId = busiId;
	}

	public Long getNodeId() {
		return nodeId;
	}

	public void setNodeId(Long nodeId) {
		this.nodeId = nodeId;
	}

	public Long getInstanceId() {
		return instanceId;
	}

	public void setInstanceId(Long instanceId) {
		this.instanceId = instanceId;
	}

	public Long getSeq() {
		return seq;
	}

	public void setSeq(Long seq) {
		this.seq = seq;
	}

	public String getStaticFlag() {
		return staticFlag;
	}

	public void setStaticFlag(String staticFlag) {
		this.staticFlag = staticFlag;
	}

	public String getEndFlag() {
		return endFlag;
	}

	public void setEndFlag(String endFlag) {
		this.endFlag = endFlag;
	}

	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("busiId=").append(busiId).append("\n");
		sb.append("seq=").append(seq).append("\n");
		sb.append("instanceId=").append(instanceId).append("\n");
		sb.append("endFlag=").append(endFlag).append("\n");
		return sb.toString();
	}
	
}