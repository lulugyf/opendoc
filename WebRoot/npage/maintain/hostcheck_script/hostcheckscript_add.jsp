<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%
String hostId=request.getParameter("hostId");
%>
<html>
<head>
<title>新增工单脚本信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm">
		
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">	
			<input type=hidden name="dataFuncCode" id="dataFuncCode" value="<%=opCode%>">
			<input type=hidden name="hostId" id="hostId" value="<%=hostId%>">
			<input type=hidden name="hostMesLog" id="hostMesLog" value="<%=request.getParameter("hostMesLog")%>">
			<div class="input">
				<table>
 					<tr>
						<th><font color="red">*动作：</font></th>
						<td>
							<select name="actionId" id="actionId" class="required ">
								<option value="11" >主机巡检</option>
							</select>
						</td> 					
						<th><font color="red">*脚本类型：</font></th>
						<td>
							<select name="scriptsType" id="scriptsType" class="required " onchange="chgScriptsType()">
								<option value="0">定时执行的脚本</option>
								<option value="1">手工执行的脚本</option>
							</select>
						</td>					
 					</tr>  					 					
					<tr>
						<th><font color="red">*脚本目录：</font></th>
						<td>
							<input type="text" name="scriptsDir" id="scriptsDir" class="required isCharLengthOf" v_maxlength="256" v_minlength="0"/>
						</td>
						<th><font color="red">*脚本名称：</font></th>
						<td>
 							<input type="text" name="scriptsName" id="scriptsName" class="required isCharLengthOf" v_maxlength="32" v_minlength="0"/>
						</td>
					</tr>
					<tr  id="scriptShow1" style="display:none">
						<th><font color="red">*脚本执行开始时间：</font></th>
						<td>
							<input id="beginTimeStr" name="beginTimeStr"  class="required" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,maxDate:'#F{$dp.$D(\'endTimeStr\')}'})"/>
 						</td>
						<th><font color="red">*脚本执行结束时间：</font></th>
						<td>
 							<input id="endTimeStr"  name="endTimeStr" class="required" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,minDate:'#F{$dp.$D(\'beginTimeStr\')}'})"/>
						</td>
					</tr>
					<tr id="scriptShow2" style="display:none">
						<th><font color="red">*脚本执行间隔：</font></th>
						<td colspan="3">
 							<input type="text" name="intervalTime" id="intervalTime" class="required isDigLengthOf" v_maxlength="12" v_minlength="0"/>
						</td>					
					</tr>					
					<tr>				
						<th><font color="red">*请求URL：</font></th>
						<td colspan="3">
							<input type="text" name="reqUrl" id="reqUrl" class="required isCharLengthOf" v_maxlength="128" v_minlength="0"/>
						</td>
					</tr>					
					<tr>
						<th><font color="red">*用户名：</font></th>
						<td>
							<input type="text" name="visitUser" id="visitUser"   class="required isCharLengthOf" v_maxlength="8" v_minlength="1"/>
						</td>
						<th><font color="red">*密码：</font></th>
						<td>
 							<input type="password" name="visitPswd" id="visitPswd"   class="required isCharLengthOf" v_maxlength="8" v_minlength="1"/>
						</td>
					</tr>					
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="addHostCheckScript()" class="b_foot" value="确定" />
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
 	var scriptsType=$('#scriptsType').val();
 	if(scriptsType=="0"){//定时脚本
 		$('#scriptShow1').css('display','');
 		$('#scriptShow2').css('display','');
 	}else{
 		$('#scriptShow1').css('display','none');
 		$('#scriptShow2').css('display','none'); 	
 	}
	
	//关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSrchSubmit();
	    }catch(e){}
	});
});

function chgScriptsType(){
 	var scriptsType=$('#scriptsType').val();
 	if(scriptsType=="0"){//定时脚本
 		//切换后清除设置过的数据
 		$('#beginTimeStr').val("");
 		$('#endTimeStr').val("");
 		$('#intervalTime').val("");
 		
 		$('#scriptShow1').css('display','');
 		$('#scriptShow2').css('display','');
 	}else{
 		$('#scriptShow1').css('display','none');
 		$('#scriptShow2').css('display','none'); 	
 	}
}

function addHostCheckScript(){
    if(!checksubmit(hostForm)){
		return false;
	}
	
	document.hostForm.action='<%=request.getContextPath()%>/addHostCheckScript.do';
	document.hostForm.submit();
	
}

</script>
</body>
</html>