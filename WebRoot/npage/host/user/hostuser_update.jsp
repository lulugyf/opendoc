<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.bo.HostBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%
String provinceCode= request.getParameter("provinceCode");
String tellType= request.getParameter("tellType");
 

HostBo hostBo=(HostBo)request.getAttribute("hostBo");
String hostinfostr="";
if(null!=hostBo){
	hostinfostr=hostBo.getProvinceName()+hostBo.getTellName()+"-"+hostBo.getHostIp();
}
 %>
<html>
<head>
<title>修改主机用户信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm">
		
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=provinceCode%>">
			<input type=hidden name="tellType" id="tellType" value="<%=tellType%>">
			
			<input type=hidden name="userId" id="userId" value="${romUserInfo.userId}">
			<div class="input">
				<table>
 				
 					<tr>
 						<th>主机信息：</th>
						<td colspan="3">
							<input type="text" name="hostinfostr" id="hostinfostr" class="" readonly="readonly" value="<%=hostinfostr %>"  size="80"/>
						</td>
 						
 					</tr>
					<tr>
						<th><font color="red">*用户名：</font></th>
						<td>
							<input type="text" name="userName" id="userName" value="${romUserInfo.userName}"  class="required isCharLengthOf" v_maxlength="8" v_minlength="1"/>
						</td>
						<th><font color="red">*密码：</font></th>
						<td>
 							<input type="password" name="passwd" id="passwd" value="${romUserInfo.passwd}"  class="required isCharLengthOf" v_maxlength="8" v_minlength="1"/>
						</td>
					</tr>
					<tr>
						<th><font color="red">*HOME目录：</font></th>
						<td>
							<input type="text" name="homeDir" id="homeDir"  value="${romUserInfo.homeDir}" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th>备注：</th>
						<td>
							<input type="text" name="remark" id="remark" value="${romUserInfo.remark}" class="isCharLengthOf" v_maxlength="128" v_minlength="0"/>
						</td>
					</tr>					
					
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="updateHostUserSubmit()" class="b_foot" value="确定" />
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
	//--end
});

function updateHostUserSubmit(){
    if(!checksubmit(hostForm)){
		return false;
	}
	document.hostForm.action='<%=request.getContextPath()%>/updateHostUser.do';
	document.hostForm.submit();
	
}
</script>
</body>
</html>