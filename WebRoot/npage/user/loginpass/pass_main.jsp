<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
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
</head>
<body>

	<form method="post" name="frm" action="">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<div id="operation" class="bb_right_cont1">
		      <div height="12"><table><tr height="12"></tr></table> </div>
						<table width="100%" border="0" cellspacing="2" cellpadding="0"  bgcolor="#FFFFFF">
							<tr>
								<th width="7%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">工号密码复位：</th>
								<td width="7%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">工号：</td>
								<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
									<input type="text" id="r_login_no" name="r_login_no" v_maxlength="64" v_minlength="0" class="anc"/>
									<span><font id="r_login_no_msg" color="red"></font></span>
								</td>
							</tr>
		      				<tr height="12"></tr>
							<tr>
					        	<td height="32" align="center" class="blue" colspan="3">
					            	<input name="btnOK" type="button" id="btnOK" class="bb_right_sub1" value="确  定" onclick="pwdReset()"/>&nbsp;&nbsp;&nbsp;
					            	<input name="btnReset" type="button" id="btnReset" class="bb_right_sub1" value="重  置" onclick="exeReset()"/>
								</td>
					        </tr>
						</table>
					
					<div align="center">
					    <font color="red"><span id="operInfo">${operInfo}</span></font>
					</div>
				<%@ include file="/npage/include/footer.jsp"%>
		</div>
	</form>
					
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