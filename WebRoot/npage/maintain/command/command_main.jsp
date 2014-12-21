<%@ page language="java" import="java.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<title>命令维护</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/npage/maintain/command/base64.js"></script> 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="cmdForm">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">		
			<div class="input">
				<table>
					<tr>
						<th>省份运营商：</th>
						<td>
							<select name="provinceTell" id="provinceTell" onchange="provinceTellChange()">
							<c:if test="${provinceTellcorpList!=null}"> 
							<c:forEach items="${provinceTellcorpList}" var="item">
								<option value="${item.provinceCode}_${item.tellcorpCode}" >${item.provinceName}${item.tellcorpName}</option>
							</c:forEach>
							</c:if>
							</select>
						</td>
						<th></th>
						<td>
							
						</td>						
					</tr>
					<tr>
 						<th><font color="red">*主机：</font></th>
						<td>
							<input type="text" name="hostName" id="hostName" class="" readonly="readonly" />
							<input type=hidden name="hostId" id="hostId" >
							<input type=hidden name="hostIp" id="hostIp"/>
							<input type="button" name="choiceButton" onClick="choiceHostInfo();" class="b_foot" value="选择主机" />
						</td>						
						<th>端口：</th>
						<td>
						    <input id="port" name="port" type="text" class="required" /><font color="red">*</font>
						</td>						
					</tr>
 									
					<tr>
						<th>用户名：</th>
						<td>
						    <input id="userName" name="userName" type="text" class="required" /><font color="red">*</font>
						</td>
						<th>密码：</th>
						<td>
						    <input id="password" name="password" type="password" class="required"/><font color="red">*</font>
						</td>						
					</tr>
					<tr>
						<th>目录：</th>
						<td colspan="3">
						    <input id="dir" name="dir" type="text" class="required" style="width:400px;"/><font color="red">*</font>
						     <input type="button" name="dirButton" id="dirButton" onclick="getRemoteDir()" class="b_foot" value="选择目录" />
						</td>
					</tr> 			
					<tr>
						<th>命令：</th>
						<td colspan="3">
						    <input id="cmd" name="cmd" type="text" class="required" style="width:400px;"/><font color="red">*</font>
						</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:center;height:40px">
						    <input type="button" name="run" id="run" style="display:none" onclick="doSubmit()" class="b_foot" value="执行" />&nbsp;&nbsp;
						    <input type="button" name="re" id="re" onclick="document.forms['cmdForm'].reset()" class="b_foot" value="重置" />&nbsp;&nbsp;
						    <input type="button" name="res" id="res" onclick="$('#cmdResult').html('');" class="b_foot_long" value="清除执行结果" />
						</td>
					</tr>
					<tr>
						<th>执行结果：</th>
						<td colspan="3">
						    <textarea id="cmdResult" name="cmdResult" style="width:99%;font-size:12px" rows="25" readonly="true"></textarea>
						</td>
					</tr>
				</table>
			</div>
			
			<div align="center">
			    <font color="red"><span id="operInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>

/***********显示隐藏功能权限对应按钮 begin***************/
$(document).ready(function () {
    getOpersForPage();
    provinceTellChange();

	//去掉校验特殊字符
	$('#cmdResult').attr('class',""); 
	
	var c=$('#cmd').attr('class');
	c=c.substring(0,c.lastIndexOf(' '));
	$('#cmd').attr('class',c);
	
});

function getOpersForPage(){
	var opersForPage = '${opersForPage}';
    if(opersForPage!='' && opersForPage!='NULL'){
        var attr = opersForPage.split(',');
        for(var i=0; i<attr.length-1; i++){
        	var protell=attr[i].split(':')[0];
        	var opers = attr[i].split(':')[1];
        	$("#provinceTell option[value='"+protell+"']").attr("opers",opers);
        }
    }
}

var param='?';
function provinceTellChange(){
	var opersForPage = $("#provinceTell").find("option:selected").attr("opers");

	if(opersForPage.indexOf('5')>-1){
		$('#run').css('display','');
	}else{
		$('#run').css('display','none');
	}
 
 
}
//权限设置
function doSubmit(){
    if(!checksubmit(cmdForm)){
		return false;
	}
	
	$('#cmdResult').html("");
	loading();
	var packet = new AJAXPacket("<%=request.getContextPath()%>/cmdExec.do");
	packet.data.add("hostIp" ,$('#hostIp').val());
	packet.data.add("port" ,$('#port').val());
	packet.data.add("userName" ,$('#userName').val());
	packet.data.add("password" ,$('#password').val());
	packet.data.add("remotePath" ,$('#remotePath').val());
	packet.data.add("proId" ,$('#proId').val());
	packet.data.add("opCode" ,$('#opCode').val());
	packet.data.add("hostName" ,$('#hostName').val());
	
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
		
	packet.data.add("provinceCode" ,provinceCode);
	packet.data.add("tellType" ,tellType);
	packet.data.add("cmd" ,$('#cmd').val());
	packet.data.add("dir" ,$('#dir').val());
 
	core.ajax.sendPacketHtml(packet,doRunBack);
	packet =null;
}

function doRunBack(data){

	data=utf8to16(decode64(data));
	
	if(data=='noright'){
  	    $('#cmdResult').html('您没有权限进行此操作！');
  	}else{
  		$('#cmdResult').html(data);
  	}

	//去掉校验特殊字符
	$('#cmdResult').attr('class',"");
	unLoading('ajaxLoadingDiv');
}


/***********显示隐藏功能权限对应按钮 end***************/

function getRemoteDir(did){
  
	var hostIp=$("#hostIp").val();
	var port=$('#port').val();
	var userName=$('#userName').val();
	var password=$('#password').val();
	var remotePath=$('#dir').val();
	//如果第一次没有目录，那么remotePath值就是根目录
	if(remotePath==""){remotePath="/";}
 
    if(hostIp==""){
    	alert("请先选择主机!");
    	return false;
    }
    if(port==""){
    	alert("请输入端口!");
    	return false;
    }
    if(userName==""){
    	alert("请输入用户名!");
    	return false;
    } 
    if(password==""){
    	alert("请输入密码!");
    	return false;
    }             
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	 
	var qryPara="?hostIp="+hostIp+"&port="+port+"&userName="+userName+"&password="+password+"&remotePath="+remotePath;
	qryPara=qryPara+'&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;

	openDivWin("<%=request.getContextPath()%>/npage/maintain/command/getRemoteDirFile.jsp"+qryPara,"获得远程目录","700","500");
}

function setDir(dir){
	//alert(dir);
	$("#dir").val(dir)
}

function choiceHostInfo(){
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	
	var qryPara="proId=<%=proId%>&opCode=<%=opCode%>&provinceCode="+provinceCode+'&tellType='+tellType;
	openDivWin("<%=request.getContextPath()%>/gotoQryHostInfo.do?"+qryPara,"查询主机信息","700","300");
}

function setHost(hostId,hostInfo,hostIp){
	//alert(" "+hostId+":"+hostInfo);
	$("#hostName").val(hostInfo);
	$("#hostId").val(hostId);
	$("#hostIp").val(hostIp);
}

</script>
</body>
</html>