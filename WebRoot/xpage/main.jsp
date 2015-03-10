<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页</title>
<link rel="stylesheet" type="text/css" href="style/conf_style.css"/>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/menu_min.js"></script>

<script type="text/javascript">
$(document).ready(function (){ 
	$.ajax({
		url: '../getfuncmenu.do',
		method: 'post',
		cache: false,
		data: {loginno:"", type:"html"},
		dataType: "text",
        success: function (data){
        	//console.log("out:"+data);
        	$('#leftMenu').append(data);
        	$(".leftMenu ul li").menu();
        	
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            //console.log("failed:"+errorThrown);
        }
	})
  //$(".leftMenu ul li").menu();
	
	resizeTabs();
	
	$(window).resize(resizeTabs);
	
	$('.tabs-scroller-left').click(function(){
		tabs_left(this);
	});
	$('.tabs-scroller-right').click(function(){
		tabs_right(this);
	});

}); 
</script>
<script>
var panel_expanded = true;
var panel_width = 275;

$(function(){
	$('.mainWiap').css('left','0');
	$('.bar').click(function(){
		if (panel_expanded) {
			$('.mainWiap').animate({left:'-'+panel_width+'px'},500, "linear", resizeTabs);
			$('.bar').css('background-position','-17px 0px');
			$("#mainright").width($(window).width()-0).animate({left:'0px'},500);
	
		}else {
			$('.mainWiap').animate({left:'0'},500, "linear", resizeTabs);
			$('.bar').css('background-position','0px 0px');
			$("#mainright").width($(window).width()-panel_width-1).animate({left:(panel_width+1)+'px'},"fast");
		}
		panel_expanded = !panel_expanded;
		//resizeTabs();
	});
});



function closeWindow(){
	$.ajax({
		url: '../npage/login/logout.jsp',
		method: 'post',
		cache: false,
		data: {loginno:""},
		dataType: "text",
        success: function (data){
        	window.location = '../npage/login/login.htm';
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            //console.log("failed:"+errorThrown);
        }
	})
}

function resizeTabs(){
	var h = $(window).height() - $('.topWiap').height() - $('.topSub').height();
	var w = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
	if(panel_expanded){
		w -= panel_width;
	}
	$('#mainright').width(w);
	//window.console.log("resizeTabs: "+w + " * " + h);
	//$('.tabDiv .tabFrm').each(function(i, p){
	$('.tabFrm').each(function(i, p){
		$(p).height(h).width(w);
	});
	
	checkTabs();
}
</script>
</head>
<body style="overflow:hidden" scroll="no" oncontextmenu="return false" onselectstart="return false" ondragstart="return false" onbeforecopy="return false">
<div class="backmain">
  <!--左边-->
  <div class="mainWiap">
    <div class="mainWiap2">
      <div class="bar"><a href="javascript:"></a></div>
      <div id="Container">
        <div class="logo"><img src="images/logo.png" width="275" height="91" /></div>
        <div class="leftMenu" id='leftMenu'>
          
        </div>
      </div>
    </div>
  </div>
  <!--左边 end-->
  <!--右边-->
  <div class="right_main" id="mainright">
    <div class="topWiap">
      <ul>
        <li class="out"><a href="javascript:closeWindow()" title="退出">退出</a></li>
        <li class="pwd"><a href="#">修改密码</a></li>
        <li class="name">工号：<%=session.getAttribute("loginNo") %> &nbsp;&nbsp;&nbsp; 用户名：RedTree IT Solution</li>
      </ul>
    </div>
<div class="topSub f14">
	<div class="tabs-scroller-left" style="display: none; height: 34px;"></div>
	<div class="tabs-scroller-right" style="display: none; height: 34px;"></div>
	<div class="tabs-wrap" style="margin-left: 0px; margin-right: 0px;">
  <ul class="tabs">
  	<li class="tabhead sel" opCode="123"><a href='#' onclick='switchTab(this)'>用户首页</a></li>
  </ul>
  </div>
  
</div>

<div class="tabDiv" style="display:block; width: 100%;">
    <iframe class="tabFrm" src="home.html" scrolling="no" frameborder="0"  marginwidth="0"  marginheight="0" width="100%"></iframe>
