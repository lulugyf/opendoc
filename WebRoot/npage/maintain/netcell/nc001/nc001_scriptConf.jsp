<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>端口监控脚本配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="scriptForm">
		
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">	
			<input type=hidden name="cellId" id="cellId" value="<%=request.getAttribute("cellId") %>">
			
			<input type=hidden name="scriptsId" id="scriptsId" value="${romScriptsConfig.scriptsId}">			
			<input type=hidden name="hostId" id="hostId" value="0">
			<input type=hidden name="itemId" id="itemId" value="<%=request.getAttribute("cellId") %>">
			<input type=hidden name="actionId" id="actionId" value="0">
			<input type=hidden name="scriptsType" id="scriptsType" value="1">
				
			<div class="input">
				<table>
					<tr>
						<th><font color="red">*脚本目录：</font></th>
						<td>
							<input type="text" name="scriptsDir" id="scriptsDir" value="${romScriptsConfig.scriptsDir}" class="required isCharLengthOf" v_maxlength="256" v_minlength="0" />
						</td>
						<th><font color="red">*脚本名称：</font></th>
						<td>
 							<input type="text" name="scriptsName" id="scriptsName" value="${romScriptsConfig.scriptsName}" class="required isCharLengthOf" v_maxlength="32" v_minlength="0"/>
						</td>
					</tr>					
					<tr>
						<th><font color="red">*请求URL：</font></th>
						<td colspan="3">
							<input type="text" name="reqUrl" id="reqUrl" size="80" value="${romScriptsConfig.reqUrl}" class="required isCharLengthOf" v_maxlength="128" v_minlength="0"/>
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
				<input type="button" name="su" onClick="scriptConfSubmit('add')" class="b_foot" value="确定" />
				<input type="reset" name="re" onClick="javascript:document.forms('scriptForm').reset();" class="b_foot" value="重置" />
				<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
				<input type="button" name="close" onClick="scriptConfSubmit('del')" class="b_foot" value="删除"/>
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

function scriptConfSubmit(type){
    if(!checksubmit(scriptForm)){
		return false;
	}
 
	document.scriptForm.action='<%=request.getContextPath()%>/nc001ScriptConf.do?opType=' + type;
	document.scriptForm.submit();
}


</script>
</body>
</html>