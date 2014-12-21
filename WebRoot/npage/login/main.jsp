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
	int layouts = Integer.parseInt((String)request.getParameter("layouts")!=null?(String)request.getParameter("layouts"):"0");
	String themePath =(String)request.getParameter("okStyle")!=null?(String)request.getParameter("okStyle"):"";
	String rightKey =(String)request.getParameter("hotKey")!=null?(String)request.getParameter("hotKey"):""; 
	String hotkeys =(String)request.getParameter("hotKey")!=null?(String)request.getParameter("hotKey"):"";
	
	if(themePath!=""){
		session.setAttribute("themePath",themePath);
	}
	if(rightKey!=""){
		session.setAttribute("rightKey",rightKey);
	}
	if(hotkeys!=""){
		session.removeAttribute("hotKey");
		session.setAttribute("hotKey",hotkeys);
	}

	//取session值
	String login_no   = (String)session.getAttribute("loginNo");
	String login_name = (String)session.getAttribute("loginName");
	themePath = (String)session.getAttribute("themePath");
	
	//取查询类型
	String [][] custType = new String[3][2];
	custType[0][0]="1";	custType[0][1]="服务号码";
	custType[1][0]="2";	custType[1][1]="证件号码";
	custType[2][0]="3";	custType[2][1]="集团客户";
	
	//取一级栏目
	String [][] firstMenu = new String[10][3];
	firstMenu[0][1]="1";	firstMenu[0][2]="开销户";
	firstMenu[1][1]="2";	firstMenu[1][2]="交退费";
	firstMenu[2][1]="3";	firstMenu[2][2]="业务受理";
	firstMenu[3][1]="4";	firstMenu[3][2]="营业查询";
	firstMenu[4][1]="5";	firstMenu[4][2]="积分管理";
	firstMenu[5][1]="6";	firstMenu[5][2]="营业统计";
	firstMenu[6][1]="7";	firstMenu[6][2]="系统管理";
%>

<html xmlns="http://www.w3.org/1999/xhtml">		
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>IT系统2.0</title>
	<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/framework.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/rightmenu.css" rel="stylesheet" type="text/css" />
</head>
<body id="main_page">
	<!--ScreenLock begin-->
	<div id="lock" style="width:100%;height:100%;background:silver; position:absolute;top:-100%;left:0;z-index:10002;">
		<iframe width="100%" height="100%" frameborder="0" ></iframe>
		<div style="position:absolute;top:0;left:0;width:100%;height:100%;background:#237EAB;z-index;1;"></div>
	</div>
	<!--ScreenLock end-->
	
	<!--doubleScreen begin-->
	<%@ include file="../module/twoWatch_client.jsp"%>
	<!--doubleScreen end-->
	
	<!--topPanel begin-->
	<%@ include file="../module/topPanel.jsp"%>
	<!--topPanel end-->

	<!--searchPanel begin-->
	<%@ include file="../module/searchPanel.jsp"%>
	<!--searchPanel end-->
	
	<!--ContentArea bengin-->
	<div id="contentPanel" style="white-space: nowrap">
		
		<!--navPanel begin-->
		<%@ include file="../module/navPanel.jsp"%>
		<!--navPanel end-->
		
		<!--workPanel begin-->
		<%@ include file="../module/workPanel.jsp"%> 
		<!--workPanel end-->
		
	</div>
	
	<!--footPanel begin-->
	<%@ include file="../module/footPanel.jsp"%>
	<!--footPanel end-->
	

<div id="currUserId" style="display:none"></div>
<script src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" type="text/javascript"></script>	
<script src="<%=request.getContextPath()%>/njs/system/jquery.messager.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/uif.js"  type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/autocomplete.js"  type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/tabScript_jsa.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/MzTreeView12.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/plugins/cookieSave.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
		/**************来自原来framework.js的代码*********/
