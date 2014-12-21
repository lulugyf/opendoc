<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
 
<html>
<head>
<title>新增产品信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
 			
			<div class="input">
				<table>
					<tr>
						<th><font color="red">*产品名称：</font></th>
						<td>
							<input type="text" name="proName" id="proName" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th><font color="red">*产品版本：</font></th>
						<td>
							<input type="text" name="proVersion" id="proVersion" class="required isCharLengthOf" v_maxlength="10" v_minlength="0"/>
						</td>				
					</tr>
					<tr>
						<th>备注：</th>
						<td colspan="3">
							<input type="text" name="remarks" id="remarks" class="isCharLengthOf" v_maxlength="256" v_minlength="0" size="100"/>
						</td> 				
					</tr>										
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="addProductSubmit()" class="b_foot" value="确定" />
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

function addProductSubmit(){
	$('#proName').val($.trim($('#proName').val()));
	$('#proVersion').val($.trim($('#proVersion').val()));
    if(!checksubmit(hostForm)){
		return false;
	}
	document.hostForm.action='<%=request.getContextPath()%>/addProduct.do';
	document.hostForm.submit();
	
}
</script>
</body>
</html>