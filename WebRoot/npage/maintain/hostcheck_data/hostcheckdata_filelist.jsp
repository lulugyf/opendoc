<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.HostCheckDataBo" %>
<%@ page import="com.sitech.rom.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="list">
	<table id="mTable">
		<tr>
			<th>巡检时间</th>
			<th>文件系统名称</th>
			<th>文件总大小</th>
			<th>已使用</th>
			<th>未使用</th>
			<th>使用百分比</th>
		</tr>
		<% 
		    String hostId = request.getParameter("hostId");
		    String funcCode = request.getParameter("funcCode");
		    String createDateStart = request.getParameter("createDateStart");
		    String createDateEnd = request.getParameter("createDateEnd");
		    
		    HostCheckDataBo hostCheckDataBo = new HostCheckDataBo();
	    	if(StringUtil.notNull(hostId))hostCheckDataBo.setHostId(hostId);
	    	if(StringUtil.notNull(funcCode))hostCheckDataBo.setFuncCode(funcCode);
		    if(StringUtil.notNull(createDateStart))hostCheckDataBo.setCreateDateStart(DateFormat.tolongDate(createDateStart+" 00:00:00"));
		    if(StringUtil.notNull(createDateEnd))hostCheckDataBo.setCreateDateEnd(DateFormat.tolongDate(createDateEnd+" 23:59:59"));
		        
		%>
		<si:pagelist name="datalist" id="shostcheck.qryHostCheckFileInfo" param="<%=hostCheckDataBo %>" scope="end" url="hostcheckdata_filelist.jsp">
			 <logic:iterate id="show" name="datalist" indexId="i" type="HostCheckDataBo">    
		   		<tr>
			   		<td><%=StringUtil.safeValue(DateFormat.longDate(show.getCreateDate()))%></td>
			   		<td><%=StringUtil.safeValue(show.getFileName())%></td>
			   		<td><%=StringUtil.safeValue(show.getFileSize())%></td>
			   		<td><%=StringUtil.safeValue(show.getFileUsed())%></td>
			   		<td><%=StringUtil.safeValue(show.getFileLeft())%></td>
			   		<td><%
			   				if(Long.parseLong(show.getFileSizeLong())!=0){
			   					float a = Float.parseFloat(show.getFileUsedLong())/Long.parseLong(show.getFileSizeLong());
			   					float b = Float.parseFloat(show.getFileUsedLong())%Long.parseLong(show.getFileSizeLong());
			   					out.print(a*100+"%");
			   				}else{
			   					out.print("0");
			   				}
			   			%></td>
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
parent.reinitIframeFile();
parent.unLoading('ajaxLoadingDiv');
</script>
</html>
