<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>工号密码管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<div id="operation">
	<form method="post" name="frm" action="">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		
		<div id="operation_table">
			<div class="title">
				<div class="text">
					工号密码复位
				</div>
			</div>
			<div class="input">
				<table>
					<tr>
						<th>*工号</th>
						<td>
							<input type="text" id="r_login_no" name="r_login_no" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
							<span><font id="r_login_no_msg" color="red"></font></span>
						</td>
					</tr>
				</table>
			</div>
			
			<div id="operation_button">
				<input type="button" value="确定" id="btnOK" name="btnOK" onclick="pwdReset()" class="b_foot_long"/>
				<input type="button" value="重置" id="btnReset" name="btnReset" onclick="exeReset()" class="b_foot_long"/>
				<input type="button" value="关闭" id="btnClose" name="btnClose" onclick="removeCurrentTab()" class="b_foot_long"/>
			</div>
			
			<div align="center">
			    <font color="red"><span id="operInfo">${operInfo}</span></font>
			</div>
		</div>
		<%@ include file="/npage/include/footer.jsp"%>
	</form>
</div>
					
</body>
<script type="text/javascript">

/**
 * 密码复位
 */
function pwdReset() {

	if(!checksubmit(frm)){
		return false;
	}
	
	document.forms['frm'].action='<%=request.getContextPath()%>/resetPassword.do';
	document.forms['frm'].submit();
}

/**
 * 重置
 */
function exeReset() {
	document.getElementById("r_login_no").value = "";
	document.getElementById("r_login_no_msg").innerText = "";
}
</script>
</html>