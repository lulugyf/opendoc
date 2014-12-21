<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>修改网元信息</title>
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
						<th>省份运营商:</th>
						<td>
							<input type="text" name="name" id="name" readonly="true" value="${romNetCell.provinceName}${romNetCell.tellcorpName}"/>
						</td>
						<th>网元名称：</th>
						<td>
							<input type="text" name="cellName" id="cellName" v_minlength="1" v_maxlength="32" class="byteSize" value="${romNetCell.cellName}"/>
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
						<th><font color="red">*IP地址：</font></th>
						<td>
							<input type="text" name="ipAddr" id="ipAddr" value="${romNetCell.ipAddr}" class="required ipAddress"/>
							<input type="hidden" name="oldIpAddr" id="oldIpAddr" value="${romNetCell.ipAddr}"/>
						</td>
						<th><font color="red">*监听端口：</font></th>
						<td>
							<input type="text" name="port" id="port" value="${romNetCell.port}" v_minlength="1" v_maxlength="6" class="required isCharLengthOf nonNegInt"/>
							<input type="hidden" name="oldPort" id="oldPort" value="${romNetCell.port}"/>
						</td>
					</tr>
					<tr>
						<th>是否有效：</th>
						<td>
							<select name="useFlag" id="useFlag">
									<option value="y">有效</option>
									<option value="n">无效</option>
							</select>
						</td>
					</tr>	
					<tr>	
						<th>备注：</th>
						<td colspan="3">
							<input type="text" name="remark" id="remark" size="64" value="${romNetCell.remark}" v_minlength="1" v_maxlength="64" class="byteSize"/>
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
	
	document.netCellForm.action='<%=request.getContextPath()%>/nc001Update.do';
	document.netCellForm.submit();	
}

function resetFrm(){
	document.forms('netCellForm').reset();
}
</script>
</body>
</html>