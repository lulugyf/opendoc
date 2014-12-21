<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%
	String hostIp=request.getParameter("hostIp");
	String port=request.getParameter("port");
	String userName=request.getParameter("userName");
	String password=request.getParameter("password");
	
	String remotePath=request.getParameter("remotePath");if(remotePath==null){remotePath="";}	
 	proId=request.getParameter("proId");
 	opCode=request.getParameter("opCode");
	String provinceCode=request.getParameter("provinceCode");	
	String tellType=request.getParameter("tellType");
	
%>
<html>
<head>
<title>文件上传</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/npage/maintain/command/base64.js"></script> 
</head>
 <style>  
 <!--  
 .div{  
  position: absolute;
  font-size:12px;  
  z-index:1000;
  width:100%;
  height:26px;
  background-color:#ccc;
  line-height:20px;
  padding:3px;
  text-align:left
 }  
 -->  
 </style>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm" enctype="multipart/form-data">
			<input type=hidden name="hostIp" id="hostIp" value="<%=hostIp%>">
			<input type=hidden name="port" id="port" value="<%=port%>">
			<input type=hidden name="userName" id="userName" value="<%=userName%>">
			<input type=hidden name="password" id="password" value="<%=password%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=provinceCode%>">
			<input type=hidden name="tellType" id="tellType" value="<%=tellType%>">
			<input type=hidden name="remotePath" id="remotePath" value="<%=remotePath%>">
			
			<div id="CurDirDiv" class="div" align="center"></div>
			
			<div class="input">
				<p align="center" style="margin-top:30px"><b>远程文件目录信息列表如下</b></p> 							         					
	            <div id="dircontent"></div>
			</div>

			<div align="center">
			    <font color="red"><span id="succInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>

window.onscroll=sc1;
window.onload=sc1; 
 
$(document).ready(function () {
    getRemoteDir();
});

function sc1(){  
    document.getElementById("CurDirDiv").style.top=document.documentElement.scrollTop+"px";  
    document.getElementById("CurDirDiv").style.left=document.documentElement.scrollLeft+"px";
}
 
function getRemoteDir(){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/getCmdExecRemoteDir.do");
	packet.data.add("remotePath" ,$('#remotePath').val());
	packet.data.add("hostIp" ,'<%=hostIp%>');
	packet.data.add("port" ,'<%=port%>');
	packet.data.add("userName" ,'<%=userName%>');
	packet.data.add("password" ,'<%=password%>');
	
	packet.data.add("proId" ,'<%=proId%>');
	packet.data.add("opCode" ,'<%=opCode%>');
	packet.data.add("provinceCode" ,'<%=provinceCode%>');
	packet.data.add("tellType" ,'<%=tellType%>');
	core.ajax.sendPacketHtml(packet,doGetRemoteDir);
	packet =null;
}

function doGetRemoteDir(data){
 
 	//参考:http://bbs.blueidea.com/thread-2914615-1-1.html
 	//虽然Html和JS的编码都是utf-8，但JS从页面上得到的中文编码却是utf-16，所以直接对中文进行Base64编码将得到错误的结果，
 	//所以我们要先从utf-16转到utf-8再编码
 	
	data=utf8to16(decode64(data));
 
	if(data.indexOf("ERROR",0)!=-1){
		var html="<font color='red'>"+"访问远端系统异常！"+"</font>";
		$("#dircontent").html(html);
	}else{
		var curDir=$("#remotePath").val();
		//如果配置的远程路径结尾是/字符，就丢弃掉，避免配置造成的问题。
		if(curDir.charAt(curDir.length-1)=="/"){
			curDir=curDir.substr(0,curDir.length-1);
		}
		var parentDir=curDir.substr(0,curDir.lastIndexOf('/'));  
		
		//表格自动换行，避免撑开
	   	var html="<table style=\"table-layout:fixed;word-break:break-all; word-wrap: break-word\">";
	     	html=html+"<tr><th>名称</th><th>类型</th></tr>";
	   	html=html+"<tr>";
	   	
	   	/**
	   	html=html+"<td>";
	   	html=html+"<input type='button' class='b_foot' value='选择' onclick='choice(\"/\")'/>";
	   	html=html+"</td>";
	   	**/
	   	
		html=html+"<td>";	
		html=html+"<a href=\"#this\" onmousedown='chgdir(\"/\")' >[/]</a>";
		html=html+"</td>";
		
		html=html+"<td>&nbsp;</td>";
		html=html+"</tr>";
		
		if(parentDir!=""){
			/**
			html=html+"<tr>";
		   	html=html+"<td>";
		   	html=html+"<input type='button' class='b_foot' value='选择' onclick='choice(\""+parentDir+"\")'/>";
		   	html=html+"</td>";
		   	**/
	   			
			html=html+"<td>";		
			html=html+"<a href=\"#this\" onmousedown='chgdir(\""+parentDir+"\")' >[..]</a>";
			html=html+"</td>";
			  		
			html=html+"<td>&nbsp;</td>";
			html=html+"</tr>";			  		
		}
			  				        	
		var filearr=data.split("\n");
		var i=0
		for (i=0;i<filearr.length;i++)
		{		
			if(filearr[i]!="" && filearr[i]!="undefined"){
				var tmparr=filearr[i].split(" ");
		  		html=html+"<tr>";	
		  		if(tmparr[0].substr(0,1)=="d"){
		  			/**
		  			html=html+"<td>";
		  			html=html+"<input type='button' class='b_foot' value='选择' onclick='choice(\""+curDir+"/"+tmparr[1]+"\")'/>";
		  			html=html+"</td>";
		  			**/	
			  		html=html+"<td>";
			  		html=html+"<a href=\"#this\" onmousedown='chgdir(\""+curDir+"/"+tmparr[1]+"\")' >["+curDir+"/"+tmparr[1]+"]</a>";
			  		html=html+"</td>";				  		
		  			html=html+"<td>目录</td>";
		  		}else{
		  			/**
		  			html=html+"<td>";	
		  			html=html+"</td>";
		  			**/	
			  		html=html+"<td>";
			  		html=html+tmparr[1];
			  		html=html+"</td>";				  		
		  			html=html+"<td>文件</td>";
		  		}	  		
		  		
		  		html=html+"</tr>";			
			}
		}
	 
		html=html+"</table>";
		
		if(curDir==""){
			curDir="/"
		}
		/*
		html=html+"当前目录:<input type='text' readOnly='true' name='curdir' style='width:80%;' value=\""+curDir+"\"/>";
		html=html+"<input type='button' class='b_foot' value='选择' onclick='choice(\""+curDir+"\")'/>";
		html=html+"</p>";
		*/
		//alert(html);
	   	$("#dircontent").html(html);
	   	
	   	var floatHtml="";
	   	
		floatHtml=floatHtml+"当前目录：<input type='text' readOnly='true' name='curdir' style='width:50%;' value=\""+curDir+"\"/>&nbsp;";
		floatHtml=floatHtml+"<input type='button' class='b_foot' value='选择' onclick='choice(\""+curDir+"\")'/>";
	   	$("#CurDirDiv").html(floatHtml);
	    
    	setTimeout("sc1();",50);
    	setTimeout("sc1();",50);
    	setTimeout("sc1();",50);
    	setTimeout("sc1();",50);
	}
	
}
 

function chgdir(dir){
	$("#remotePath").val(dir);
	getRemoteDir();
}

function choice(dir){	
	parent.setDir(dir);
	closeDivWin();
}

</script>
</body>
</html>