<!--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"-->
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.lang.*"%>
<%@ page import="java.util.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	
	String loginNo = (String)session.getAttribute("loginNo");
	if(loginNo == null){
		response.sendRedirect("login.htm");
		return;
	}


	//取session值
	String login_no   = (String)session.getAttribute("loginNo");
	String login_name = (String)session.getAttribute("loginName");
%>

<html xmlns="http://www.w3.org/1999/xhtml">		
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>报表系统</title>
	<link href="<%=request.getContextPath()%>/nresources/UI/css/framework.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/UI/css/rightmenu.css" rel="stylesheet" type="text/css" />
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/njs/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/njs/easyui/themes/icon.css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/njs/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/njs/easyui/jquery.easyui.min.js"></script>

<style>
#navPanel {
    background: none repeat scroll 0 0 #f3f8f9;
    border: 1px solid #257abb;
    display: inline;
    float: left;
    margin-right: 4px;
    margin-top: -1px;
    overflow: hidden;
    float: left;
    height: 99%;
    width: 198px;
}
#tabbedPanel {
    background: none repeat scroll 0 0 #f3f8f9;
    border: 1px solid #257abb;
    display: block;
    height: 99%;
    overflow: hidden;
}

</style>

<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>
	
</head>
<body class="easyui-layout" style="text-align:left">

	
	
	<!--topPanel begin-->
	<div region="north" border="false" style="background:url(../../nresources/UI/images/framework.png) repeat-x scroll left -51px;text-align:center" id="topPanel">
	<div id="menuPanel">
		<div class="head-logo">
		</div>
		
		<ul class="rightexit">
			<div class="exit" onclick="javascript:closeWindow()" title="退出">
		</ul>
	</div>
</div>
	<!--topPanel end-->
	

		<!--  begin  navPanel -->
		<div  region="west" split="true" title="用户功能树-<%=login_no %>" style="width:25%;padding:5px;">

				<div id="navTree" class="easyui-tree">
				</div>
		</div>
		<!--  end navPanel -->
		
		<!--workPanel begin-->
	<div region="center" id="tabbedPanel" fit="true" border="false" class="easyui-tabs">
		<div title="Home">
		<iframe align="left"  class="workIframe"  id="ifram" src="../portal/work/portal.jsp" frameborder="0" scrolling="yes" style="width:75%;height:100%">
		</iframe>
		</div>
	</div>
		<!--workPanel end-->
		

	
	

<div id="currUserId" style="display:none"></div>

<script language="javascript" type="text/javascript">

		
$(function(){
	$.ajax({
		url:'../../getfuncmenu.do',
		method:'post',
		cache:false,
		data: {loginno:""},
		dataType: "json",
        success: function (data){
        	//console.log("out:"+JSON.stringify(data));
        	if(data.ret == 0){
        		initTree(data);
        	}else{
        		showmsg("get data failed:"+data.ret + ":"+data.msg);
        	}
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            showmsg("failed:"+errorThrown);
        }
	})
});

function initTree(data){
	$('#navTree').tree('append', {
		//parent: root.target,
		data: data.data
	});	
	
	$('#navTree').tree({
		lines:true,
		onClick: function(n){
			//console.log(n.text + ":" + n.id + ":" + n.attr_action + "=="+n.pos);
			if(n.attr_action)
				openTab(n.attr_opcode, n.attr_proid, n.text, n.attr_action, n.pos);
		}
	})
}


	
function openTab(opCode, proId, title, targetUrl, opName)
{	
	targetUrl = "<%=request.getContextPath()%>/npage/"+targetUrl;
	targetUrl=targetUrl+"?opCode="+opCode+"&opName="+encodeURI(opName)+"&proId="+proId+"&provinceCode=-1&tellType=-1";
	
	if ($('#tabbedPanel').tabs('exists', title)){
		$('#tabbedPanel').tabs('select', title);
	} else {
		var content = '<iframe scrolling="auto" frameborder="solid 1px" src="'+targetUrl+'" style="width:75%;height:100%;overflow:scroll;"></iframe>';
		$('#tabbedPanel').tabs('add',{
			title:title,
			content:content,
			closable:true
		});
	}
}



function closeWindow(){
	loading("正在退出");
	$.post('logout.jsp', {}, function(result){
		unLoading('ajaxLoadingDiv');
		window.location = 'login.htm';
	});
}



</script>	

</body>
</html>