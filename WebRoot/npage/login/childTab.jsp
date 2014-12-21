<%@ page contentType="text/html;charset=GBK" %>
<%
	String themePath = (String)session.getAttribute("themePath");
	String hotkey = (String)session.getAttribute("hotkey");
	
	String gCustId = request.getParameter("gCustId");
	String loginType = request.getParameter("loginType");
	String phone_no = request.getParameter("phone_no");
	if(gCustId==null||gCustId.equals(""))
	{
		out.println("号码信息不正确,请重新输入");
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<title>客户首页</title>
	<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/block.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/common.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/tabcss/tabStyle.css" rel="stylesheet" type="text/css" />
	<style>
	html,body
	{
		overflow:hidden;
	}
	</style>
</head>
<body>
		<div id="tabset_child">
			<div id="tabset">
				<div id="tab" >
					<ul id="tabtag">
						<li id="child_index" class="current"><span class="fristab">客户首页</span></li>
					</ul>
					<div class="clr"></div>
				</div>
				<span class="first"><img src="<%=request.getContextPath()%>/nresources/<%=themePath%>/images/tabimages/btn_left.gif"  onclick="BtnMoveLeft(event)" id="imgLeft" /></span>
				<span class="next"><img src="<%=request.getContextPath()%>/nresources/<%=themePath%>/images/tabimages/btn_right.gif" onclick="BtnMoveRight(event)"  id="imgRight" /></span>
				<div class="clr"></div>
				<dl id="contentArea">
					<dt class="on">
						<iframe align="left" name="false" class="userIframe" id="user_index" frameborder="0" scrolling="auto" src="../portal/cust/portal.jsp?gCustId=<%=gCustId%>&loginType=<%=loginType%>&phone_no=<%=phone_no%>"  scrolling="yes"  width="100%" height="100%">
						</iframe>
					</dt>
				</dl>
				<div class="clr"></div>
			</div>
	</div>
	
<script src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>	
	<script src="<%=request.getContextPath()%>/njs/plugins/tabScript_jsa.js" type="text/javascript"></script>
	
	
	<script language="javascript" type="text/javascript">
		window.onresize=function()
		{
	 		setChildIframe();  
	  }
	  $(document).ready(function(){
	  	setChildIframe();
			if(parent.document.getElementById("lock").className=="key")
			{
				parent.quicknav(parent.content_array[parent.document.getElementById('tb_h').value]);
			}
	  	
	  	})
		//window.onload=function(){}
		
		//设置二级TAB内iframe高度
		function setChildIframe()
		{
			var g = document.getElementById;
			var g_posHeight=55;//一级和二级tab高度和
			var workPanel=parent.g("workPanel");
			var workPanelHeight=workPanel.clientHeight;
			//var ua = navigator.userAgent;
			//if(/msie 6/i.test(ua)) 
			//workPanelHeight=workPanelHeight-30;
			var subIframe=g("contentArea").getElementsByTagName("iframe");
			for(var i=0;i<subIframe.length;i++)
			{
				subIframe[i].style.height=(workPanelHeight-g_posHeight)+"px";
			}
		}
	</script>
</body>
</html>