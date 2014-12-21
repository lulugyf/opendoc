<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%
	String scriptId=request.getParameter("scriptId");
	String remotePath=request.getParameter("remotePath");
	String did=request.getParameter("did");
	String provinceCode=request.getParameter("provinceCode");
	String tellType=request.getParameter("tellType");
%>
<html>
<head>
<title>文件上传</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm" enctype="multipart/form-data">
		
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=provinceCode%>">
			<input type=hidden name="tellType" id="tellType" value="<%=tellType%>">
			<div class="input">
				<table>
				
				
					<input type=hidden name="remotePath" id="scriptId" value="<%=scriptId%>">
 					<input type=hidden name="remotePath" id="remotePath" value="<%=remotePath%>">
 					<input type=hidden name="did" id="did" value="<%=did%>">
 
 					<tr>
	 					<td colspan="2">
	 						<p align=center><b>远程文件目录信息列表如下</b></p>		         					
				            <div id="dircontent" align="center">
				            </div>			            				        
	 					</td>					
 					</tr> 					
 					
 					</table>
 
			</div>

			<div align="center">
			    <font color="red"><span id="succInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>
$(document).ready(function () {
 getRemoteDir();
});

 
function getRemoteDir(){
		if($("#siteId").val()==""){
			alert("请选择要上传的主机！");
			return false;
		}
	
		var packet = new AJAXPacket("<%=request.getContextPath()%>/getRemoteDir.do");
		packet.data.add("remotePath" ,$('#remotePath').val());
		packet.data.add("scriptId" ,$('#scriptId').val());
		packet.data.add("proId" ,'<%=proId%>');
		packet.data.add("opCode" ,'<%=opCode%>');
		packet.data.add("provinceCode" ,'<%=provinceCode%>');
		packet.data.add("tellType" ,'<%=tellType%>');
		core.ajax.sendPacketHtml(packet,doGetRemoteDir);
		packet =null;
}

function doGetRemoteDir(data){
	/*
	alert(data);
	var info = eval('(' + data + ')');   
	alert(info.retCode);
	*/
	
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
		
		//生成表头和固定数据
	   	var html="<table>";
	     	html=html+"<tr><th>操作</th><th>名称</th><th>类型</th></tr>";
	   	html=html+"<tr>";
	   	html=html+"<td>";
	   	html=html+"<input type='button' class='b_foot' value='选择' onclick='choice(\"/\")'/>";
	   	html=html+"</td>";
	   	
		html=html+"<td>";	
		html=html+"<a onmousedown='chgdir(\"/\")' >[/]</a>";
		html=html+"</td>";
		
		html=html+"<td>&nbsp;</td>";
		html=html+"</tr>";
		
		if(parentDir!=""){
			html=html+"<tr>";
		   	html=html+"<td>";
		   	html=html+"<input type='button' class='b_foot' value='选择' onclick='choice(\""+parentDir+"\")'/>";
		   	html=html+"</td>";
	   			
			html=html+"<td>";		
			html=html+"<a onmousedown='chgdir(\""+parentDir+"\")' >[..]</a>";
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
		  			html=html+"<td>";
		  			html=html+"<input type='button' class='b_foot' value='选择' onclick='choice(\""+curDir+"/"+tmparr[1]+"\")'/>";
		  			html=html+"</td>";	
			  		html=html+"<td>";
			  		html=html+"<a onmousedown='chgdir(\""+curDir+"/"+tmparr[1]+"\")' >["+tmparr[1]+"]</a>";
			  		html=html+"</td>";				  		
		  			html=html+"<td>目录</td>";
		  		}else{
		  			html=html+"<td>";	
		  			html=html+"</td>";	
			  		html=html+"<td>";
			  		html=html+tmparr[1];
			  		html=html+"</td>";				  		
		  			html=html+"<td>文件</td>";
		  		}	  		
		  		
		  		html=html+"</tr>";			
			}
		}
	 
		html=html+"</table>";
		
		html=html+"<p align=center>";
		if(curDir==""){
			curDir="/"
		}
		html=html+"<b>当前目录:"+curDir+"</b>";
		html=html+"</p>";
		//alert(html);
	   	$("#dircontent").html(html);	
	}
		     
}
 

function chgdir(dir){
	//alert(dir);
	$("#remotePath").val(dir);
	getRemoteDir();
}

function choice(dir){	
	var did=$("#did").val();
	parent.setDir(did,dir);
	closeDivWin();
}

</script>
</body>
</html>