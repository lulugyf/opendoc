<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>工号密码管理</title>
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
<% String loginNo = session.getAttribute("loginNo").toString(); %>
</head>
<body>

<form method="post" name="frm" action="">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<div id="operation" class="bb_right_cont1">
      		<div height="12"><table><tr height="12"></tr></table> </div>
				<div class="title">
					<div class="text">
						首次登陆，请修改密码：
					</div>
				</div>
				<div class="input">
					<table width="100%" border="0" cellspacing="2" cellpadding="0"  bgcolor="#FFFFFF">
						<tr>
							<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">工号：</td>
							<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;">
								<%=loginNo %>
							</td>
						</tr>
						<tr>
							<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">*原始密码：</td>
							<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;">
								<input type="password" id="pre_login_password" name="pre_login_password" v_maxlength="64" v_minlength="0" class="anc"/>
								<span><font id="pre_login_password_msg" color="red"></font></span>
							</td>
						</tr>
						<tr>
							<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">*新密码：</td>
							<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;">
								<input type="password" id="login_password" name="login_password" v_maxlength="64" v_minlength="0" class="anc"/>
								<span><font id="login_password_msg" color="red"></font></span>
							</td>
						</tr>
						<tr>
							<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">*确认密码：</td>
							<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;">
								<input type="password" id="cfm_login_password" name="cfm_login_password" v_maxlength="64" v_minlength="0" class="anc"/>
								<span><font id="cfm_login_password_msg" color="red"></font></span>
							</td>
						</tr>
						<tr>
				          <td height="32" align="center" class="blue" colspan="4">
				            <input name="" type="button" class="bb_right_sub1" value="确  定" onclick="pwdModify()"/>&nbsp;&nbsp;&nbsp;
				            <input name="" type="button" class="bb_right_sub1" value="重  置" onclick="exeReset()"/>
							</td>
				        </tr>
					</table>
				</div>
			</div>
	</div>
		<%@ include file="/npage/include/footer.jsp"%>
</form>
					
</body>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/myactb.js"></script>
<script src="<%=request.getContextPath()%>/npage/rpt/task/task.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
/**
 * 密码修改
 */
function pwdModify() {
	if(!checksubmit(frm)){
		return false;
	}
	
	var pre_login_password = document.getElementById("pre_login_password").value;
	var login_password = document.getElementById("login_password").value;
	var cfm_login_password = document.getElementById("cfm_login_password").value;
	
	if (login_password != cfm_login_password) {
		document.getElementById("login_password_msg").innerText = "两次输入密码不一致！";
		document.getElementById("cfm_login_password_msg").innerText = "两次输入密码不一致！";
		return;
	} else {
		document.getElementById("login_password_msg").innerText = "";
		document.getElementById("cfm_login_password_msg").innerText = "";
	}
	
	var packet = new AJAXPacket("<%=request.getContextPath()%>/updatePassword.do");
	packet.data.add("pre_login_password" ,pre_login_password);
	packet.data.add("login_password" ,login_password);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	core.ajax.sendPacket(packet,pwdModifyBack);
	packet =null;
}

function pwdModifyBack(packet) {
	var retCode = packet.data.findValueByName("retCode");
	if(retCode == "1"){
		//alert("密码修改成功");
		document.location = 'xpage/main.jsp';
	}else if(retCode == "0"){
		showDialog("工号不存在或工号密码不匹配！", 0);
	}else if(retCode == "0"){
		showDialog("密码修改异常！", 0);
	}else if(retCode=='noright'){
	    showDialog("您没有权限进行此操作！", 0);
	}
}

/**
 * 重置
 */
function exeReset() {
	document.getElementById("pre_login_password").value = "";
	document.getElementById("pre_login_password_msg").innerText = "";
	document.getElementById("login_password").value = "";
	document.getElementById("login_password_msg").innerText = "";
	document.getElementById("cfm_login_password").value = "";
	document.getElementById("cfm_login_password_msg").innerText = "";
}
</script>
</html>