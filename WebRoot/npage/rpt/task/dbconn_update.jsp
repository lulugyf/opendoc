<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.util.*" %>
<%
String sys=Constants.PROD_SYSTEM;
 %>
<html>
<head>
<title>修改角色信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="frm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="label" id="label" value="${db.label}">
			<div class="input">
				<table>
					<tr>
						<th><font color="red">*数据库标签</font></th>
						<td>
							${db.label}
						</td>
						<th><font color="red">*类型</font></th>
						<td>
							<select name="dbtype" id="dbtype">
						    <c:forEach items="${typelist }" var="item">
			   			<option value="${item.dbtype }">${item.dbtype }</option>
			   			</c:forEach>
						    </select>				
						</td>
					</tr>
					<tr>
						
						<th><font color="red">*主机</font></th>
						<td>
							<input type="text" name="host" id="host" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th><font color="red">*用户</font></th>
						<td>
							<input type="text" name="user" id="user" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>							
						</td>
					</tr> 
					<tr>
						<th><font color="red">密码</font></th>
						<td>
							<input type="password" name="pswd" id="pswd" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th>数据库</th>
						<td>
							<input type="text" name="db" id="db"/>							
						</td>
					</tr>
					<tr>
					<th>备注</th>
						<td colspan="3">
							<input type="text" name="remarks" id="remarks"/>							
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="frmSubmit()" class="b_foot" value="确定" />
				<input type="button" name="re" onClick="resetFrm()" class="b_foot" value="重置" />
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
	$("#host").val("${db.host}");
	$("#user").val("${db.user}");
	$("#pswd").val("${db.pswd}");
	$("#db").val("${db.db}");
	$("#dbtype").val("${db.dbtype}");
	$("#remarks").val("${db.remarks}")
	
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

function resetFrm(){
	document.forms('frm').reset();
}

function frmSubmit(){
    if(!checksubmit(frm)){
		return false;
	}
	document.frm.action='<%=request.getContextPath()%>/updateDBConn.do';
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