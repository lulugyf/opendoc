<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="java.util.*" %>
<%@ page import="com.sitech.rom.common.dto.RomCronTaskData" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<script src="<%=request.getContextPath()%>/njs/plugins/sortTable.js" type="text/javascript"></script>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"><div class="text">端口信息列表</div></div>  
<div class="list">
	<table id="mTable" style="table-layout:fixed;word-wrap:break-word;">
		<thead>
		<tr>
			<th style="width:10%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',0)">网元编码</th>
			<th style="width:10%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',1)">IP地址</th>
			<th style="width:7%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',2,'int')">端口</th>
			<th style="width:7%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',3)">端口状态</th>
			<th style="width:7%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',4,'int')">积压指令数</th>
			<th style="width:7%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',5,'int')">错误指令数</th>
			<th style="width:7%">操作</th>
		</tr>
		<thead>
		<% 
			//系统变量
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];
		    String loginNo=session.getAttribute("loginNo").toString();
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		%>
		<si:list name="portList" id="RomCronTaskData.selectPortMonitorData" scope="end">
			 <logic:iterate id="show" name="portList" indexId="i" type="com.sitech.rom.common.dto.RomCronTaskData">
		   		<tr>
		   			<td><%=StringUtil.delimitedListToStringArray(StringUtil.safeValue(show.getItemDesc()),"|")[0]%></td>			   		
					<td><%=StringUtil.delimitedListToStringArray(StringUtil.safeValue(show.getItemDesc()),"|")[1]%></td>
					<td><%=StringUtil.delimitedListToStringArray(StringUtil.safeValue(show.getItemDesc()),"|")[2]%></td>
			   		<td>
				   		<%
				   		if( StringUtil.safeValue(show.getPortStatus()).equals("noactive")){
				   			out.println("<font color='red'><b>" + StringUtil.safeValue(show.getPortStatus()) + "</b></font>");
				   		}else{
				   			out.println( StringUtil.safeValue(show.getPortStatus()) );				   			
				   		}
				   		%>
			   		</td>
			   		<td><a href="javascript:showDetail('delayed','<%=StringUtil.safeValue(show.getItemDesc()) %>')"><u><%=StringUtil.safeValue(show.getDelayedNum())%></u></a></td>
			   		<td><a href="javascript:showDetail('error','<%=StringUtil.safeValue(show.getItemDesc()) %>')"><u><%=StringUtil.safeValue(show.getErrorNum())%></u></a></td>			   							   		     
			   		<td><a href="javascript:showLog('<%=StringUtil.delimitedListToStringArray(StringUtil.safeValue(show.getItemDesc()),"|")[3]%>')"><u>点我查看日志<u></a></td>
		   		</tr>
		   	 </logic:iterate>  
	    </si:list>
	</table>
</div>
  
</div>	
</div>
<%@ include file="/npage/include/footer.jsp"%>
 </body>
 
<script language="javascript" type="text/javascript">
$(document).ready(function () {
    if('<%=edit%>'=='Y'){
        $("input[name='edit']").each(function(){
            $(this).css('display','');
        })
        $("input[name='set']").each(function(){ 
            $(this).css('display','');
        })
    }
    if('<%=del%>'=='Y'){
        $("input[name='del']").each(function(){
            $(this).css('display','');
        })
    }
    parent.unLoading('ajaxLoadingDiv');
});
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

//显示指令明细
function showDetail(type,itemDesc){
	var title;
	if(type == "delayed"){
		title = "积压指令明细";
	}else if(type == "error"){
		title = "错误指令明细";
	}

	var arr = new Array();
	arr = itemDesc.split("|");
	var ipPort = arr[1] + "|" + arr[2];

	var qryPara = 	
	 "type="+type
	+"&ipPort="+ipPort
	+"&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode=<%=provinceCode%>&tellType=<%=tellType%>";
	
	parent.openDivWin("<%=request.getContextPath()%>/portcheckCmdDetail.do?"+qryPara,title,"1000","300");
	parent.refreshByClose();
}

//显示日志
function showLog(cellId){
	var qryPara = 
	 "cellId=" + cellId
    +"&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode=<%=provinceCode%>&tellType=<%=tellType%>";
    	
	parent.openDivWin("<%=request.getContextPath()%>/npage/maintain/portcheck/portcheck_log.jsp?"+qryPara,"查看日志","1000","400");
	parent.refreshByClose();
}




</script>
</html>
