<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<% 

	//获取扩展属性信息
	String ipAddr = request.getAttribute("IP_ADDR")==null ? "" :(String)request.getAttribute("IP_ADDR");		
	String port = request.getAttribute("PORT")==null ? "12009" :(String)request.getAttribute("PORT");//12009 是默认的值	
	String cmdFileName = request.getAttribute("CMD_FILE_NAME")==null ? "" : (String)request.getAttribute("CMD_FILE_NAME");
	String cmdFilePath = request.getAttribute("CMD_FILE_PATH")==null ? "" : (String)request.getAttribute("CMD_FILE_PATH");
	String logFilePath = request.getAttribute("LOG_FILE_PATH")==null ? "" : (String)request.getAttribute("LOG_FILE_PATH");
	String progressFileName = request.getAttribute("PROGRESS_FILE_NAME")==null ? "" : (String)request.getAttribute("PROGRESS_FILE_NAME");
	String progressFilePath = request.getAttribute("PROGRESS_FILE_PATH")==null ? "" : (String)request.getAttribute("PROGRESS_FILE_PATH");
	
	long ipAddrExpandId = (Long)request.getAttribute("IP_ADDR_EXPAND_ID") == null? 0 : (Long)request.getAttribute("IP_ADDR_EXPAND_ID");
	long portExpandId = (Long)request.getAttribute("PORT_EXPAND_ID") == null? 0 : (Long)request.getAttribute("PORT_EXPAND_ID");
	long cmdFileNameExpandId = (Long)request.getAttribute("CMD_FILE_NAME_EXPAND_ID") == null? 0 : (Long)request.getAttribute("CMD_FILE_NAME_EXPAND_ID");
	long cmdFilePathExpandId = (Long)request.getAttribute("CMD_FILE_PATH_EXPAND_ID") == null? 0 : (Long)request.getAttribute("CMD_FILE_PATH_EXPAND_ID");
	long logFilePathExpandId = (Long)request.getAttribute("LOG_FILE_PATH_EXPAND_ID") == null? 0 : (Long)request.getAttribute("LOG_FILE_PATH_EXPAND_ID");
	long progressFileNameExpandId = (Long)request.getAttribute("PROGRESS_FILE_NAME_EXPAND_ID") == null? 0 : (Long)request.getAttribute("PROGRESS_FILE_NAME_EXPAND_ID");
	long progressFilePathExpandId = (Long)request.getAttribute("PROGRESS_FILE_PATH_EXPAND_ID") == null? 0 : (Long)request.getAttribute("PROGRESS_FILE_PATH_EXPAND_ID");
	

	System.out.println(ipAddrExpandId+"------------");
	System.out.println(request.getAttribute("IP_ADDR_EXPAND_ID")+"------------||||");

%>

