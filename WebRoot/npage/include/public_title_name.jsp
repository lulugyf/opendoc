<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--@ taglib uri="/WEB-INF/xservice.tld" prefix="s" --%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	//防止直接输入URL进入模块页面
	String refererProxy=request.getHeader("referer");

	if(null==refererProxy||"".equals(refererProxy))
	{
		%>
			<script language="javascript">
				if(typeof(opener) == "undefined")
				{
						  alert("禁止非法进入页面!");
						  window.opener=null;
						  window.open("","_self");
              window.close();	
        }
			</script>
		<%
	}
%>
<%
String themePath = (String)session.getAttribute("themePath");

String opCode  = request.getParameter("opCode");
String opName  = request.getParameter("opName");
String proId   = request.getParameter("proId");

response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>
<!--link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/FormText.css" rel="stylesheet" type="text/css" />   -->
<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/block.css" rel="stylesheet" type="text/css" />

