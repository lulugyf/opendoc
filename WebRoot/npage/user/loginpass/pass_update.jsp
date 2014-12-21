<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>工号密码管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<% String loginNo = session.getAttribute("loginNo").toString(); %>
</head>
<body>

<div id="operation">
	<form method="post" name="frm" action="">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		  <div id="operation_table">
				<div class="title">
					<div class="text">
						工号密码修改
					</div>
				</div>
				<div class="input">
					<table>
						<tr>
							<th>*工号</th>
							<td>
								<%=loginNo %>
							</td>
						</tr>
						<tr>
							<th>*原始密码</th>
							<td>
								<input type="password" id="pre_login_password" name="pre_login_password" class="required isCharLengthOf" v_maxlength="64" v_minlength="6"/>
								<span><font id="pre_login_password_msg" color="red"></font></span>
							</td>
						</tr>
						<tr>
							<th>*新密码</th>
							<td>
								<input type="password" id="login_password" name="login_password" class="required isCharLengthOf" v_maxlength="64" v_minlength="6"/>
								<span><font id="login_password_msg" color="red"></font></span>
							</td>
						</tr>
						<tr>
							<th>*确认密码</th>
							<td>
								<input type="password" id="cfm_login_password" name="cfm_login_password" class="required isCharLengthOf" v_maxlength="64" v_minlength="6"/>
								<span><font id="cfm_login_password_msg" color="red"></font></span>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<div id="operation_button">
				<input type="button" value="确定" id="btnOK" name="btnOK" onclick="pwdModify()" class="b_foot_long"/>
				<input type="button" value="重置" id="btnReset" name="btnReset" onclick="exeReset()" class="b_foot_long"/>
				<input type="button" value="关闭" id="btnClose" name="btnClose" onclick="parent.removeDivWin('divWin');" class="b_foot_long"/>
			</div>
		</div>
		<%@ include file="/npage/include/footer.jsp"%>
	</form>
</div>
					
</body>
<script type="text/javascript">
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
		showDialog("密码修改成功！", 2);
		exeReset();
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