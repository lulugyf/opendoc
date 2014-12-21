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
<title>修改分组信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="groupForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=provinceCode%>">
			<input type=hidden name="tellType" id="tellType" value="<%=tellType%>">
			<input type="hidden" name="groupId" id="groupId" value="${onebossBusiGroups.groupId}" />
			<div class="input">
				<table>
 					<tr>
 						<th>主机信息：</th>
						<td><%=hostinfostr %><input type="hidden" id="hostName" name="hostName" value="<%=hostinfostr %>"/></td> 						
 					</tr> 
					<tr>
						<th><font color="red">*分组名称：</font></th>
						<td>
							<input type="text" name="groupName" id="groupName" value="${onebossBusiGroups.groupName}" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
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
							<input type="text" name="remarks" id="remarks" value="${onebossBusiGroups.remarks}" class="isCharLengthOf" v_maxlength="256" v_minlength="0"/>
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="updateProgInfoConfSubmit()" class="b_foot" value="确定" />
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
	
	$("input[name='isdefault']").each(function(){
        if($(this).val()=='${onebossBusiGroups.isdefault}'){
            $(this).click();
        }
    });
	
});

function updateProgInfoConfSubmit(){
    if(!checksubmit(groupForm)){
		return false;
	}
	
	document.groupForm.action='<%=request.getContextPath()%>/updateTransGroup.do';
	document.groupForm.submit();
}

</script>
</body>
</html>