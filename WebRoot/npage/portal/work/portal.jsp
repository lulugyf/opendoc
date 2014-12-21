<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

	String themePath = (String)session.getAttribute("themePath");
%>
<head>
	<meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
	<title>工作空间</title>
	<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/portal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/block.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/rightmenu.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/calendar.css" rel="stylesheet" type="text/css"/>
</head>

<body id="work-portal">
	
	<div id="page-warp">
		<div id="info">
			<div class="item">
				<div class="caption">
					<div class="ico_work"></div>
					<ul class="titTab">
						<li class="current"><a href="#">我的信息</a></li>
					</ul>
				</div>
				<div class="content" style="text-align:left">
					工号：<c:out value="${loginNo}"></c:out>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					用户名：<c:out value="${loginName}"></c:out>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="javascript:gotoUpdatePass()">修改密码</a>
				</div>
		    </div>
		</div>
		
  <!-- div id="more-info-items">		
	<ul id="dragsort1" class="item-col col-1">
	  <li>	
		<div class="item" id="item2">
		<!--%@ include file="hotkey.jsp"%-->
		</div>
	  </li>
	</ul>
</div -->	
	
	<div class="rightmenu" id="favMenu" style="display:none">
		<ul>
			<li id="delIcon"><span class="del"></span>删除</li>
			<li id="editIcon"><span class="edit"></span>设置快捷键</li>
			<li id="helpIcon"><span class="todo"></span>在线帮助</li>
		</ul>
	</div>
<!--script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/drag.js" defer></script-->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/uif.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/system/system.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script language="javaScript">
function gotoUpdatePass(){
	openDivWin("<%=request.getContextPath()%>/gotoUpdatePass.do","修改密码","700","300");
}
</script>	
</body>

</html>