// 整体布局
function layoutSwitch(n){
		
	$("#layoutStatus").val(n);
	
	$("#a1").attr("class","aSpace");
	$("#a2").attr("class","bSpace");
	$("#a3").attr("class","cSpace");
	$("#a4").attr("class","dSpace");
	
	var w = $("#workPanel").position();
	
	
	if (n==1){//工作区最大化
		$("#navPanel").hide();
		$("#topPanel").hide();
		$("#workPanel").css("width", "100%");
		$("#workPanel").css("margin-left","4px");
		$("#a1").attr("class","aSpaceOn");
	}
	if(n==2){//恢复完整视图
		$("#topPanel").show();
		$("#navPanel").show();
		$("#workPanel").css("width", "80%");
		$("#workPanel").css("margin-left","4px");
		$("#a2").attr("class","bSpaceOn");
		console.log('layout:'+n + " left:"+w.left+" top:"+w.top);
	}
	if(n==3){//隐藏topPanel面板
		$("#topPanel").hide();
		$("#navPanel").show();
		$("#workPanel").css("width", "80%");
		//$("#workPanel").css("margin-left","201px");
		$("#a3").attr("class","cSpaceOn");
	}
	if(n==4){//隐藏navPanel面板
		$("#topPanel").show();
		$("#navPanel").hide();
		$("#workPanel").css("width", "100%");
		//$("#workPanel").css("margin-left","4px");
		$("#a4").attr("class","dSpaceOn");
	}
	
	initPanel(n);
}

function initPanel(n){	
	
	var marginHeight=9;
	if(n==1){
		$("#contentPanel").height($("body").height()-$("#searchPanel").height()-$("#footPanel").height()-marginHeight);	
	}else if(n==2){
		$("#contentPanel").height($("body").height()-$("#topPanel").height()-$("#searchPanel").height()-$("#footPanel").height()-marginHeight);	
	}else if(n==3){
		$("#contentPanel").height($("body").height()-$("#searchPanel").height()-$("#footPanel").height()-marginHeight);	
	}else if(n==4){
		$("#contentPanel").height($("body").height()-$("#topPanel").height()-$("#searchPanel").height()-$("#footPanel").height()-marginHeight);	
	}
	$("#contentArea").height($("#workPanel").height()-$("#tab").height()-3);
	
	setIframe();
	setNav("N");
}

//设置一级TAB内iframe高度、宽度
function setIframe()
{
	var workPanel=g("workPanel");
	var tab=g("tab");
	var workPanelHeight=workPanel.clientHeight;
	var workPanelWidth=workPanel.clientWidth;
	var tabHeight = tab.clientHeight;
	var iframe=workPanel.getElementsByTagName("iframe");
	for(var i=0;i<iframe.length;i++)
	{
		iframe[i].style.height=(workPanelHeight-tabHeight)+"px";
		iframe[i].style.width=(workPanelWidth)+"px";
	}
}

//设置导航区中内容的高度,flag:tree有模块搜索
function setNav(flag)
{
	var marginHeight=3;
	if(flag == "tree")
	{
		$(".search_bar").show();
		$(".dis").height($("#navPanel").height()-$(".title").height()-$(".search_bar").height()-marginHeight);
	}else{
		$(".search_bar").hide();
		$(".dis").height($("#navPanel").height()-$(".title").height()-marginHeight);
	}
}

/************************************ topPanel ************************************/

//一级栏目切换
function HoverMenu(object,subobject)
{
	var tag=g(object).getElementsByTagName(subobject);
	for(var i=0;i<tag.length;i++)
	{
		(function(j){
			tag[j].onclick=function()
			{
				for(var n=0;n<tag.length;n++)
				{
					tag[n].className="";
				}
				tag[j].className="on";
				HoverNav("tree",tag[j].opcode,tag[j].opname);
			}
		})(i);
	}
}


function closeWindow(){
	loading("正在退出");
	$.post('logout.jsp', {}, function(result){
		unLoading('ajaxLoadingDiv');
		window.location = 'login.htm';
	});
}
/************************************ searchPanel *********************************/







//BEGIN 快速转入
var quickFlag = true;	
var content_array;//快速导航 0: openWay 1:functionCode 2:functionName 3:url 4:passFlag 以空格隔开
var opStr_quick = ""; //系统模块搜索 格式"0121 签退 QT,...."


//导航区切换;
function HoverNav(flag,parentNode,parentName){
	
	//隐藏
	
	$("#wait").show();
	
	if(flag =="fav")
		{
			$("#getFavFunc").addClass("on");
			$("#getTree").removeClass("on");
			$("#getAllTree").removeClass("on");
			$("#getNavFunc").removeClass("on");
			getFavFunc(flag);
		}else if(flag =="tree"){
			$("#getTree").addClass("on");
			$("#getFavFunc").removeClass("on");
			$("#getAllTree").removeClass("on");
			$("#getNavFunc").removeClass("on");
			getTree(parentNode,parentName);
		}else if(flag =="alltree"){
			$("#getAllTree").addClass("on");
			getTree(parentNode,parentName);
		}else{
			$("#getNavFunc").addClass("on");
		  $("#getAllTree").removeClass("on");
			$("#getTree").removeClass("on");
			$("#getFavFunc").removeClass("on");
			getNavFunc();
		}
}

