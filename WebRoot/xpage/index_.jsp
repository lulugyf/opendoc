<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
		data: {loginno:""},
		dataType: "text",
        success: function (data){
        	//console.log("out:"+data);
        	$('#leftMenu').append(data);
        	$(".leftMenu ul li").menu();
        	
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log("failed:"+errorThrown);
        }
	})
	
  //$(".leftMenu ul li").menu();
  
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
        <div class="logo"><img src="images/logo.png" width="275" height="91" /></div>
        <div class="leftMenu" id="leftMenu">
                    
          
        </div>
      </div>
    </div>
  </div>
  <!--左边 end-->
  <!--右边-->
  <div class="right_main" id="mainright">
    <iframe src="home.html" name="MainFrame" id="MainFrame" frameborder="no" scrolling="no"  marginwidth="0"  marginheight="0" width="100%"></iframe>
  </div>
  <!--右边 end-->
</div>
<script type="text/javascript" src="js/frame.js"></script>

</body>

</html>
