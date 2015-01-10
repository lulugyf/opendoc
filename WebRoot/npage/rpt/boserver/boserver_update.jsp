<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.util.*" %>
<%
String sys=Constants.PROD_SYSTEM;
 %>
<html>
<head>
<title>修改配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="frm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="boid" id="boid">
			<div class="input">
				<table>
					<tr>
						<th>名称</th>
						<td>
							<input type="text" name="boname" id="boname" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th>验证服务地址</th>
						<td>
							<input type="text" name="authaddr" id="authaddr" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
					</tr>
					<tr>
						
						<th>用户名</th>
						<td>
							<input type="text" name="username" id="username" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th>密码</th>
						<td>
							<input type="password" name="password" id="password" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>							
						</td>
					</tr> 
					<tr>
						<th>文档访问地址</th>
						<td>
							<input type="text" name="opendocaddr" id="opendocaddr" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th>备注</th>
						<td>
							<input type="text" name="remarks" id="remarks"/>							
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="frmSubmit()" class="b_foot" value="确定" />
				<input type="reset" name="re" onClick="javascript:document.forms('frm').reset();" class="b_foot" value="重置" />
				<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
			</div>
			<div align="center">
			    <font color="red"><span id="operInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>
$(document).ready(function () {
	
	//处理下拉列表选中
	$("#boid").val("${bo.boid}");
	$("#boname").val("${bo.boname}");
	$("#authaddr").val("${bo.authaddr}");
	$("#username").val("${bo.username}");
	$("#password").val("${bo.password}");
	$("#opendocaddr").val("${bo.opendocaddr}");
	$("#remarks").val("${bo.remarks}");

	
    //关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSrchSubmit();
	    }catch(e){}
	});
	//--end
	$('#proName').val($('#proCode :selected').text());
	$proCode=$('#proCode').html();
	getPro();
});

function frmSubmit(){
    if(!checksubmit(frm)){
		return false;
	}
	document.frm.action='<%=request.getContextPath()%>/updateBOServer.do';
	document.frm.submit();
	
}

//超级管理员只能选择后台管理功能，普通管理员不能选择后台管理功能
function getPro(){
    $('#proCode').html($proCode);
    if($('#roleType').val()=='0'){
    	$('#proCode').val('<%=sys%>');
    	$('#proCode').attr('disabled','true');
    	validateField($('#proCode').get(0));
    }else{
        $('#proCode').attr('disabled','');
        $("#proCode option[value='<%=sys%>']").remove();
    }
}
</script>
</body>
</html>