//业务向导展示 20110121
function getNavFunc(){
  var navfunc = document.getElementById("navfunc");
  
  if(navfunc != null)navfunc.parentNode.removeChild(navfunc);
  
	navfunc = document.createElement("div");
	
	navfunc.className="dis";
	navfunc.id="navfunc";
	navfunc.innerHTML='<iframe id="div_iframe" src="../demo/flowEditors/showdiagram.jsp" width="185" height="600" scrolling="no" frameborder="0"></iframe>';
	//navfunc.innerHTML='<iframe id="div_iframe" src="../demo/guide_nav.jsp" width="185" height="600" scrolling="no" frameborder="0"></iframe>';
		
	$(".navMain")[0].appendChild(navfunc);
	setNav("nav");
	$("#wait").hide();
}

function getFavFunc(nodename)
{ 
	var node_favfunc = document.getElementById("node_favfunc");
	if(node_favfunc == null)
	{
		node_favfunc = document.createElement("div");
		node_favfunc.className="dis";
		node_favfunc.id="node_favfunc";
		$(".navMain")[0].appendChild(node_favfunc);
			
		var packet = new AJAXPacket("ajax_getfavfunc.jsp");
		core.ajax.sendPacketHtml(packet,doGetFavFunc);
		packet =null;
	}else{
		setNav("fav");
		$('#node_favfunc')[0].className="dis";
		$("#wait").hide();
	}
}
 
function doGetFavFunc(data)
{
	setNav("fav");
	$("#wait").hide();
	$('#node_favfunc').html(data);
}

function getTree(parentNode,parentName)
{
	var treenode = document.getElementById("node"+parentNode);
	if(treenode == null)
	{
		treenode = document.createElement("div");
		treenode.className="dis";
		treenode.id="node"+parentNode;
		$(".navMain")[0].appendChild(treenode);
		
		var packet = new AJAXPacket("<%=request.getContextPath()%>/getPopedomMenu.do");
		packet.data.add("parentNode" ,parentNode);
		packet.data.add("themePath" ,"<%=themePath%>");
		core.ajax.sendPacketHtml(packet,doGetTree);
		packet =null;
	}else{
		setNav("tree");
		treenode.className="dis";
		$("#wait").hide();
	}
}
 
function doGetTree(data){
	setNav("tree");
	$("#wait").hide();
	$("#navTree").html(eval(decodeURI(data)));
}

// 定位树节点（页面导航） 20101221
function getNavById(nodeId,flag,parentNode,parentName){
    HoverNav(flag,parentNode,parentName);
    setTimeout("tree"+parentNode+".focus('"+nodeId+"',true);",20);
} 

function getHotKey()
{
	var packet = new AJAXPacket("ajax_gethotkey.jsp");
	core.ajax.sendPacketHtml(packet,doGetHotKey,true);
	packet =null;
}
	
function doGetHotKey(data)
{
	var hotKeyScript = document.createElement("div");
	hotKeyScript.id="hotKeyScript";
	document.body.appendChild(hotKeyScript);
	$("#hotKeyScript").html(data);
}

function showFavMenu(functionCode)  //展现常用模块右键菜单
{
	var favMenu = document.getElementById('favMenu');//#favMenu在navPanel.jsp中
	
	var  rightedge  =  document.body.clientWidth-event.clientX; 
	var  bottomedge  =  document.body.clientHeight-event.clientY; 
	if  (rightedge  <  favMenu.offsetWidth) 
		favMenu.style.left  =  document.body.scrollLeft  +  event.clientX  -  favMenu.offsetWidth; 
	else 
		favMenu.style.left  =  document.body.scrollLeft  +  event.clientX; 
	if  (bottomedge  <  favMenu.offsetHeight) 
		favMenu.style.top  =  document.body.scrollTop  +  event.clientY  -  favMenu.offsetHeight-45; 
	else 
		favMenu.style.top  =  document.body.scrollTop  +  event.clientY-65; 
	favMenu.style.display  =  "block"; 
	
	activateTab('index');
	
	$('#favMenu #delIcon').bind('click',function(){
		//showDialog("删除常用功能成功",2);
	   delFavfunc(functionCode);
	   //editFavfunc("1","2","0");
	});
	
	$('#favMenu #editIcon').bind('click',function(){
		addTab(true,'index','工作空间','../portal/work/portal.jsp');
		document.getElementById("ifram").contentWindow.openDivWin("<%=request.getContextPath()%>/npage/portal/work/modifyHotKey.jsp","自定义快捷键","400","300");
		});
	
	/*	
	$('#favMenu #helpIcon').bind('click',function(){
		callHelp(functionCode)
	});
	*/
}
/***********20091015测试使用  begin*************/
function editFavfunc(function_code,op_type,show_order)
{
	var packet = new AJAXPacket("ajax_favfunc_cfm.jsp");
	core.ajax.sendPacket(packet,doFavfunc);
	packet =null;
}
function doFavfunc(packet)
{ 
	var retMsg = packet.data.findValueByName("retMsg");
	showDialog("加入常用功能功能编码："+retMsg,2);
  //getFavFunc();
}

