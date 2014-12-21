<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
 
<html>
<head>
<title>配置脚本信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="pmFrom"> 		 
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
			<input type=hidden name="scriptsId" id="scriptsId" >
			<input type=hidden name="itemId" id="itemId" value="${itemId}">
			
			<div class="input">
					<table>					
						<tr>
							<th><font color="red">*进程动作：</font></th>
							<td colspan="3">
								<select name="actionId" id="actionId" class="required" onchange="onChangeAction()">
									<option value="0" selected="selected">启动</option>
									<option value="1">停止</option>
								</select>
							</td>				
	 					</tr>  					 					
						<tr>
							<th><font color="red">*脚本目录：</font></th>
							<td>
								<input type="text" name="scriptsDir" id="scriptsDir"  class="required isCharLengthOf" v_maxlength="256" v_minlength="0"/>
							</td>
							<th><font color="red">*脚本名称：</font></th>
							<td>
	 							<input type="text" name="scriptsName" id="scriptsName"  class="required isCharLengthOf" v_maxlength="32" v_minlength="0"/>
							</td>
						</tr>					
						<tr>
							<th><font color="red">*请求URL：</font></th>
							<td colspan="3">
								<input type="text" name="reqUrl" id="reqUrl" size="80"  class="required isCharLengthOf" v_maxlength="128" v_minlength="0"/>
							</td>
						</tr>					
						<tr>
							<th><font color="red">*用户名：</font></th>
							<td>
								<input type="text" name="visitUser" id="visitUser"  class="required isCharLengthOf" v_maxlength="8" v_minlength="1"/>
							</td>
							<th><font color="red">*密码：</font></th>
							<td>
	 							<input type="password" name="visitPswd" id="visitPswd"  class="required isCharLengthOf" v_maxlength="8" v_minlength="1"/>
							</td>
						</tr>
						
					</table>
					<div id="operation_button">
						<input type="button" name="su" onClick="doSrchSubmit()" class="b_foot" value="确定" />						
						<input type="reset" name="re" onClick="javascript:document.forms('pmFrom').reset();" class="b_foot" value="重置" />
						<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
					</div>
					<div align="center">
			    		<font color="red"><span id="succInfo">${operInfo}</span></font>
					</div>
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
	
	$("#provinceTell option").each(function(){
    	if($(this).val()!=$('#provinceCode').val()+'_'+$('#tellType').val()){
    		$(this).remove();
    	}
    });
    
    //初始化西悉尼
    onChangeAction();
    	       	       	  
});


/**********************************************************************************/
//根据脚本动作,编辑不同的脚本
function onChangeAction(){
	if(g("actionId").value == "0" && '<%=request.getAttribute("scriptsId0")%>' != null){
		g("scriptsId").value = "${scriptsId0}";
		g("scriptsDir").value = "${romScriptsConfig0.scriptsDir}";
		g("scriptsName").value = "${romScriptsConfig0.scriptsName}";
		g("reqUrl").value = "${romScriptsConfig0.reqUrl}";
		g("visitUser").value = "${romScriptsConfig0.visitUser}";
		g("visitPswd").value = "${romScriptsConfig0.visitPswd}";				
	}else if(g("actionId").value == "1" && '<%=request.getAttribute("scriptsId1")%>' != null){
		g("scriptsId").value = "${scriptsId1}";
		g("scriptsDir").value = "${romScriptsConfig1.scriptsDir}";
		g("scriptsName").value = "${romScriptsConfig1.scriptsName}";
		g("reqUrl").value = "${romScriptsConfig1.reqUrl}";
		g("visitUser").value = "${romScriptsConfig1.visitUser}";
		g("visitPswd").value = "${romScriptsConfig1.visitPswd}";	
	}
}

//提交
function doSrchSubmit(){
	if(!checksubmit(pmFrom)){
		return false;
	}
	
	document.pmFrom.action='<%=request.getContextPath()%>/pm001ScriptConfig.do';
	document.pmFrom.submit();
}

/////////////////////////////////////////////////
function g(o){
	return document.getElementById(o);
}

</script>
</body>
</html>