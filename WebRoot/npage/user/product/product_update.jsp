<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
 
<html>
<head>
<title>修改产品信息</title>
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
		<form action="" method="post" name="hostForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="productCode" id="productCode" value="${romProCode.proCode}">
 			
			<div class="input">
				<table width="100%" border="0" cellspacing="2" cellpadding="0"  bgcolor="#FFFFFF">
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;"><font color="red">*产品名称：</font></td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;">
							<input type="text" name="proName" id="proName"  value="${romProCode.proName}" v_maxlength="64" v_minlength="0" class="anc"/>
						</td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;"><font color="red">*产品版本：</font></td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;">
							<input type="text" name="proVersion" id="proVersion"  value="${romProCode.proVersion}" v_maxlength="64" v_minlength="0" class="anc"/>
						</td>				
					</tr>
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">备注：</td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;" colspan="3">
							<input type="text" name="remarks" id="remarks"  value="${romProCode.remarks}" v_maxlength="64" v_minlength="0" class="anc" style="width:580px;"/>
						</td> 				
					</tr>	
      				<tr height="12"></tr>
					<tr>
			          <td height="32" align="center" class="blue" colspan="6">
			            <input name="su" type="button" class="bb_right_sub1" value="确  定" onclick="updateProductSubmit()"/>&nbsp;&nbsp;&nbsp;
			            <input name="re" type="button" class="bb_right_sub1" value="重  置" onclick="doReset()"/>&nbsp;&nbsp;&nbsp;
						<input name="close" type="button" class="bb_right_sub1" value="关  闭" onclick="parent.doSrchSubmit();parent.removeDivWin('divWin');"/>
						</td>	
					</tr>										
				</table>
			</div>
			<div align="center">
			    <font color="red"><span id="succInfo">${operInfo}</span></font>
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
});

function doReset(){
	$('#proName').val('');
	$('#proVersion').val('');
	$('#remarks').val('');
}

function updateProductSubmit(){
	$('#proName').val($.trim($('#proName').val()));
	$('#proVersion').val($.trim($('#proVersion').val()));
	
    if(!checksubmit(hostForm)){
		return false;
	}
	document.hostForm.action='<%=request.getContextPath()%>/updateProduct.do';
	document.hostForm.submit();
	
}
</script>
</body>
</html>