/************end*********************/


var atree = new Array();
for(var i=0; i<50; i++){
	atree[i] = new Array();
}
atree[0][0] = "60000"; atree[0][1] = "60001";  atree[0][2] = "DEMO";                 atree[0][3] = "1"; atree[0][4] = "#"; 
atree[1][0] = "60001"; atree[1][1] = "demo1";  atree[1][2] = "布局管理";             atree[1][3] = "1"; atree[1][4] = "demo/layoutManage.jsp"; 

function addFavfunc(id)//加入常用功能
{ 
	HoverNav('fav');
	var _ul=$(".navMain")[0].children[1].children[0];
	var lis=_ul.children;
	var flag=0;
	for(var i=0; i<lis.length; i++){
	  var existId = document.all?lis[i].children[0].innerText.substring(1,lis[i].children[0].innerText.indexOf(']')):lis[i].children[0].textContent.substring(1,lis[i].children[0].textContent.indexOf(']'));
	  if(id==existId){
	      showDialog("加入失败，此功能已存在！",0);
	      flag=1;
	      break;
	  }
	}
	if(flag==0){
	    for(var n=0; n<atree.length; n++){
			     if(atree[n][1]==id){
			     	var li = document.createElement('li');
			     	li.setAttribute('oncontextmenu',function(){javascript:showFavMenu(id);return false;});
			     	var a = document.createElement('a');
			     	a.href="javascript:L('"+atree[n][3]+"','"+id+"','"+atree[n][2]+"','"+atree[n][4]+"','000');";
			     	
			     	if(document.all){
			     	    a.innerText='['+id+']'+atree[n][2];
			     	}else{
			     	    a.textContent='['+id+']'+atree[n][2];
			     	}
			     	li.appendChild(a);
			     	 _ul.appendChild(li);
			     	showDialog("加入常用功能成功！",2);
			     	break;
			     }
			 }
	}
}

function delFavfunc(id)//删除常用功能
{
	var _ul=$(".navMain")[0].children[1].children[0];
	var lis=_ul.children;
	var flag=0;
	for(var i=0; i<lis.length; i++){
	  var existId = document.all?lis[i].children[0].innerText.substring(1,lis[i].children[0].innerText.indexOf(']')):lis[i].children[0].textContent.substring(1,lis[i].children[0].textContent.indexOf(']'));
	  if(id==existId){
	      _ul.removeChild(lis[i]);
	      showDialog("删除成功！",0);
	      break;
	  }
	}

}
/************************************ workPanel ************************************/


function comment(tabId,opName)//模块评分
{
	//alert(opName);
	var path = "<%=request.getContextPath()%>/npage/public/rating.jsp";
	openDivWin(path,'模块评分','415','204');
}

var g_activateTab = "index";//active tabId
function activateTab(id)
{
	g_activateTab = id;
}

function destroyTab(id)
{
	//关闭客户Tab时清session
	if(id.substring(0,6)=="custid")
	{
		var sendop_code = {};
		sendop_code["custid"] = id.substring(6,id.length);
		$.ajax({
		   url: 'ajax_destroy.jsp',
		   type: 'POST',
		   data: sendop_code,
		   error: function(data){
				if(data.status=="404")
				{
				  alert( "文件不存在!");
				}else if (data.status=="500")
				{
				  alert("文件编译错误!");
				}else{
				  alert("系统错误!");  					
				}
		   },
		   success: function(retCode){
		   }
		});
		sendop_code=null; 
		}
}

/************************************ footPanel ************************************/

