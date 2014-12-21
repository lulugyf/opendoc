<%@ page contentType="text/html;charset=UTF-8" %>
<%@page isErrorPage="true" %>
<%
		String themePath = (String)session.getAttribute("themePath");
		
		String errorMess="该FTP站点配置错误，请重新配置！";
		
%>
<html>
<head>
<title>操作错误</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/errorpanel.css" rel="stylesheet" type="text/css" >

</head>

<body>
<div class="errorPanel">
	<div class="box">
		<h1 class="title">操作失败！</h1>
		<p class="msg"><%=errorMess%></p>
	</div>

</div>
</body>
</html>
