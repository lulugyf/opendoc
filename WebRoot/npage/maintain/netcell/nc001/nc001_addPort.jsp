<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>新增端口</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="netCellForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
			<input type=hidden name="cellId" id="cellId" value="${romNetCell.cellId}">			
			<div class="input">
				<table>
					<tr>
						<th>省份运营商</th>
						<td>
							<input type="text" name="name" id="name" readonly="true" value="${romNetCell.provinceName}${romNetCell.tellcorpName}"/>
						</td>
						<th>网元名称：</th>
						<td>
							<input type="text" name="cellName" id="cellName" readonly="true" value="${romNetCell.cellName}"/>
						</td>
					</tr>
					<tr>
						<th>网元编码：</th>
						<td>
							<input type="text" name="cellCode" id="cellCode" readonly="true" value="${romNetCell.cellCode}"/>
						</td>
						<th>网元编号：</th>
						<td>
							<input type="text" name="hlrCode" id="hlrCode" readonly="true" value="${romNetCell.hlrCode}"/>
						</td>
					</tr>
	
					<tr>
						<th>IP地址：</th>
						<td>
							<input type="text" name="ipAddr" id="ipAddr" readonly="true" value="${romNetCell.ipAddr}"/>
						</td>
						<th><font color="red">*监听端口：</font></th>
						<td>
							<input type="text" name="port" id="port" value="" v_minlength="1" v_maxlength="6" class="required isCharLengthOf nonNegInt"/>
						</td>
					</tr>
					<tr>
						<th>是否有效：</th>
						<td>
							<input type="text" name="useFlag" id="useFlag" readonly="true" value="${romNetCell.useFlag}"/>
						</td>
					</tr>	
					<tr>	
						<th>备注：</th>
						<td colspan="3">
							<input type="text" name="remark" id="remark" readonly="true" size="100" value="${romNetCell.remark}"/>
						</td>
					</tr>					
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="updateHostSubmit()" class="b_foot" value="确定" />
				<input type="button" name="re" onClick="resetFrm()" class="b_foot" value="重置" />
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

function updateHostSubmit(){
    if(!checksubmit(netCellForm)){
		return false;
	}
	
	document.netCellForm.action='<%=request.getContextPath()%>/nc001AddPort.do';
	document.netCellForm.submit();	
}

function resetFrm(){
	document.forms('netCellForm').reset();
	$("#port").val("");	

}
</script>
</body>
</html>