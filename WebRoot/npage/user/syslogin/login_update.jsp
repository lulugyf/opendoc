<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.common.dto.RomSysLogin" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>新增工号信息</title>
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
		<form action="" method="post" name="loginForm">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		 <c:if test="${updateObj.loginNo!=null}"> 
			<div class="input">
				<table width="100%" border="0" cellspacing="2" cellpadding="0"  bgcolor="#FFFFFF">
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;"><font color="red">*工号：</font></td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;">
							<input type="hidden" name="loginNoOld" id="loginNoOld" value="${updateObj.loginNo}"/>
							<input type="text" name="loginNo" id="loginNo" value="${updateObj.loginNo}" v_maxlength="64" v_minlength="0" class="anc"/>
						</td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;"><font color="red">*姓名：</font></td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;">
							<input type="text" name="loginName" id="loginName" value="${updateObj.loginName}" v_maxlength="64" v_minlength="0" class="anc"/>
						</td>
					</tr>
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;"><font color="red">*使用标识：</font></td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<select name="useFlg" id="useFlg" style="width:186px;height:24px">
								<option value ="">--请选择--</option>
								<option value="0" selected="true" >有效</option>
								<option value="1">无效</option>
							</select>
						</td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;"><font color="red">*联系号码：</font></td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;">
							<input type="text" name="phoneNo" id="phoneNo" value="${updateObj.phoneNo}" v_maxlength="64" v_minlength="0" class="anc"/>
						</td>
					</tr>
					
							<tr>
					  <td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;"><font color="red">*省份代码：</font></th>
					  <td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<select name="province_code" id="province_code" style="width:186px;height:24px">
							 <option value ="">--请选择--</option>
							<c:if test="${provinceList!=null}"> 
							<c:forEach items="${provinceList}" var="item">
								<option value="${item.provinceCode}" >${item.provinceName}</option>
							</c:forEach>
							</c:if>
							</select> 
						</td> 
					  <td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;" colspan="2">
						</td> 
					</tr>
      				<tr height="12"></tr>
					<tr>
			          <td height="32" align="center" class="blue" colspan="6">
			            <input name="su" type="button" class="bb_right_sub1" value="确  定" onclick="updateLoginSubmit()"/>&nbsp;&nbsp;&nbsp;
			            <input name="re" type="button" class="bb_right_sub1" value="重  置" onclick="doReset()"/>&nbsp;&nbsp;&nbsp;
						<input name="close" type="button" class="bb_right_sub1" value="关  闭" onclick="parent.doSrchSubmit();parent.removeDivWin('divWin');"/>
						</td>
			        </tr>
				</table>
			</div>
			</c:if>
			<div align="center">
			    <font color="red"><span id="operInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>
$(document).ready(function () {
    $('#useFlg').val('${updateObj.useFlg}');
    
    //关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSrchSubmit();
	    }catch(e){}
	});
	//--end
	
});

function doReset(){
	$('#loginNo').val('');
	$('#loginName').val('');
	$('#useFlg').val('');
	$('#phoneNo').val('');
	$('#province_code').val('');
}

//提交
function updateLoginSubmit(){
    if(!checksubmit(loginForm)){
		return false;
	}
	document.loginForm.action='<%=request.getContextPath()%>/updateLogin.do';
	document.loginForm.submit();
}

</script>
</body>
</html>