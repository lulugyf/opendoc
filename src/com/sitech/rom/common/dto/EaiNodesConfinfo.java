package com.sitech.rom.common.dto;

import java.io.Serializable;

public class EaiNodesConfinfo implements Serializable { 
	private static final long serialVersionUID = 1L;

	private Long nodeId;
	
	private Long nodeFlag;
	
	private String nodeName;
	
	private String nodeDesc;
	
	private String reserve1;
	
	private String reserve2;
	

	public Long getNodeId() {
		return nodeId;
	}
	public void setNodeId(Long nodeId) {
		this.nodeId = nodeId;
	}
	public Long getNodeFlag() {
		return nodeFlag;
	}
	public void setNodeFlag(Long nodeFlag) {
		this.nodeFlag = nodeFlag;
	}
	public String getNodeName() {
		return nodeName;
	}
	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}
	public String getNodeDesc() {
		return nodeDesc;
	}
	public void setNodeDesc(String nodeDesc) {
		this.nodeDesc = nodeDesc;
	}
	public String getReserve1() {
		return reserve1;
	}
	public void setReserve1(String reserve1) {
		this.reserve1 = reserve1;
	}
	public String getReserve2() {
		return reserve2;
	}
	public void setReserve2(String reserve2) {
		this.reserve2 = reserve2;
	}
	
	public String toString(){
		StringBuffer sb =  new StringBuffer();
		sb.append("nodeId=").append(nodeId).append("\n");
		sb.append("nodeFlag=").append(nodeFlag).append("\n");
		sb.append("nodeName=").append(nodeName).append("\n");
		sb.append("nodeDesc=").append(nodeDesc).append("\n");
		sb.append("reserve1=").append(reserve1).append("\n");
		sb.append("reserve2=").append(reserve2).append("\n");
		return sb.toString();
	}
	
}