</div>

  </div>
  <!--右边 end-->
</div>
<script type="text/javascript">
function tabs_left(self){
	//window.console.log('===['+$('.tabs').css('marginLeft')+']');

	if($('.tabs').css('marginLeft') == '0px')
		return;
	$('.tabs').animate({'marginLeft':'+=80'});
	
	
}

function tabs_right(self){
	//var p = $('.tabs').position();
	
	var w1 = 0;
	$('.tabhead').each(function(i, p){
		w1 += $(p).width() + 79; // + padding width
	});
	var w2 = $('.tabs-wrap').width();
	var sleft = $('.tabs').css('marginLeft');
	var nleft = parseInt(sleft.substring(0, sleft.indexOf('px')));
	if(w1+nleft < w2)
		return;
	
	
	$('.tabs').animate({'marginLeft':'-=80'});
}

function switchTab(obj){
	var x = $(obj).parent('li');
	if(x.hasClass('sel'))
		return;
	var i1 = $('.tabhead').index(x);
	selTab(i1);
}

function selTab(i1){
	var i0 = 0;
	$('.tabhead').each(function(i, p){
		y = $(p);
		if(y.hasClass('sel')){
			y.removeClass('sel');
			i0 = i;
		}
	});
	$($('.tabhead').get(i1)).addClass('sel');
	$($('.tabDiv').get(i0)).hide();
	$($('.tabDiv').get(i1)).show();
	
	checkTabs();
}

// 检查tab 标签的宽度是否超出显示区域， 需要显示出 < > 按钮来左右滚动
function checkTabs() {

	var w1 = 0;
	$('.tabhead').each(function(i, p){
		w1 += $(p).width() + 79; // + padding width
	});
	var w2 = $('#mainright').width();
	if(w1+40 < w2){
		$('.tabs-scroller-left').hide();
		$('.tabs-scroller-right').hide();
		
		$('.tabs-wrap').css('margin-left', '0px').css('margin-right', '0px').css('width', '100%');
		$('.tabs').css('marginLeft', '0px');
			
		//$('li.tabhead:hidden').show();
		return;
	}
	$('.tabs-scroller-left').show();
	$('.tabs-scroller-right').show();
	$('.tabs-wrap').css('margin-left', '20px').css('margin-right', '20px').css('width', w2-40);	
}

function closeTab(obj){
	var x = $(obj).parents('li');
	var i = $('.tabhead').index(x);
	//console.log('----'+i);
	if(x.hasClass('sel')){
		x.prev().addClass('sel');
		$($('.tabDiv').get(i-1)).show();
	}
	x.remove();
	$('.tabDiv').get(i).remove();
	checkTabs();
}

function openTab(title, proid, opcode, action){
	var found = -1;
	$('.tabhead').each(function(i, p){
		if($(p).attr('opCode') == opcode){
			found = i;
		}
	});
	if(found >= 0){
		selTab(found);
		return;
	}
	//console.log('----'+title);
	$('.tabhead').last().after("    <li class='tabhead' opCode='"+opcode+"'><a href='#' onclick='switchTab(this)'>"+title+"</a> "+
		      "<div class='close'><a href='#' onclick='closeTab(this)' title='关闭'>关闭</a></div>"+
		      "</li>");
	$('.tabDiv').last().after('<div class="tabDiv" style="display:none; width: 100%;">'+
		    '<iframe class="tabFrm" src="'+action+'?opCode='+opcode+'&proId='+proid+'&provinceCode=-1&tellType=-1&opName=aaa-aaa-aaa-aaa" scrolling="no" frameborder="0" marginwidth="0"  marginheight="0" width="100%"></iframe>'+
		    '</div>');
	selTab($('.tabhead').length-1);
	
	height1 = $('.tabDiv').first().height();
	$('.tabDiv').last().height(height1);
	$('.tabFrm').last().height(height1);
	//opCode=2202&opName=报表-报表系统-数据同步任务-任务配置-任务配置&proId=P001&provinceCode=-1&tellType=-1
}
</script>

<script type="text/javascript" src="js/frame.js"></script>
</body>
</html>
