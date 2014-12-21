<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.HostCheckResultBo" %>
<%@ page import="com.sitech.rom.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">日常运维检查结果</div></div>  
<div class="list">
	<table id="mTable">
		<tr>	
		    <th width="3%">序号</th>
			<th width="5%">省份运营商</th>
			<th width="13%">日检时间</th>
			<th width="5%">日检分类</th>
			<th width="13%">日检项名称</th>
			<th width="15%">日检子项名称</th>	
			<th width="15%">多维数据内容</th>
			<th width="10%">检查结果</th>	
			<th width="6%">检查周期</th>
			<th width="5%">备注</th>	
			<th width="10%">KPI编码</th>	
			
		</tr>
		<% 
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];
		    String proCode= request.getParameter("proCode").trim();
		    String checkTimeStart = request.getParameter("checkTimeStart");
		    String checkTimeEnd = request.getParameter("checkTimeEnd"); 
		    String checkStatus = request.getParameter("checkStatus");
		    
		    HostCheckResultBo hostCheckResultBo = new HostCheckResultBo();
		    //if(proCode!=null && !"".equals(proCode)) hostCheckResultBo.setProCode(proCode);
		    if(proCode!=null) hostCheckResultBo.setProCode(proCode);
		    if(provinceCode!=null && !"".equals(provinceCode)) hostCheckResultBo.setProvinceCode(provinceCode);
		    if(tellType!=null && !"".equals(tellType)) hostCheckResultBo.setTellType(tellType); 	
		    if(checkStatus!=null && !"".equals(checkStatus)) hostCheckResultBo.setErrFlag(checkStatus);  
		    if(StringUtil.notNull(checkTimeStart))hostCheckResultBo.setCheckTimeStart(DateFormat.tolongDate(checkTimeStart));
		    if(StringUtil.notNull(checkTimeEnd))hostCheckResultBo.setCheckTimeEnd(DateFormat.tolongDate(checkTimeEnd));
		%>
		<si:pagelist name="hostCheckResultList" id="RomHostCheckResult.queryHostCheckResult" param="<%=hostCheckResultBo %>" scope="end" url="hostCheckResult_list.jsp">
			 <logic:iterate id="show" name="hostCheckResultList" indexId="i" type="com.sitech.rom.common.bo.HostCheckResultBo">    
		   		<tr>
		   		    <td align="center"><%=StringUtil.printLong(show.getId())%></td>
			   		<td><%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())%></td>		
			   		<td><%=StringUtil.safeValue(DateFormat.longDate(show.getCheckTime()))%></td>
			   		<td><%=StringUtil.safeValue(show.getProCode())%></td>
			   		<td><%=StringUtil.safeValue(show.getFatherSection())%></td>
			   		<td><%=StringUtil.safeValue(show.getChildSection())%></td>			   		
			   		<td><%=StringUtil.safeValue(show.getMulSectionName())%></td>
			   		<td><%if("1".equals(show.getErrFlag())) {%><font color="red"><b><%}%><%=StringUtil.safeValue(show.getCheckValue())%><%if("1".equals(show.getErrFlag())) {%></b></font><%}%></td>
			   		<td><%=StringUtil.safeValue(show.getCheckCycle())%></td>
			   		<td><%if("1".equals(show.getErrFlag())) {%><font color="red"><b><%}%><%=StringUtil.safeValue(show.getRemark())%><%if("1".equals(show.getErrFlag())) {%></b></font><%}%></td>	
			   		<td><%=StringUtil.safeValue(show.getKpiId())%></td>			   				   		
		   		</tr>
		   	 </logic:iterate>  
	    </si:pagelist>
	</table>
</div>
  
</div>	
</div>
<%@ include file="/npage/include/footer.jsp"%>
 </body>
 
<script language="javascript" type="text/javascript" >
$(document).ready(function () {
    parent.unLoading('ajaxLoadingDiv');
});

</script>
</html>