function openwindow(url,name,iWidth,iHeight)
{
  var url;                            //转向网页的地址;
  var name;                           //网页名称，可为空;
  var iWidth;                         //弹出窗口的宽度;
  var iHeight;                        //弹出窗口的高度;
  var iTop  = (window.screen.availHeight-30-iHeight)/2;       //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2;           //获得窗口的水平位置;
  var winOP = window.open(url,name,'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=auto,resizeable=yes,location=no,status=no');
  winOP.focus();     
}
		
/*******************end***************************/	
 	
 	window.onresize = function(){
		initPanel($("#layoutStatus").val());
	}
	
  /*
	 * 	openflag	 1.first tab;2.second tab;other open
	 *	opcode
	 *	title			 tab show text
	 *	targetUrl  page url
	 *	valideVal	 
	 */
	var isValidateFlag = false;
	
	function L(openflag,opcode,title,targetUrl,valideVal,proId)////L函数与2009-12-19日修改，增加打开方式3，即需要在打开模块前判断，如果客户首页没有打开，就在一级ｔａｂ中打开当前模块，如果客户首页已经打开，就要在二级ｔａｂ中打开当前模块
	{	
		
		if(targetUrl=='null' || $.trim(targetUrl)==''){
			targetUrl='#';
		}
		targetUrl = unescape(targetUrl);//用于解密;java中将汉字加密,此处解密,然后才可以正常显示
		
		try{ // 将打开的业务功能记录到cookie中 add on 20101229
			saveCookieById('op_code_cookie',openflag+' '+opcode+' '+title+' '+targetUrl+' '+valideVal)
		}catch(e){} 
		
		if(openflag=="1")//first tab
		{
			if(targetUrl!="#"){
				targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title,proId);
				if($("#contentArea iframe").size() < 11){
					addTab(true,opcode,title,targetUrl);	
				}else{
					showDialog("只能打开10个一级tab",1);
				}
			}
		}else if(openflag=="2")//second tab
		{
			if(g_activateTab.substr(0,6)=="custid"){
			    //alert(document.getElementById("currUserId").value);
				if($.trim(top.document.getElementById("currUserId").value)=="")return false; //等待客户首页的用户列表加载完毕
				//var  g_activeCustId = g_activateTab.substring(6);
				//targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title);
				//targetUrl = targetUrl+"&activePhone="+g_activateTab; 
				//targetUrl = targetUrl+addCustInfoToUrl(g_activeCustId); 
				document.getElementById("iframe"+g_activateTab).contentWindow.addTab(false,opcode,title,targetUrl);
			}else
			{
				showDialog("请选择要办理的客户!",1);
			}
		}else if(openflag=="3")//如果客户首页已经打开，则打开二级tab，否则打开一级tab
		{
			var  _hasCustOpen = false;
			$("#contentArea iframe").each(function(){
				if($(this)[0].id.length>12&&$(this)[0].id.substring(0,12)=="iframecustid"){
					_hasCustOpen = true;
				}
			});
			
			if(_hasCustOpen){//打开二级tab
				if(g_activateTab.substr(0,6)=="custid"){
					if($.trim(top.document.getElementById("currUserId").value)=="")return false; //等待客户首页的用户列表加载完毕
					var  g_activeCustId = g_activateTab.substring(6);
					targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title,proId);
					//targetUrl = targetUrl+"&activePhone="+g_activateTab; 
					//targetUrl = targetUrl+addCustInfoToUrl(g_activeCustId); 
					document.getElementById("iframe"+g_activateTab).contentWindow.addTab(false,opcode,title,targetUrl);
				}else
				{
					showDialog("请选择要办理的客户!",1);
				}
			}else{  //打开一级tab
				if(targetUrl!="#"){
					targetUrl = changeUrl("<%=request.getContextPath()%>/npage/"+targetUrl,opcode,title,proId);
					if($("#contentArea iframe").size() < 11){
						addTab(true,opcode,title,targetUrl);	
					}else{
						showDialog("只能打开10个一级tab",1);
					}
				}
			}
		}else if(openflag=="4")//一级tab打开集成页面
		{
			if(targetUrl!="#"){
				if($("#contentArea iframe").size() < 11){
					addTab(true,opcode,title,targetUrl);	
				}else{
					showDialog("只能打开10个一级tab",1);
				}
			}
		}
		else//弹出方式
		{
	  	if(targetUrl!="#"){
	  		targetUrl = "<%=request.getContextPath()%>/npage/"+changeUrl(targetUrl,opcode,title,proId);
	  		var win= window.open(targetUrl,"","width="+screen.availWidth+",height="+screen.availHeight+",top=0,left=0,scrollbars=yes,resizable=yes,status=yes");
	  		setTimeout(function(){win.focus();},1000);
	  	}
	  }
	}
	
	/****L函数end*****/
	
	function changeUrl(targetUrl,opCode,title,proId)
	{
  	var flag = targetUrl.indexOf("?");
  	opCode=opCode.substring(opCode.indexOf('-')+1); //格式：产品ID-opCode
  	if(parseInt(flag)==-1)
  	{
  		targetUrl=targetUrl+"?opCode="+opCode+"&opName="+encodeURI(title)+"&proId="+proId+"&provinceCode=-1&tellType=-1";
  	}else
  	{
  		targetUrl=targetUrl+"&opCode="+opCode+"&opName="+encodeURI(title)+"&proId="+proId+"&provinceCode=-1&tellType=-1";
  	}
  	return targetUrl;
	}
	
	function chkIsValidate(validateVal,activePhone,opcode)
	{
	  isValidateFlag = false;
	  var chkInfoPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/public/chkIsValidate.jsp","正在进行用户有效性验证,请稍候...");

    chkInfoPacket.data.add("retType" ,     "chkIsValidate"  );
    chkInfoPacket.data.add("verifyVal" ,  validateVal);
    chkInfoPacket.data.add("phoneNo" ,  activePhone);
    chkInfoPacket.data.add("opCode" ,  opcode);
    core.ajax.sendPacket(chkInfoPacket,doProcesspwd);
    chkInfoPacket =null;
	}
	$(document).ready(
		function(){
			
			HoverNav('alltree','9999','全部功能');
			<%
			if(layouts!=0)
			{%>
				layoutSwitch(<%=layouts%>);		
			<%}
			else{%>
			layoutSwitch(2);	//初始化页面各部分的大小;参数1,2,3,4
			<%}%>		
			
			//$(".more_set").hover(function(){$(this).find(".more_panel").show()},function(){$(this).find(".more_panel").hide()})
		  //$(".menu_set").hover(function(){$(this).find(".more_panel").show()},function(){$(this).find(".more_panel").hide()})
			$(".more_set").hover(function(){$(this).find(".more_panel").show();$("#moresetIf").height($(this).find(".more_panel").height());},function(){$(this).find(".more_panel").hide()})
		  $(".menu_set").hover(function(){$(this).find(".more_panel").show();$("#menusetIf").height($(this).find(".more_panel").height());},function(){$(this).find(".more_panel").hide()})
			//slideDialog("开户模块流程改变，新模块已上线！");
	});
	
	// 关闭当前tab
