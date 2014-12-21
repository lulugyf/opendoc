<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>

<%
String result=(String)request.getAttribute("result");
%>
<html>
<head>
<title>执行工单脚本</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm">
		
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<div class="input">
				<table>
  				
					<tr>
						<th>执行结果：</th>
						<td>
						    <textarea id="cmdResult" name="cmdResult" style="width:99%;color:orange;font-size:12px" rows="15" readonly="true"></textarea>
						</td>
					</tr>				
					
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="close" onClick="parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
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
	$('#cmdResult').html('${result}');
 	$('#cmdResult').unbind( "blur" ); //规避校验
});

</script>
</body>
</html>