<%@ page contentType="text/html;charset=UTF-8" %>
<%@page isErrorPage="true" %>
<%
		String themePath = (String)session.getAttribute("themePath");
		
		if(session.getAttribute("loginNo")==null){//session为空
			session.invalidate();
		}
		
		String errorMess="对不起，您没有足够的权限进行操作！如有任何问题，请与系统管理员联系！";
		Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
		Cookie cookie;
		long loginTimeTip=0;
		for(int i=0; i<cookies.length; i++){
		    cookie = (Cookie)cookies[i];
		    
		    if(cookie.getName().equals("loginTimeTip")){
		        try{
		            loginTimeTip = Long.parseLong(cookie.getValue());
		        }catch(Exception e){
		            e.printStackTrace();
		        }
		        break;
		    }
		}
		
		// 当前时间-登录时间>session失效时间
		if(loginTimeTip>0 && (System.currentTimeMillis()-loginTimeTip)<60*60*1000){
		    errorMess="您的工号在另一地点登录，您被迫退出！如有任何问题，请与系统管理员联系。";
		}
		
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