function removeCurrentTab(){
	
	//alert("1="+parent.g_activateTab);
	if(parent.g_activateTab == undefined){
		var l_activateTab = "";
		var lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
		for(var i=0; i<lis.length; i++){
			if(lis[i].className == "current"){
				l_activateTab = lis[i].id;
				break;		        
			} 
		}
		//alert("2="+l_activateTab);
		parent.removeTab(l_activateTab);
  }else{
  	//alert("3="+parent.g_activateTab);
		parent.removeTab(parent.g_activateTab); 
  }
}

function abccc()
{
	alert("ok");
}

//ScreenLock
function fSysLock(){
	$('#lock').css({top:'0'});
	var retInfo = top.window.showModalDialog(globalPathRoot+"npage/login/sysLock.jsp","","status:no;resizable:no;dialogHeight:150px;dialogWidth:500px;");
	while(typeof(retInfo) == "undefined"){
		retInfo = top.window.showModalDialog(globalPathRoot+"npage/login/sysLock.jsp","","status:no;resizable:no;dialogHeight:150px;dialogWidth:500px;");
	}
	//$("body").focus();
	$('#lock').animate({top:'-100%'},1000);
}

/************************************************ 
在线帮助，重写参数
    参数说明： 
    prefix：前缀，默认值'工程路径/npage/help/'
    suffix：后缀，默认值'.html'
    defaultPage: 默认帮助页面，默认值'工程路径/npage/help/help.html'
*************************************************/
uif.help.prefix='<%=request.getContextPath()%>/npage/help/h'; //可无
uif.help.suffix='.htm'; //可无
//uif.help.defaultPage='<%=request.getContextPath()%>/npage/help/demo10.html'; //可无

</script>	

</body>
</html>