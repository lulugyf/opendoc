<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.dto.WSndCmdDay" %>
<%@ page import="com.sitech.rom.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">工单统计信息</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>网元编号</th>
			<th>对应区域</th>
			<th>工单总数</th>
			<th>成功数</th>
			<th>失败数</th>
			<th>成功率</th>
			<th>失败率</th>
		</tr>
		<% 
		    String opTimeStart = request.getParameter("opTimeStart");
		    String opTimeEnd = request.getParameter("opTimeEnd");
		    String tableName = request.getParameter("tableName");
		    String cellCode = request.getParameter("cellCode");
		    String hlrCode = request.getParameter("hlrCode");
		    String fromId = request.getParameter("fromId");

		    
		    WSndCmdDay wSndCmdDay = new WSndCmdDay();
		    if(StringUtil.notNull(opTimeStart)) wSndCmdDay.setOpTimeStart(DateFormat.tolongDate(opTimeStart));
		    if(StringUtil.notNull(opTimeEnd)) wSndCmdDay.setOpTimeEnd(DateFormat.tolongDate(opTimeEnd));
		    if(StringUtil.notNull(tableName)) wSndCmdDay.setTableName(tableName);
		    if(StringUtil.notNull(hlrCode)) wSndCmdDay.setHlrCode(hlrCode);
		    if(StringUtil.notNull(fromId)) wSndCmdDay.setFromId(fromId);
		%>
		<si:pagelist name="datalist" id="WSndCmdDay.select-total-inquiry" param="<%=wSndCmdDay %>" scope="end" url="workorderInquiryTotal_list.jsp">
			 <logic:iterate id="show" name="datalist" indexId="i" type="WSndCmdDay">    
		   		<tr>
			   		<td><%=StringUtil.safeValue(show.getHlrCode())%></td>
			   		<td><%=StringUtil.safeValue(show.getFromId())%></td>
			   		<td><%=StringUtil.safeValue(show.getTotalNum())%></td>
			   		<td><%=StringUtil.safeValue(show.getSuccNum())%></td>
			   		<td>
			   		   <a style="text-decoration:underline;<%if(!"0".equals(StringUtil.printLong(show.getFailNum()))){%>color:red<%}%>" href="#this" onclick="showDetail('<%=opTimeStart%>','<%=opTimeEnd%>','<%=tableName%>','<%=StringUtil.safeValue(show.getHlrCode())%>','<%=StringUtil.safeValue(show.getFromId())%>')">
			   				<%=StringUtil.safeValue(show.getFailNum())%>
			   			</a>
			   		</td>
			   		<td><%=show.getSuceccPerc()%>%</td>
			   		<td><%=show.getFailPerc() %>%</td>
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

function showDetail(opTimeStart,opTimeEnd,tableName,hlrCode,fromId){
	var qryParaTime="opTimeStart="+opTimeStart+'&opTimeEnd='+opTimeEnd+'&tableName='+tableName+'&hlrCode='+hlrCode+'&fromId'+fromId+'&proId=<%=proId%>&opCode=<%=opCode%>';
    parent.openDivWin("<%=request.getContextPath()%>/npage/maintain/workorderInquiryTotal/workorderInquiryTotal_failList.jsp?"+qryParaTime,"失败工单详情","1000","400");
}

</script>
</script>
</html>
