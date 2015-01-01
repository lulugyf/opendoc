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
			<input type=hidden name="order_id" id="order_id" value="${db.order_id}">
			<div class="input">
				<table>
					<tr>
						<th>数据库IP</th>
						<td>
							<input type="text" name="serv_ip" id="serv_ip" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th>主机名</th>
						<td>
							<input type="text" name="serv_name" id="serv_name" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
					</tr>
					<tr>
						
						<th>主机用户名</th>
						<td>
							<input type="text" name="serv_user" id="serv_user" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th>主机密码</th>
						<td>
							<input type="password" name="serv_pwd" id="serv_pwd" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>							
						</td>
					</tr> 
					<tr>
						<th>源数据库类型</th>
						<td>
							<select name="db_type" id="db_type">
						    <c:forEach items="${typelist }" var="item">
			   			<option value="${item.dbtype }">${item.dbtype }</option>
			   			</c:forEach>
						    </select>				
						</td>
						<th>数据库名</th>
						<td>
							<input type="text" name="db_name" id="db_name"/>							
						</td>
					</tr>
					<tr>
						<th>数据库端口</th>
						<td>
							<input type="text" name="db_port" id="db_port" onkeyup="value=value.replace(/[^\d]/g,'')" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th>数据库用户名</th>
						<td>
							<input type="text" name="db_user" id="db_user"/>							
						</td>
					</tr>
					<tr>
						<th>数据库密码</th>
						<td>
							<input type="password" name="db_pwd" id="db_pwd" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th>导出路径</th>
						<td>
							<input type="text" name="data_dir" id="data_dir"/>							
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
	$("#serv_ip").val("${db.serv_ip}");
	$("#serv_name").val("${db.serv_name}");
	$("#serv_user").val("${db.serv_user}");
	$("#serv_pwd").val("${db.serv_pwd}");
	$("#db_type").val("${db.db_type}");
	$("#db_name").val("${db.db_name}");
	$("#db_port").val("${db.db_port}");
	$("#db_user").val("${db.db_user}");
	$("#db_pwd").val("${db.db_pwd}");
	$("#data_dir").val("${db.data_dir}");
	
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