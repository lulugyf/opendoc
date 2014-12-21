<%@ page language="java" import="java.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.common.dto.RomSysLogin" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>新增工号信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="loginForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<div class="input">
				<table>
					<tr>
						<th><font color="red">*工号</font></th>
						<td>
							<input type="text" name="loginNo" id="loginNo" value="${failAddObj.loginNo}" class="required isCharLengthOf numOrLetter" v_maxlength="8" v_minlength="0"/>
						</td>
						<th><font color="red">*姓名</font></th>
						<td>
							<input type="text" name="loginName" id="loginName" value="${failAddObj.loginName}" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
					</tr>
					<tr>
						<th><font color="red">*使用标识</font></th>
						<td>
							<select name="useFlg" id="useFlg">
								<option value="0" selected="true" >有效</option>
								<option value="1">无效</option>
							</select>
						</td>
					    <th><font color="red">*联系号码</font></th>
						<td>
							<input type="text" name="phoneNo" id="phoneNo" value="${failAddObj.phoneNo}" class="required isLengthOf allCellPhone" v_maxlength="15" v_minlength="0"/>
						</td>
					</tr>
					
					<tr>
					  <th><font color="red">*省份代码</font></th>
					  <td>
							<select name="province_code" id="province_code" class="required">
							 <option value="" ></option>
							<c:if test="${provinceList!=null}"> 
							<c:forEach items="${provinceList}" var="item">
								<option value="${item.provinceCode}" >${item.provinceName}</option>
							</c:forEach>
							</c:if>
							</select> 
						</td> 
					</tr>
					
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" id="su" onclick="addLoginSubmit()" class="b_foot" value="确定" />
				<input type="reset" name="re" id="re" onclick="document.forms('loginForm').reset();" class="b_foot" value="重置" />
				<input type="button" name="close" id="close" onclick="parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
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
    $('#useFlg').val('${failAddObj.useFlg}');
    
    //关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSrchSubmit();
	    }catch(e){}
	});
	//--end
	
});

//提交
function addLoginSubmit(){
    if(!checksubmit(loginForm)){
		return false;
	}
	document.loginForm.action='<%=request.getContextPath()%>/addLogin.do';
	document.loginForm.submit();
}

</script>
</body>
</html>