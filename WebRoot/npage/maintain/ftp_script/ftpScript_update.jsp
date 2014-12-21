<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>新增FTP脚本信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String siteId=request.getParameter("siteId");
String actionId=request.getParameter("actionId");
String provinceCode= request.getParameter("provinceCode");
String tellType= request.getParameter("tellType");
%>
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm">
		
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=provinceCode%>">
			<input type=hidden name="tellType" id="tellType" value="<%=tellType%>">
			<input type=hidden name="oldSiteId" id="oldSiteId" value="<%=siteId%>">
			<input type=hidden name="oldActionId" id="oldActionId" value="<%=actionId%>">
			
			<c:if test="${romScriptsConfig!=null}">
				<input type=hidden name="scriptsId" id="scriptsId" value="${romScriptsConfig.scriptsId}">
				<div class="input">
					<table>
	 					<tr>
	 						<th><font color="red">*FTP站点：</font></th>
							<td colspan="3">
								<input type=hidden name="hostId" id="hostId" value="${romScriptsConfig.hostId}" />
								<input type=hidden name="siteId" id="siteId" value="<%=siteId%>"/>
								<input type="text" name="siteName" id="siteName" class="required" readonly="readonly" value="${siteName}"/>
								<input type="button" name="choiceSiteButton" onClick="choiceSiteInfo();" class="b_foot" value="选择FTP站点" />
							</td>						
	 					</tr>
	 					<tr>
							<th><font color="red">*动作：</font></th>
							<td>
								<select name="actionId" id="actionId" class="required" onchange="getActionName()">
									<option value="4" >文件上传</option>
									<option value="5" >文件下载</option>
								</select>
							<input type=hidden name="actionName" id="actionName" />
							</td> 					
							<th></th>
							<td></td>					
	 					</tr>  					 					
						<tr>
							<th><font color="red">*脚本目录：</font></th>
							<td>
								<input type="text" name="scriptsDir" id="scriptsDir" value="${romScriptsConfig.scriptsDir}" class="required isCharLengthOf" v_maxlength="256" v_minlength="0"/>
							</td>
							<th><font color="red">*脚本名称：</font></th>
							<td>
	 							<input type="text" name="scriptsName" id="scriptsName" value="${romScriptsConfig.scriptsName}" class="required isCharLengthOf" v_maxlength="32" v_minlength="0"/>
							</td>
						</tr>			
						<tr>				
							<th><font color="red">*请求URL：</font></th>
							<td colspan="3">
								<input type="text" name="reqUrl" id="reqUrl" value="${romScriptsConfig.reqUrl}" class="required isCharLengthOf" v_maxlength="128" v_minlength="0"/>
							</td>
						</tr>					
						<tr>
							<th><font color="red">*用户名：</font></th>
							<td>
								<input type="text" name="visitUser" id="visitUser" value="${romScriptsConfig.visitUser}" class="required isCharLengthOf" v_maxlength="8" v_minlength="1"/>
							</td>
							<th><font color="red">*密码：</font></th>
							<td>
	 							<input type="password" name="visitPswd" id="visitPswd" value="${romScriptsConfig.visitPswd}" class="required isCharLengthOf" v_maxlength="8" v_minlength="1"/>
							</td>
						</tr>					
					</table>
				</div>
				<div id="operation_button">
					<input type="button" name="su" onClick="updateFtpScript()" class="b_foot" value="确定" />
					<input type="button" name="re" onClick="resetFrm()" class="b_foot" value="重置" />
					<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
				</div>
				<div align="center">
				    <font color="red"><span id="succInfo">${operInfo}</span></font>
				</div>
			</c:if>
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
	
	$('#actionId').val('<%=actionId%>');
	getActionName();
});

function updateFtpScript(){
    if(!checksubmit(hostForm)){
		return false;
	}
	document.hostForm.action='<%=request.getContextPath()%>/updateFtpScript.do';
	document.hostForm.submit();
}

function choiceSiteInfo(){
	var qryPara="proId=<%=proId%>&opCode=<%=opCode%>&provinceCode="+$('#provinceCode').val()+'&tellType='+$('#tellType').val();
	openDivWin("<%=request.getContextPath()%>/getFtpsiteInfoList.do?"+qryPara,"查询FTP站点信息","700","300");
}

function setHost(hostId,hostInfo){
	$("#siteId").val("");
	$("#siteName").val("");	
	
	$("#hostName").val(hostInfo);
	$("#hostId").val(hostId);
}

function setSite(siteId,siteName){
	$("#siteId").val(siteId);
	$("#siteName").val(siteName);
}

function resetFrm(){
	document.forms('hostForm').reset();
	$('#actionId').val('<%=actionId%>');
}

function getActionName(){
	$('#actionName').val($('#actionId :selected').text());
}
</script>
</body>
</html>