<html>
<head>
<title>网元扩展属性配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="netCellForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
			<input type=hidden name="cellId" id="cellId" value="${romNetCell.cellId}">
			
			<input type=hidden name="ipAddrExpandId" id="ipAddrExpandId" value="<%=ipAddrExpandId%>" >
			<input type=hidden name="ipAddrExpandId" id="ipAddrExpandId" value="<%=ipAddrExpandId%>" >
			<input type=hidden name="portExpandId" id="portExpandId" value="<%=portExpandId%>" >
			<input type=hidden name="cmdFileNameExpandId" id="cmdFileNameExpandId" value="<%=cmdFileNameExpandId%>" >
			<input type=hidden name="cmdFilePathExpandId" id="cmdFilePathExpandId" value="<%=cmdFilePathExpandId%>" >
			<input type=hidden name="logFilePathExpandId" id="logFilePathExpandId" value="<%=logFilePathExpandId%>" >
			<input type=hidden name="progressFileNameExpandId" id="progressFileNameExpandId" value="<%=progressFileNameExpandId%>" >
			<input type=hidden name="progressFilePathExpandId" id="progressFilePathExpandId" value="<%=progressFilePathExpandId%>" >
	
		<div class="input">
				<div id="formTab">
					<ul>
						<li class="current" id="title_0" onclick="HoverLit(0,3)"><a href="#this">指令配置文件--属性配置</a></li>
						<li class="normaltab" id="title_1" onclick="HoverLit(1,3)"><a href="#this">进程配置文件--属性配置</a></li>
						<li class="normaltab" id="title_2" onclick="HoverLit(2,3)"><a href="#this">日志文件--属性配置</a></li>
					</ul>
				</div>
				<table>
					<tr>
						<th>省份运营商:</th>
						<td>
							<input type="text" name="name" id="name" readonly="true" value="${romNetCell.provinceName}${romNetCell.tellcorpName}"/>
						</td>
						<th>网元名称：</th>
						<td>
							<input type="text" name="cellName" id="cellName" readonly="true" value="${romNetCell.cellName}"/>
						</td>
					</tr>
					<tr>
						<th>网元编码：</th>
						<td>
							<input type="text" name="cellCode" id="cellCode" readonly="true" value="${romNetCell.cellCode}"/>
						</td>
						<th>网元编号：</th>
						<td>
							<input type="text" name="hlrCode" id="hlrCode" readonly="true" value="${romNetCell.hlrCode}"/>
						</td>
					</tr>
					<tr>
						<th><font color="red">*主机IP：</font></th>
						<td>
							<input type="text" name="ipAddr" id="ipAddr" value="<%=ipAddr%>" class="required ipAddress"/>
						</td>
						<th><font color="red">*端口：</font></th>
						<td>
							<input type="text" name="port" id="port" v_minlength="1" v_maxlength="6" class="required isCharLengthOf nonNegInt" value="<%=port%>" class="required ipAddress"/>
							<font color="red">(rpc部署端口)</font>
						</td>
					</tr>
					
					<tr id="tr_0" ><!--指令配置  -->
						<th><font color="red">*文件路径：</font></th>
						<td>
							<input type="text" name="cmdFilePath" id="filePath" class="required" size="40" value="<%=cmdFilePath%>"/>
						</td>
						<th><font color="red">*文件名称：</font></th>
						<td>
							<input type="text" name="cmdFileName" id="fileName" class="required"  size="40" value="<%=cmdFileName%>"/>
						</td>
					</tr>
					
					<tr id="tr_1" style="display:none;"><!--进程配置  -->
						<th><font color="red">*文件路径：</font></th>
						<td>
							<input type="text" name="progressFilePath" id="filePath" class="required"  size="40"  value="<%=progressFilePath%>"/>
						</td>
						<th><font color="red">*文件名称：</font></th>
						<td>
							<input type="text" name="progressFileName" id="fileName" class="required"  size="40" value="<%=progressFileName%>"/>
						</td>
					</tr>
					
					<tr id="tr_2" style="display:none;"><!--日志文件  -->
						<th><font color="red">*文件路径：</font></th>
						<td>
							<input type="text" name="logFilePath" id="filePath" class="required"  size="40"  value="<%=logFilePath%>"/>
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su_0" id="su_0" onClick="doSubmit(0)" class="b_foot" value="确定" />
				<input type="button" name="su_1" id="su_1" onClick="doSubmit(1)" class="b_foot" value="确定" style="display:none;"/>				
				<input type="button" name="su_2" id="su_2" onClick="doSubmit(2)" class="b_foot" value="确定" style="display:none;"/>
				<input type="button" name="re" onClick="resetFrm()" class="b_foot" value="重置" />
				<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
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
	
    //关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSrchSubmit();
	    }catch(e){}
	});
	//--end
	
});

function doSubmit(type){
    if(!checksubmit(netCellForm)){
		return false;
	}
	
	document.netCellForm.action='<%=request.getContextPath()%>/nc002Update.do?type=' + type;
	document.netCellForm.submit();	
}

function resetFrm(){
	document.forms('netCellForm').reset();
}

////////////////////////////////////////////////////////////
function g(o){
	return document.getElementById(o);
}	
//tab页调用的方法，控制整个页面输出内容	 
function HoverLit(n,t){	

	for(var i=0;i<t;i++){
		g('title_'+i).className='normaltab';
		g('tr_'+i).style.display='none';  	  	
		g('su_'+i).style.display='none';
	}
	g('title_'+n).className='current';
	g('tr_'+n).style.display='block';
	g('su_'+n).style.display='';
	
	
}


</script>
</body>
</html>