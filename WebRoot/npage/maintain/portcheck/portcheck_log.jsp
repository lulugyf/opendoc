<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="java.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<script src="<%=request.getContextPath()%>/njs/plugins/sortTable.js" type="text/javascript"></script>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"><div class="text">&nbsp;日志明细</div></div>  
<div class="list">
	<table id="mTable" style="table-layout:fixed;word-wrap:break-word;">
		<thead>
		<tr>			
			<th>刷新频率:
				<select id="refresTime" onchange="refreshTime()">
					<option value="5">5秒</option>
					<option value="10">10秒</option>
					<option value="15">15秒</option>
				</select>
				<input type="checkbox" title="暂停刷新" name="isRefresh" id="isRefresh" />暂停刷新				
			</th>	
		</tr>
		
		<tr>
			<td id="logText" name="logText"> 						
			</td>		
		</tr>
		<thead>
		
		
	</table>
</div>
  
</div>	
</div>
<%@ include file="/npage/include/footer.jsp"%>
 </body>
 
<script language="javascript" type="text/javascript">
$(document).ready(function () {
	showLog();

    parent.unLoading('ajaxLoadingDiv');
});
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
function refreshTime(){
	//更改时间时,立即刷新;不能直接调用doSrchSubmit,那样会引起设置多个定时器的问题
	var packet = new AJAXPacket("<%=request.getContextPath()%>/portcheckShowLog.do");
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=request.getParameter("provinceCode")%>');
	packet.data.add("tellType" ,'<%=request.getParameter("tellType")%>');
	packet.data.add("cellId" ,'<%=request.getParameter("cellId")%>');

	core.ajax.sendPacket(packet,doResultShow);
	packet =null;
}


function showLog(){
	if( !document.getElementById("isRefresh").checked ){
		var packet = new AJAXPacket("<%=request.getContextPath()%>/portcheckShowLog.do");
		packet.data.add("proId" ,"<%=proId%>");
		packet.data.add("opCode" ,"<%=opCode%>");
		packet.data.add("provinceCode" ,'<%=request.getParameter("provinceCode")%>');
		packet.data.add("tellType" ,'<%=request.getParameter("tellType")%>');
		packet.data.add("cellId" ,'<%=request.getParameter("cellId")%>');
	    
		core.ajax.sendPacket(packet,doResultShow);
		packet =null;
	}	

	//这样调用定时刷新,可以避免把提交本身耗费的时间也计算在内
    setTimeout("showLog()", document.getElementById("refresTime").value * 1000);
}

function doResultShow(packet){
	var showtext;
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=='0'){
		showtext = packet.data.findValueByName("retMsg");
		showtext=decodeURI(showtext);
	}else{
		if(retCode=='noright'){
			showtext="您没有权限进行此操作！";
		}else{
			showtext=packet.data.findValueByName("retMsg");
			showtext=decodeURI(showtext);
		}
	}
 
 	showtext = showtext.replace(/<br\/>/ig, "\n");
 
	document.getElementById("logText").innerText = showtext;

}

</script>
</html>
