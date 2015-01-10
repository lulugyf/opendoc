<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'index.jsp' starting page</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/njs/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/njs/easyui/themes/icon.css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/njs/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/njs/easyui/jquery.easyui.min.js"></script>
  </head>
  
 <body class="easyui-layout">
	<div region="north" border="false" style="height:40px;background:#B3DFDA;padding:10px">north region</div>
	<div data-options="region:'west',split:true,collapse:false" title="West" style="width:150px;padding:10px;">west region</div>
	<!-- <div region="east" split="true" title="East" style="width:100px;padding:10px;">east region</div>
	<div region="south" border="false" style="height:50px;background:#A9FACD;padding:10px;">south region</div> -->
	<div region="center" title="Main Title">
	</div>
</body>


<script>
$(function(){
	var p = $('body').layout('panel','west').panel({
		onCollapse:function(){
			alert('collapse');
		},
		onExpand:function(){
			alert('expand');
		},
		onResize:function(){
			console.log("resize");
		}
	});
});
</script>
</html>
