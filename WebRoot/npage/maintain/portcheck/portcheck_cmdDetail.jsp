<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="java.util.*" %>
<%@ page import="com.sitech.rom.common.dto.WSndCmdDay" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<script src="<%=request.getContextPath()%>/njs/plugins/sortTable.js" type="text/javascript"></script>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"><div class="text">指令明细</div></div>  
<div class="list">
	<table id="mTable" style="table-layout:fixed;word-wrap:break-word;">
		<thead>
		<tr>
			<th style="width:12%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',0)">指令ID</th>
			<th style="width:7%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',1)">指令代码</th>
			<th style="width:20%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',2)"> 指令参数</th>
			<th style="width:7%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',3)">指令状态</th>
			<th style="width:12%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',4,'date')">发送时间</th>
			<th style="width:7%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',5)">返回代码</th>
			<th style="width:7%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',6)">返回信息</th>
			<th style="width:7%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',7)">操作代码</th>
			<th style="width:7%" onmouseover="this.style.cursor = 'hand';" onclick="sortTable('mTable',8)">操作工号</th>			
		</tr>
		<thead>
		<% 
			//系统变量
			/*
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];
		    String loginNo=session.getAttribute("loginNo").toString();
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    */
		    //业务数据		    
		    HashMap<String, String> map = new HashMap<String, String>();
			map.put("type", request.getParameter("type"));
			map.put("ipPort", request.getParameter("ipPort"));
		%>		
		<si:list name="list" id="WSndCmdDay.selectCmdDetail" param="<%=map %>" scope="end">
			 <logic:iterate id="show" name="list" indexId="i" type="com.sitech.rom.common.dto.WSndCmdDay">
		   		<tr>
		   			<td><%=StringUtil.safeValue(show.getCommandId())%></td>
					<td><%=StringUtil.safeValue(show.getCommandCode())%></td>
					<td><%=StringUtil.safeValue(show.getOtherChar())%></td>
					<td><%=StringUtil.safeValue(show.getSendStatus())%></td>
					<td><%=StringUtil.safeValue(show.getSendTime())%></td>
					<td><%=StringUtil.safeValue(show.getAckCode())%></td>
					<td><%=StringUtil.safeValue(show.getAckTime())%></td>
					<td><%=StringUtil.safeValue(show.getOpCode())%></td>
					<td><%=StringUtil.safeValue(show.getLoginNo())%></td>							   					   								
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////


</script>
</html>
