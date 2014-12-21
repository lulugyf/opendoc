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
			<th>业务功能代码</th>
			<th>交易代码</th>
			<th>交易总量</th>
			<th>成功交易量</th>
			<th>用户方原因失败交易量</th>
			<th>非用户原因失败交易量</th>
			<th>超时失败交易量</th>
			<th>响应不及时交易量</th>
		</tr>
		<% 
			String type;
			String chartType=request.getParameter("chartType");
			if("hour".equals(chartType)){
				type="sbusinessReport.qryBusiReportHour";
			}else if("day".equals(chartType)){
				type="sbusinessReport.qryBusiReportDay";
			}else{
				type="sbusinessReport.qryBusiReportMonth";
			}
			
		    String hostId = request.getParameter("hostId");
		    
		    String busiId = request.getParameter("busiId").trim(); //业务ID
		    String transId = request.getParameter("transId").trim(); //交易代码
		    String createDateStart = request.getParameter("createDateStart");
		    String createDateEnd = request.getParameter("createDateEnd");
		    String loginNo=session.getAttribute("loginNo").toString();
		    
		    BusinessDataBo businessDataBo = new BusinessDataBo();
		    if(StringUtil.notNull(hostId))businessDataBo.setHostId(hostId);
		    if(StringUtil.notNull(proId))businessDataBo.setProCode(proId);
	    	if(StringUtil.notNull(busiId))businessDataBo.setItemDesc(busiId);
	    	if(StringUtil.notNull(transId))businessDataBo.setTransId(transId);
		    if(StringUtil.notNull(createDateStart))businessDataBo.setCreateDateStart(DateFormat.tolongDate(createDateStart));
		    if(StringUtil.notNull(createDateEnd))businessDataBo.setCreateDateEnd(DateFormat.tolongDate(createDateEnd));
	    	if(StringUtil.notNull(loginNo))businessDataBo.setLoginNo(loginNo);
		    
		%>
		<si:pagelist name="datalist" id="<%=type %>" param="<%=businessDataBo %>" scope="end" url="businessreport_list.jsp">
			 <logic:iterate id="show" name="datalist" indexId="i" type="BusinessDataBo">    
		   		<tr>
			   		<td><%=StringUtil.safeValue(show.getCreateMinute())%></td>
			   		<td><%=StringUtil.safeValue(show.getItemDesc())%></td>
			   		<td><%=StringUtil.safeValue(show.getTransId())%></td>
			   		<td><%=StringUtil.safeValue(show.getTradeTotal())%></td>
			   		<td><%=StringUtil.safeValue(show.getTradeSucc())%></td>
			   		<td><%=StringUtil.safeValue(show.getFailForUser())%></td>
			   		<td><%=StringUtil.safeValue(show.getFailNotForUser())%></td>
			   		<td><%=StringUtil.safeValue(show.getFailTimeout())%></td>
			   		<td><%=StringUtil.safeValue(show.getFailDelay())%></td>
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
