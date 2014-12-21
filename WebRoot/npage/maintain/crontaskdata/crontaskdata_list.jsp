<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.CronTaskDataBo" %>
<%@ page import="com.sitech.rom.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">执行结果</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>省份运营商</th>
			<th>主机名称</th>
			<th>主机IP</th>
			<th>监控项名称</th>
			<th>数据生成时间</th>
			<th>结果项名称</th>
			<th>结果项数据</th>
			<th>结果项单位</th>
		</tr>
		<% 
		    String taskId = request.getParameter("taskId");
		    String createDateStart = request.getParameter("createDateStart");
		    String createDateEnd = request.getParameter("createDateEnd");
		    
		    CronTaskDataBo cronTaskDataBo = new CronTaskDataBo();
	    	if(StringUtil.notNull(taskId))cronTaskDataBo.setTaskId(Long.parseLong(taskId));
		    if(StringUtil.notNull(createDateStart))cronTaskDataBo.setCreateDateStart(DateFormat.tolongDate(createDateStart));
		    if(StringUtil.notNull(createDateEnd))cronTaskDataBo.setCreateDateEnd(DateFormat.tolongDate(createDateEnd));
		        
		%>
		<si:pagelist name="datalist" id="scronTaskData.qryCronTaskDataInfo" param="<%=cronTaskDataBo %>" scope="end" url="crontaskdata_list.jsp">
			 <logic:iterate id="show" name="datalist" indexId="i" type="CronTaskDataBo">    
		   		<tr>
			   		<td><%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())%></td>
			   		<td><%=StringUtil.safeValue(show.getHostName())%></td>
			   		<td><%=StringUtil.safeValue(show.getHostIp())%></td>
			   		<td><%=StringUtil.safeValue(show.getItemName())%></td>
			   		<td><%=StringUtil.safeValue(DateFormat.longDate(show.getCreateDate()))%></td>
			   		<td><%=StringUtil.safeValue(show.getResultItemName())%></td>
			   		<td><%=StringUtil.safeValue(show.getItemData())%></td>
			   		<td><%=StringUtil.safeValue(show.getItemDimension())%></td>
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
