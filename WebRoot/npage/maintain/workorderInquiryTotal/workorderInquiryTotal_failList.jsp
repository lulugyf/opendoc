<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page import="com.sitech.rom.common.dto.WSndCmdDay" %>
<%@ page import="com.sitech.rom.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">失败工单明细查询结果</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>网元编号</th>
			<th>对应区域</th>
			<th>智能卡号</th>
			<th>用户证号</th>			
			<th>工单流水</th>
			<th>发送时间</th>
			<th>业务编码</th>
			<th>指令内容</th>
			<th>指令处理结果代码</th>
			<th>指令处理结果说明</th>
		</tr>
		<% 
		    String opTimeStart = request.getParameter("opTimeStart");
		    String opTimeEnd = request.getParameter("opTimeEnd");
		    String tableName = request.getParameter("tableName");
		    String hlrCode = request.getParameter("hlrCode");
		    String fromId = request.getParameter("fromId");
		    
		    
		    WSndCmdDay wSndCmdDay = new WSndCmdDay();
		    if(StringUtil.notNull(opTimeStart)) wSndCmdDay.setOpTimeStart(DateFormat.tolongDate(opTimeStart));
		    if(StringUtil.notNull(opTimeEnd)) wSndCmdDay.setOpTimeEnd(DateFormat.tolongDate(opTimeEnd));
		    if(StringUtil.notNull(tableName)) wSndCmdDay.setTableName(tableName);
		    if(StringUtil.notNull(hlrCode)) wSndCmdDay.setHlrCode(hlrCode);
		    if(StringUtil.notNull(fromId)) wSndCmdDay.setFromId(fromId);
		%>
		<si:pagelist name="datalist" id="WSndCmdDay.select-total-inquiry-fail" param="<%=wSndCmdDay %>" scope="end" url="workorderInquiryTotal_failList.jsp">
			 <logic:iterate id="show" name="datalist" indexId="i" type="WSndCmdDay">    
		   		<tr>
			   		<td><%=StringUtil.safeValue(show.getHlrCode())%></td>
			   		<td><%=StringUtil.safeValue(show.getFromId())%></td>
			   		<td><%=StringUtil.safeValue(show.getImsiNo())%></td>
			   		<td><%=StringUtil.safeValue(show.getIdNo())%></td>
			   		<td><%=StringUtil.safeValue(show.getLoginAccept())%></td>
			   		<td><%=StringUtil.safeValue(show.getSendTime())%></td>
			   		<td><%=StringUtil.safeValue(show.getOpCode())%></td>
			   		<td><%=StringUtil.safeValue(show.getOtherChar())%></td>
			   		<td><%=StringUtil.safeValue(show.getAckCode())%></td>
			   		<td><%=StringUtil.safeValue(show.getAckInfo())%></td>
		   		</tr>
		   	 </logic:iterate>  
	    </si:pagelist>
	</table>
</div>
  
</div>	
</div>
<%@ include file="/npage/include/footer.jsp"%>
</body>
<script>
parent.unLoading('ajaxLoadingDiv');
</script>
</html>
