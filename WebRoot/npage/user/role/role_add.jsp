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
<title>新增角色信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="roleForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<div class="input">
				<table>
					<tr>
						<th><font color="red">*角色名称</font></th>
						<td>
							<input type="text" name="roleName" id="roleName"   class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th><font color="red">*角色类别</font></th>
						<td>
							<select name="roleType" id="roleType" onchange="getPro()" class="required">
								<option value="1">普通管理员</option>
								<option value="0">超级管理员</option>							
							</select>					
						</td>
					</tr>
					<!--<tr>
						
						  <th><font color="red">*省份代码</font></th>
						<td>
							<select name="provinceCode" id="provinceCode" class="required">
							 <option value="" ></option>
							<c:if test="${provinceList!=null}"> 
							<c:forEach items="${provinceList}" var="item">
								<option value="${item.provinceCode}" >${item.provinceName}</option>
							</c:forEach>
							</c:if>
							</select>
						</td>
						<th><font color="red">*运营商代码</font></th>
						<td>
							<select name="tellType" id="tellType" class="required">
							 <option value="" ></option>
							<c:if test="${tellcorpList!=null}"> 
							<c:forEach items="${tellcorpList}" var="item">
								<option value="${item.tellcorpCode}" >${item.tellcorpName}</option>
							</c:forEach>
							</c:if>
							</select>							
						</td>
					</tr> -->
					<tr>
						<th><font color="red">*是否有效</font></th>
						<td>
							<select name="roleState" id="roleState">
								<option value="0" selected="true" >有效</option>
								<option value="1">无效</option>
							</select>
						</td>
						<th><font color="red">*所属产品</font></th>
						<td>
							<select name="proCode" id="proCode" class="required" onchange="getProName()">
								<option value="" selected="true"></option>
						    	<c:forEach var="item" items="${productList}">
						    		<option value="${item.proCode}">${item.proName}</option>		
								</c:forEach>
							</select>
							<input type="hidden" name="proName" id="proName"/>	
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="addRoleSubmit()" class="b_foot" value="确定" />
				<input type="reset" name="re" onClick="javascript:document.forms('roleForm').reset();" class="b_foot" value="重置" />
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
	//关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSrchSubmit();
	    }catch(e){}
	});
	//--end
	$proCode=$('#proCode').html();
	getPro();
	getProName();
});

function addRoleSubmit(){
    if(!checksubmit(roleForm)){
		return false;
	}
	document.roleForm.action='<%=request.getContextPath()%>/addRole.do';
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

function getProName(){
	$('#proName').val($('#proCode :selected').text());
}
</script>
</body>
</html>