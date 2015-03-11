<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>报表系统</title>
<link rel="stylesheet" type="text/css" href="../../style/conf_style.css"/>
<script type="text/javascript" src="../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../js/menu_min.js"></script>
<script type="text/javascript">
$(document).ready(function (){ 
  
  $(".leftMenu ul li").menu();
  
}); 
</script>
<script>
$(function(){
$('.mainWiap').css('left','0');
var expanded = true;
$('.bar').click(function(){
	if (expanded) {
		$('.mainWiap').animate({left:'-275px'},500);
		$('.bar').css('background-position','-17px 0px');
		$("#mainright").width($(window).width()-0).animate({left:'0px'},500);

	}else {
		$('.mainWiap').animate({left:'0'},500);
		$('.bar').css('background-position','0px 0px');
		$("#mainright").width($(window).width()-276).animate({left:'276px'},"fast");
	}
	expanded = !expanded;
});
});
</script>
</head>
<body style="overflow:hidden" scroll="no" oncontextmenu="return false" onselectstart="return false" ondragstart="return false" onbeforecopy="return false">
<div class="backmain">
  <!--左边-->
  <div class="mainWiap">
    <div class="mainWiap2">
      <div class="bar"><a href="javascript:"></a></div>
      <div id="Container">
        <div class="logo"><img src="../../images/logo.png" width="275" height="91" /></div>
        <div class="leftMenu">
          <ul>
            <li> <a class="active" href="#sub1">报表系统</a>
              <ul style="display:none;">
                <li> <a href="#sub2">数据同步任务</a>
                  <ul>
                    <li><a href="报表参数配置.html" target="MainFrame"><em>任务配置</em></a></li>
                    <li><a href="报表配置.html" target="MainFrame"><em>任务结果查看</em></a></li>
                    <li><a href="参数与用户关联配置.html" target="MainFrame"><em>数据连接配置</em></a></li>
                  </ul>
                </li>
                <li> <a href="#sub2">数据同步任务</a>
                  <ul>
                    <li><a href="报表参数配置.html" target="MainFrame"><em>任务配置</em></a></li>
                    <li><a href="报表配置.html" target="MainFrame"><em>任务结果查看</em></a></li>
                    <li><a href="参数与用户关联配置.html" target="MainFrame"><em>数据连接配置</em></a></li>
                  </ul>
                </li>
                <li> <a href="#sub2">数据同步任务</a>
                  <ul>
                    <li><a href="报表参数配置.html" target="MainFrame"><em>任务配置</em></a></li>
                    <li><a href="报表配置.html" target="MainFrame"><em>任务结果查看</em></a></li>
                    <li><a href="参数与用户关联配置.html" target="MainFrame"><em>数据连接配置</em></a></li>
                  </ul>
                </li>
              </ul>
            </li>
            <li> <a class="active" href="#sub1">测试系统</a>
              <ul style="display:none;">
                <li> <a href="#sub2">数据同步任务</a>
                  <ul>
                    <li><a href="报表参数配置.html" target="MainFrame"><em>任务配置</em></a></li>
                    <li><a href="报表配置.html" target="MainFrame"><em>任务结果查看</em></a></li>
                    <li><a href="参数与用户关联配置.html" target="MainFrame"><em>数据连接配置</em></a></li>
                  </ul>
                </li>
                <li> <a href="#sub2">数据同步任务2</a>
                  <ul>
                    <li><a href="报表参数配置.html" target="MainFrame"><em>任务配置</em></a></li>
                    <li><a href="报表配置.html" target="MainFrame"><em>任务结果查看</em></a></li>
                    <li><a href="参数与用户关联配置2.html" target="MainFrame"><em>数据连接配置2</em></a></li>
                  </ul>
                </li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  <!--左边 end-->
  <!--右边-->
  <div class="right_main" id="mainright">
    <div class="topWiap">
      <ul>
        <li class="out"><a href="#" title="退出">退出</a></li>
        <li class="pwd"><a href="#">修改密码</a></li>
        <li class="name">工号：RedTree &nbsp;&nbsp;&nbsp; 用户名：RedTree IT Solution</li>
      </ul>
    </div>
    <iframe src="../../home.html" name="MainFrame" id="MainFrame" frameborder="no" scrolling="no"  marginwidth="0"  marginheight="0" width="100%"></iframe>
  </div>
  <!--右边 end-->
</div>
<script type="text/javascript" src="../../js/frame.js"></script>
</body>
</html>
