<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.FtpScriptBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">FTP脚本列表</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th style="width:10%">选择</th>	
			<th>产品</th>
			<th>省份运营商</th>
			<th>主机IP</th>
			<th>工单名称</th>
			<th>动作名称</th>
			<th>脚本目录</th>
			<th>脚本名称</th>
			<th>请求URL</th>
		</tr>
		<% 
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];
		    String hostIp = request.getParameter("hostIp").trim();
		    
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    
		    FtpScriptBo ftpScriptBo = new FtpScriptBo();
		    if(proId!=null && !"".equals(proId))ftpScriptBo.setProCode(proId);
		    if(provinceCode!=null && !"".equals(provinceCode))ftpScriptBo.setProvinceCode(provinceCode);
		    if(tellType!=null && !"".equals(tellType))ftpScriptBo.setTellType(tellType);
		    if(hostIp!=null && !"".equals(hostIp))ftpScriptBo.setHostIp(hostIp);
		    
		%>
		<si:pagelist name="ftplist" id="sftpScript.qryFtpScriptInfo" param="<%=ftpScriptBo %>" scope="end" url="ftpsitesScriptList.jsp">
			 <logic:iterate id="show" name="ftplist" indexId="i" type="com.sitech.rom.common.bo.FtpScriptBo">    
		   		<tr>
		   			<td><input type="button" class="b_foot" value="选择FTP" 
			   		    onclick="choice('<%=StringUtil.safeValue(show.getScriptsId())%>',
			   		    '<%=StringUtil.safeValue(show.getSiteId())%>',
			   		    '<%=StringUtil.safeValue(show.getHostIp())%>',
			   		    '<%=StringUtil.safeValue(show.getRemotePath())%>',
			   		    '<%=StringUtil.safeValue(show.getSiteName())%>')"/>
 		   			</td>
		   			<td><%=StringUtil.safeValue(show.getProName())%></td>
			   		<td><%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())%></td>
			   		<td><%=StringUtil.safeValue(show.getHostIp())%></td>
			   		<td><%=StringUtil.safeValue(show.getSiteName())%></td>
					<td><%=StringUtil.safeValue(show.getActionName())%></td>				   		      
			   		<td><%=StringUtil.safeValue(show.getScriptsDir())%></td>
			   		<td><%=StringUtil.safeValue(show.getScriptsName())%></td>
			   		<td><%=StringUtil.safeValue(show.getReqUrl())%></td>							   		      

		   		</tr>
		   	 </logic:iterate>  
	    </si:pagelist>
	</table>
</div>
 
</div>	
</div>
<%@ include file="/npage/include/footer.jsp"%>
 </body>
 
<script language="javascript" type="text/javascript">
 
function choice(scriptId,siteId,hostIp,remotePath,siteName){
	//alert(scriptId+hostIp+remotePath+siteName);
    parent.setFtpScript(scriptId,siteId,hostIp,remotePath,siteName);
} 

</script>
</html>
