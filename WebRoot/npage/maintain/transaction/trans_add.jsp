<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>新增业务配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="transForm">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
			<input type=hidden name="dataFuncCode" id="dataFuncCode" value="<%=request.getParameter("dataFuncCode")%>">
			<div class="input">
				<table>
 					<tr>
 						<th><font color="red">*主机：</font></th>
						<td>
							<input type="text" name="hostName" id="hostName" class="required" readonly="readonly" />
							<input type="hidden" name="hostId" id="hostId" >
							<input type="button" name="choiceButton" onClick="choiceHostInfo();" class="b_foot" value="选择主机" />
						</td>
 					</tr>
					<tr>
						<th><font color="red">*业务功能代码：</font></th>
						<td>
							<input type="text" name="busiCode" id="busiCode" class="required" readonly="readonly"/>
							<input type="hidden" name="itemId" id="itemId" >
							<input type="button" name="choiceButton" onClick="choiceItemInfo()" class="b_foot" value="选择业务" />
						</td>
					</tr>
					<tr>
						<th><font color="red">*交易代码：</font></th>
						<td>
							<input type="text" name="transCode" id="transCode" class="required isCharLengthOf" v_maxlength="10" v_minlength="0"/>
						</td>
					</tr>
					<tr>
						<th><font color="red">*交易名称：</font></th>
						<td>
							<input type="text" name="transName" id="transName" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="addTransaction()" class="b_foot" value="确定" />
				<input type="reset" name="re" onClick="javascript:document.forms('transForm').reset();" class="b_foot" value="重置" />
				<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
			</div>
			<div align="center">
			    <font color="red"><span id="succInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>
$(document).ready(function () {
	
	//关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSrchSubmit();
	    }catch(e){}
	});
});

function addTransaction(){
    if(!checksubmit(transForm)){
		return false;
	}
	
	if($("#hostId").val()==""){
		alert("请进行主机选择！");
		return false;
	}
	
	var packet = new AJAXPacket("<%=request.getContextPath()%>/addTransaction.do");
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,$('#provinceCode').val());
	packet.data.add("tellType" ,$('#tellType').val());
	packet.data.add("dataFuncCode" ,$('#dataFuncCode').val());
	packet.data.add("itemId" ,$('#itemId').val());
	packet.data.add("transCode" ,$('#transCode').val());
	packet.data.add("transName" ,$('#transName').val());
	packet.data.add("hostName" ,$('#hostName').val());
	packet.data.add("busiCode" ,$('#busiCode').val());
	core.ajax.sendPacket(packet,doAddRow);
	packet =null;
	
}

function doAddRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    $('#succInfo').html("交易节点新增成功！");
  	}else if(retCode=='2'){
  	    $('#succInfo').html("该业务功能代码对应的交易代码已经存在，新增失败！");
  	}else if(retCode=='noright'){
  	    $('#succInfo').html("您没有权限进行此操作！");
  	}else{
  	    $('#succInfo').html("交易节点新增失败！");
  	}
}
function choiceHostInfo(){
	var qryPara="proId=<%=proId%>&opCode=<%=opCode%>&provinceCode="+$('#provinceCode').val()+'&tellType='+$('#tellType').val();
	openDivWin("<%=request.getContextPath()%>/gotoQryHostInfo.do?"+qryPara,"查询主机信息","700","300");
}

function setHost(hostId,hostInfo){
	$("#hostName").val(hostInfo);
	$("#hostId").val(hostId);
}

function choiceItemInfo(){
	var proId=$("#proId").val();
	var opCode=$("#opCode").val();
	var provinceCode=$("#provinceCode").val();
	var tellType=$("#tellType").val();
	var hostId=$("#hostId").val();
	var dataFuncCode=$("#dataFuncCode").val();
	if(hostId==""){
		alert("请先进行主机选择！");
		return false;
	}	
	var qryPara="hostId="+hostId
	+"&proId="+proId
	+"&opCode="+opCode
	+"&provinceCode="+provinceCode
	+"&tellType="+tellType
	+"&dataFuncCode="+dataFuncCode;
	openDivWin("<%=request.getContextPath()%>/getItemInfoList.do?"+qryPara,"查询业务信息","700","300");
}

function setItem(itemId,itemName){
	$("#itemId").val(itemId);
	$("#busiCode").val(itemName);
}
</script>
</body>
</html>