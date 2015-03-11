<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.*" %>
<%
String sys=Constants.PROD_SYSTEM;
 %>
<html>
<head>
<title>修改角色信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="style/conf_style.css"/>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/menu_min.js"></script>
<script>  
//加载时适应浏览器高度
$(document).ready(function() {
    //模块尺寸  
	$('.pz_menu').css('height', $(window).height() - 141); 
	$('.pz_cont_wiap100').css('height', $(window).height() - 10); 
})
//改变窗体大小时适应浏览器高度
$(window).resize(function() {
    //模块尺寸
	$('.pz_menu').css('height', $(window).height() - 141);
	$('.pz_cont_wiap100').css('height', $(window).height() - 250);
});
</script>
<script type="text/javascript">
$(document).ready(function (){ 
  
  $(".pz_menu_cont ul li").menu();
  
}); 
</script>
 
</head>
<body>
   <div id="operation" class="bb_right_cont1">
	<div id="operation_table">
		<form action="" method="post" name="roleForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="roleId" id="roleId" value="${romSysRole.roleId}">
			<div class="input">
				<table width="100%" border="0" cellspacing="2" cellpadding="0"  bgcolor="#FFFFFF">
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;"><font color="red">*角色名称：</font></td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;">
							<input type="text" name="roleName" id="roleName" value="${romSysRole.roleName}" v_maxlength="64" v_minlength="0" class="anc"/>
							<input type="hidden" name="roleNameOld" id="roleNameOld" value="${romSysRole.roleName}"/>
						</td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;"><font color="red">*角色类别：</font></td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<select name="roleType" id="roleType" onchange="getPro()" style="width:186px;height:24px">
								<option value ="">--请选择--</option>
								<option value="1">普通管理员</option>
								<option value="0">超级管理员</option>							
							</select>					
						</td>
					</tr>
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;"><font color="red">*是否有效：</font></td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<select name="roleState" id="roleState" style="width:186px;height:24px">
								<option value ="">--请选择--</option>
								<option value="0" selected="true" >有效</option>
								<option value="1">无效</option>
							</select>
						</td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;"><font color="red">*所属产品：</font></td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<select name="proCode" id="proCode" style="width:186px;height:24px">
								<option value ="">--请选择--</option>
						    	<c:forEach var="item" items="${productList}">
						    		<option value="${item.proCode}">${item.proName}</option>		
								</c:forEach>
							</select>
							<input type="hidden" name="proName" id="proName" readonly="true"/>
						</td>
					</tr>
      				<tr height="12"></tr>
					<tr>
			          <td height="32" align="center" class="blue" colspan="4">
			            <input name="su" type="button" class="bb_right_sub1" value="确  定" onclick="addRoleSubmit()"/>&nbsp;&nbsp;&nbsp;
			            <input name="re" type="button" class="bb_right_sub1" value="重  置" onclick="resetFrm()"/>&nbsp;&nbsp;&nbsp;
						<input name="close" type="button" class="bb_right_sub1" value="关  闭" onclick="parent.doSrchSubmit();parent.removeDivWin('divWin');"/>
						</td>
			        </tr>
				</table>
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
	$("#roleType").val("${romSysRole.roleType}");
	$("#provinceCode").val("${romSysRole.provinceCode}");
	$("#tellType").val("${romSysRole.tellType}");
	$("#roleState").val("${romSysRole.roleState}");
	$("#proCode").val("${romSysRole.proCode}");
	
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
	//document.forms('roleForm').reset();
	//$("#provinceCode").val("${romSysRole.provinceCode}");
	//$("#tellType").val("${romSysRole.tellType}");
	//$('#proName').val($('#proCode :selected').text());
	$('#roleName').val('');
	$('#roleType').val('');
	$('#roleState').val('');
	//$('#proCode').val('');
}

function addRoleSubmit(){
    if(!checksubmit(roleForm)){
		return false;
	}
	document.roleForm.action='<%=request.getContextPath()%>/updateRole.do';
	document.roleForm.submit();
	
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