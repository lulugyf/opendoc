<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.dto.RomSysOpLog" %>
<%@ page import="com.sitech.rom.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">工号操作日志</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>操作时间</th>
			<th>操作人员</th>
			<th>产品名称</th>
			<th>模块名称</th>
			<th>操作内容</th>
			<th>备注</th>
		</tr>
		<% 
		    String opStaff = request.getParameter("opStaff").trim();
		    String opTimeStart = request.getParameter("opTimeStart");
		    String opTimeEnd = request.getParameter("opTimeEnd");
		    String proCode = request.getParameter("proCode").trim();
		    String functionCode = request.getParameter("functionCode").trim();
		    
		    RomSysOpLog romSysOpLog = new RomSysOpLog();
	    	if(StringUtil.notNull(opStaff))romSysOpLog.setOpStaff(opStaff);
	    	if(StringUtil.notNull(proCode))romSysOpLog.setProCode(proCode);
	    	if(StringUtil.notNull(functionCode))romSysOpLog.setFunctionCode(functionCode);
		    if(StringUtil.notNull(opTimeStart))romSysOpLog.setOpTimeStart(DateFormat.tolongDate(opTimeStart));
		    if(StringUtil.notNull(opTimeEnd))romSysOpLog.setOpTimeEnd(DateFormat.tolongDate(opTimeEnd));
		    
		%>
		<si:pagelist name="datalist" id="slog.selectOpLog" param="<%=romSysOpLog %>" scope="end" url="log_list.jsp">
			 <logic:iterate id="show" name="datalist" indexId="i" type="RomSysOpLog">    
		   		<tr>
			   		<td><%=StringUtil.safeValue(DateFormat.longDate(show.getOpTime()))%></td>
			   		<td><%=StringUtil.safeValue(show.getOpStaff())%></td>
			   		<td><%=StringUtil.safeValue(show.getProCode())%></td>
			   		<td><%=StringUtil.safeValue(show.getFunctionCode())%></td>
			   		<td><%=StringUtil.safeValue(show.getOpContent())%></td>
			   		<td><%=StringUtil.safeValue(show.getRemarks())%></td>
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
