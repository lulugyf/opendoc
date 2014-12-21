<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>新增分组配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="groupForm">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
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
						<th><font color="red">*分组名称：</font></th>
						<td>
							<input type="text" name="groupName" id="groupName" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
					</tr>
					<tr>
						<th><font color="red">*是否默认：</font></th>
						<td>
							<input type="radio" name="isdefault" value="0" checked="true" />否
 							<input type="radio" name="isdefault" value="1" />是
						</td>
					</tr>
					<tr>
						<th>备注：</th>
						<td>
							<input type="text" name="remarks" id="remarks" class="isCharLengthOf" v_maxlength="256" v_minlength="0"/>
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="addTransGroup()" class="b_foot" value="确定" />
				<input type="reset" name="re" onClick="javascript:document.forms('groupForm').reset();" class="b_foot" value="重置" />
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

function addTransGroup(){
    if(!checksubmit(groupForm)){
		return false;
	}
	
	if($("#hostId").val()==""){
		alert("请进行主机选择！");
		return false;
	}
	
	var packet = new AJAXPacket("<%=request.getContextPath()%>/addTransGroup.do");
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,$('#provinceCode').val());
	packet.data.add("tellType" ,$('#tellType').val());
	packet.data.add("hostId" ,$('#hostId').val());
	packet.data.add("hostName" ,$('#hostName').val());
	packet.data.add("groupName" ,$('#groupName').val());
	packet.data.add("isdefault" ,$("input[name='isdefault']:checked").val());
	packet.data.add("remarks" ,$('#remarks').val());
	core.ajax.sendPacket(packet,doAddRow);
	packet =null;
	
}

function doAddRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    $('#succInfo').html("分组新增成功！");
  	}else if(retCode=='2'){
  	    $('#succInfo').html("分组名称已经存在，请重新填写！");
  	}else if(retCode=='3'){
  	    $('#succInfo').html("默认分组已经存在，请重新填写！");
  	}else if(retCode=='noright'){
  	    $('#succInfo').html("您没有权限进行此操作！");
  	}else{
  	    $('#succInfo').html("分组新增失败！");
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

</script>
</body>
</html>