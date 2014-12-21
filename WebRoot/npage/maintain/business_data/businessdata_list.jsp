<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.BusinessDataBo" %>
<%@ page import="com.sitech.rom.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">交易量统计</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>监控时间</th>
			<th>交易代码</th>
			<th>交易总量</th>
			<th>成功交易量</th>
			<th>用户方原因失败交易量</th>
			<th>非用户原因失败交易量</th>
			<th>超时失败交易量</th>
			<th>响应不及时交易量</th>
		</tr>
		<% 
			String type="sbusinessData.qryBusiDataInfo";
			String chartType=request.getParameter("chartType");
			if("hour".equals(chartType)){
				type="sbusinessData.qryBusiDataHour";
			}else if("day".equals(chartType)){
				type="sbusinessData.qryBusiDataDay";
			}else if("month".equals(chartType)){
				type="sbusinessData.qryBusiDataMonth";
			}
			
		    String provinceCode = request.getParameter("provinceCode");
		    String tellType = request.getParameter("tellType");
		    
		    String busiId = request.getParameter("busiId"); //业务ID
		    String taskId = request.getParameter("taskId");
		    String transId = request.getParameter("transId").trim(); //交易代码
		    String scriptId = request.getParameter("scriptId"); //脚本id
		    String createDateStart = request.getParameter("createDateStart");
		    String createDateEnd = request.getParameter("createDateEnd");
		    
		    BusinessDataBo businessDataBo = new BusinessDataBo();
	    	if(StringUtil.notNull(busiId))businessDataBo.setItemDesc(busiId);
	    	if(StringUtil.notNull(taskId))businessDataBo.setTaskId(taskId);
	    	if(StringUtil.notNull(transId))businessDataBo.setTransId(transId);
		    if(StringUtil.notNull(createDateStart))businessDataBo.setCreateDateStart(DateFormat.tolongDate(createDateStart));
		    if(StringUtil.notNull(createDateEnd))businessDataBo.setCreateDateEnd(DateFormat.tolongDate(createDateEnd));
		    
		%>
		<si:pagelist name="datalist" id="<%=type %>" param="<%=businessDataBo %>" scope="end" url="businessdata_list.jsp">
			 <logic:iterate id="show" name="datalist" indexId="i" type="BusinessDataBo">    
		   		<tr>
			   		<td><%=StringUtil.safeValue(show.getCreateMinute())%></td>
			   		<td><%=StringUtil.safeValue(show.getTransId())%></td>
			   		<td><%=StringUtil.safeValue(show.getTradeTotal())%></td>
			   		<td><%=StringUtil.safeValue(show.getTradeSucc())%></td>
			   		<td>
			   			<a style="text-decoration:underline;<%if(!"0".equals(show.getFailForUser().trim())){%>color:orange<%}%>" href="#this" onclick="showDetail('<%=scriptId%>','<%=busiId%>','<%=StringUtil.safeValue(show.getTransId())%>','userReason')">
			   				<%=StringUtil.safeValue(show.getFailForUser())%>
			   			</a>
			   		</td>
			   		<td>
			   			<a style="text-decoration:underline;<%if(!"0".equals(show.getFailNotForUser().trim())){%>color:orange<%}%>" href="#this" onclick="showDetail('<%=scriptId%>','<%=busiId%>','<%=StringUtil.safeValue(show.getTransId())%>','unuserReason')">
			   				<%=StringUtil.safeValue(show.getFailNotForUser())%>
			   			</a>
			   		</td>
			   		<td>
			   			<a style="text-decoration:underline;<%if(!"0".equals(show.getFailTimeout().trim())){%>color:orange<%}%>" href="#this" onclick="showDetail('<%=scriptId%>','<%=busiId%>','<%=StringUtil.safeValue(show.getTransId())%>','timeout')">
			   				<%=StringUtil.safeValue(show.getFailTimeout())%>
			   			</a>
			   		</td>
			   		<td>
			   			<a style="text-decoration:underline;<%if(!"0".equals(show.getFailDelay().trim())){%>color:orange<%}%>" href="#this" onclick="showDetail('<%=scriptId%>','<%=busiId%>','<%=StringUtil.safeValue(show.getTransId())%>','respuntimely')">
			   				<%=StringUtil.safeValue(show.getFailDelay())%>
			   			</a>	
			   		</td>
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
parent.reinitIframe();
function showDetail(scriptId,busiId,transId,failType){
	var qryParaTime="busiId="+busiId+'&scriptId='+scriptId+'&transId='+transId+'&failType='+failType+'&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode=<%=provinceCode%>&tellType=<%=tellType%>';
    parent.openDivWin("<%=request.getContextPath()%>/businessFailDetail.do?"+qryParaTime,"失败交易详情","800","460");
}

</script>
</html>
