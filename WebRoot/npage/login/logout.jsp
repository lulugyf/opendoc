<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML Strict//EN">
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String themePath = (String)session.getAttribute("themePath");
  session.invalidate();
%>
<HTML >
<HEAD>
<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/block.css" rel="stylesheet" type="text/css" />
	<style>
	html,body{
		margin:0px;
		padding:0px;
		background: #fdffff url('<%=request.getContextPath()%>/nresources/<%=themePath%>/images/loading_bg.gif') repeat-x;
		overflow:hidden;
	}
</style> 
	<script>
	function startTimer(){
		setTimeout("exit()",2000);
	}
	function exit(){
		window.close();
	}
</script>
</HEAD>
<BODY  onload=startTimer()>

<DIV class="ajax_window" id="ajaxLodingDiv" style11="FILTER: progid:DXImageTransform.Microsoft.Shadow(Color=#666666,Direction=120,strength=4); LEFT:0px;TOP:0px" >
 <DIV class="ajax_wait">
  正在退出，请稍候......
  <DIV class="loading_gif">
  </DIV>
 </DIV>
</DIV>

</BODY>
</HTML>