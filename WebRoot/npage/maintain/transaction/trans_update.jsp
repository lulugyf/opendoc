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
<title>修改业务信息</title>
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
			<input type=hidden name="dataFuncCode" id="dataFuncCode" value="<%=request.getParameter("dataFuncCode")%>">
			<input type="hidden" name="transId" id="transId" value="${onebossBusiNotes.transId}" />
			<input type="hidden" name="itemId" id="itemId" value="${onebossBusiNotes.itemId}" />
			<div class="input">
				<table>
 					<tr>
 						<th>主机信息：</th>
						<td><%=hostinfostr %><input type="hidden" id="hostName" name="hostName" value="<%=hostinfostr %>"/></td> 						
 					</tr> 
					<tr>
						<th>业务功能信息：</th>
						<td>${romMaintainItems.itemName} ${romMaintainItems.itemDesc}
							<input type="hidden" name="busiCode" id="busiCode" value="${romMaintainItems.itemName}" class="required" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th><font color="red">*交易代码：</font></th>
						<td>
							<input type="text" name="transCode" id="transCode" value="${onebossBusiNotes.transCode}" class="required isCharLengthOf" v_maxlength="10" v_minlength="0"/>
						</td>
					</tr>
					<tr>
						<th><font color="red">*交易名称：</font></th>
						<td>
							<input type="text" name="transName" id="transName" value="${onebossBusiNotes.transName}" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
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
	
});

function updateProgInfoConfSubmit(){
    if(!checksubmit(hostForm)){
		return false;
	}
	
	document.hostForm.action='<%=request.getContextPath()%>/updateTransaction.do';
	document.hostForm.submit();
}

</script>
</body>
</html>