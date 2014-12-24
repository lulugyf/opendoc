<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body style="border:5px solid #0000ff">

<h1>Request Parameters:</h1>
   <ul>
   <%
 		java.util.Enumeration enu = request.getParameterNames();
		while(enu.hasMoreElements()){
			String p = (String)enu.nextElement();
			String v = request.getParameter(p);
			out.println("<li>"+p+" = "+ v+"</li>");
		}  
   %>

 
 	</ul>
	
	some content here <%=request.getRealPath("path")%>
  </body>

</html>
