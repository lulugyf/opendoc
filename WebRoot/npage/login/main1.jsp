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

<html>		
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>报表系统</title>
	<link href="<%=request.getContextPath()%>/nresources/UI/css/framework.css" rel="stylesheet" type="text/css" />
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/njs/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/njs/easyui/themes/icon.css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/njs/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/njs/easyui/jquery.easyui.min.js"></script>

<style>
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
<body class="easyui-layout" style="text-align:left" onresize="resizebody()">
	<!--topPanel begin-->
<div data-options="region: 'north'" style="border:false; height:34px; background:url(../../nresources/UI/images/framework.png) repeat-x scroll left -51px;text-align:center" id="topPanel">
	<div id="menuPanel">
		<div class="head-logo">
		</div>
		
		<ul class="rightexit">
			<div class="exit" onclick="javascript:closeWindow()" title="退出">
		</ul>
	</div>
</div>
	<!--topPanel end-->
		

<div data-options="region:'west',collapsed:false,split:true" id="westdiv" title="用户功能树-<%=login_no %>" style="width:200px;padding:5px;">
		<div id="navTree" class="easyui-tree">
		</div>
</div>
		
		<!--workPanel begin-->
	<div data-options="region:'center', fit:true" id="tabbedPanel" style="border: false" class="easyui-tabs">
		<div title="Home" class="tabpane" style="width:400px;height:300px;border:0px solid #ff0000">
		<iframe class="workIframe" id="ifram" src="../portal/work/portal.jsp" style="align:left;border:0px solid #0000ff"> </iframe>
		
		</div>
	</div>

		<!--workPanel end-->

<script language="javascript" type="text/javascript">


function initTree(data){
	$('#navTree').tree('append', {
		//parent: root.target,
		data: data.data
	});	
	
	$('#navTree').tree({
		lines:true,
		onClick: function(n){
			console.log(n.text + ":" + n.id + ":" + n.attr_action + "=="+n.pos);
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
		var content = '<iframe scrolling="auto" class="workIframe" src="'+targetUrl+'" style="overflow:scroll;border:0px solid #ff0000"></iframe>';
		//console.log(content);
		$('#tabbedPanel').tabs('add',{
			title:title,
			content:content,
			closable:true
		});
		resizebody();
	}
}

(function($,h,c){var a=$([]),e=$.resize=$.extend($.resize,{}),i,k="setTimeout",j="resize",d=j+"-special-event",b="delay",f="throttleWindow";e[b]=250;e[f]=true;$.event.special[j]={setup:function(){if(!e[f]&&this[k]){return false}var l=$(this);a=a.add(l);$.data(this,d,{w:l.width(),h:l.height()});if(a.length===1){g()}},teardown:function(){if(!e[f]&&this[k]){return false}var l=$(this);a=a.not(l);l.removeData(d);if(!a.length){clearTimeout(i)}},add:function(l){if(!e[f]&&this[k]){return false}var n;function m(s,o,p){var q=$(this),r=$.data(this,d);r.w=o!==c?o:q.width();r.h=p!==c?p:q.height();n.apply(this,arguments)}if($.isFunction(l)){n=l;return m}else{n=l.handler;l.handler=m}}};function g(){i=h[k](function(){a.each(function(){var n=$(this),m=n.width(),l=n.height(),o=$.data(this,d);if(m!==o.w||l!==o.h){n.trigger(j,[o.w=m,o.h=l])}});g()},e[b])}})(jQuery,this);




function resizebody(){
	var p0 = $('#westdiv');
	var w = $(window);
	var wwidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth; //$(window).innerWidth();
	
	if($('#westdiv:visible').length == 0){ //nav div collapsed
		$('.workIframe').each(function(i, p){
			var x = $(p);
			x.width(wwidth-34);
			x.height(p0.height());
		});
	}else{
		$('.workIframe').each(function(i, p){
			var x = $(p);
			x.width(wwidth-p0.width()-24);
			x.height(p0.height());
		});
	}
	//var p = $('#ifram');
	//console.log("ifram width:"+p.width() + " window.width:"+wwidth);
}

$(function(){
	resizebody();
	$('#westdiv').resize(resizebody);

	$('body').layout('panel','west').panel({
		onCollapse:function(){
			resizebody();
		},
		onExpand:function(){
			resizebody();
		}
	});
	
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