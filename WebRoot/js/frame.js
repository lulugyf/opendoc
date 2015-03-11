var scroller  = null;
var scrollbar = null;

$(document).ready(function(){
  rz();
  $(window).resize(function () { 
   rz();
  });
});

function rz(){
 var h=$(window).height()-$("#topframe").height()-$("#bottomframe").height();
 $("#Container").height(h);
 $(".Scrollbar-Track").height(h);
 $(".backmain").height(h);
 $("#mainright").width($(window).width()-276)
 $("#MainFrame").height(h-0);
  
  if (navigator.userAgent.indexOf('Firefox') >= 0 || !-[1,]&&!window.XMLHttpRequest){ //firefox ie6浏览器左边出现滚动条
    $("#News").attr("style","overflow-x:hidden;overflow-y:auto;height:"+h+"px");
	$("#About").attr("style","overflow:visible");
	$("#Extra").attr("style","overflow:visible");
	$("#Scrollbar-Container").hide();
  }else{
    scroller  = new jsScroller(document.getElementById("News"), 400, 180);
    scrollbar = new jsScrollbar (document.getElementById("Scrollbar-Container"), scroller, true, scrollbarEvent);
	$("#News").attr("style","overflow:hidden");
	$("#About").attr("style","overflow:hidden");
	$("#Extra").attr("style","overflow:hidden");
	$("#Scrollbar-Container").show();
  }
}


function scrollbarEvent (o, type) {
	if (type == "mousedown") {
		if (o.className == "Scrollbar-Track") o.style.backgroundUrl = "images/scroller.png";
		else o.style.backgroundUrl = "images/scroller.png";
	} else {
		if (o.className == "Scrollbar-Track") o.style.backgroundUrl = "images/scroller.png";
		else o.style.backgroundUrl = "images/scroller.png";
	}
}

function swapIt(o) {
	o.blur();
	if (o.className == "current") return false;
  
	var list = document.getElementById("Navigation").getElementsByTagName("a");
	for (var i = 0; i < list.length; i++) {
		if (list[i].className == "current") {
			list[i].className = "";
			document.getElementById(list[i].title).y = -scroller._y;
		}
		if (list[i].title == o.title) o.className = "current";
	}
  
	list = document.getElementById("Container").childNodes;
	for (var i = 0; i < list.length; i++) {
		if (list[i].tagName == "DIV") list[i].style.display = "none";
	}
  
	var top = document.getElementById(o.title);
	top.style.display = "block";
	scrollbar.swapContent(top);
	if (top.y) scrollbar.scrollTo(0, top.y);
  
	return false;
}
//容错脚本
ResumeError=function (){return true;}
window.onerror = ResumeError;