<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>新增主机用户信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">

			<div class="input">
				<table>
 				
 					<tr>
 						<th><font color="red">*主机：</font></th>
						<td>
							<input type="text" name="hostName" id="hostName" class="" readonly="readonly" />
							<input type=hidden name="hostId" id="hostId" >
							<input type="button" name="choiceButton" onClick="choiceHostInfo();" class="b_foot" value="选择主机" />
						</td>
						<th></th>
						<td></td> 						
 					</tr>
					<tr>
						<th><font color="red">*用户名：</font></th>
						<td>
							<input type="text" name="userName" id="userName"   class="required isCharLengthOf" v_maxlength="8" v_minlength="1"/>
						</td>
						<th><font color="red">*密码：</font></th>
						<td>
 							<input type="password" name="passwd" id="passwd"   class="required isCharLengthOf" v_maxlength="8" v_minlength="1"/>
						</td>
					</tr>
					<tr>
						<th><font color="red">*HOME目录：</font></th>
						<td>
							<input type="text" name="homeDir" id="homeDir"   class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th>备注：</th>
						<td>
							<input type="text" name="remark" id="remark" class="isCharLengthOf" v_maxlength="128" v_minlength="0"/>
						</td>
					</tr>					
					
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="addHostUserSubmit()" class="b_foot" value="确定" />
				<input type="reset" name="re" onClick="javascript:document.forms('hostForm').reset();" class="b_foot" value="重置" />
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

function addHostUserSubmit(){
    if(!checksubmit(hostForm)){
		return false;
	}
	document.hostForm.action='<%=request.getContextPath()%>/addHostUser.do';
	document.hostForm.submit();
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