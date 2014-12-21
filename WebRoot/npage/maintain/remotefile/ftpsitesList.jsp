<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.FtpsitesBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ page import="com.sitech.jcf.core.util.ChnDes" %>
<%@ page import="com.sitech.rom.util.Digests" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">FTP站点列表</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th style="width:10%">选择</th>	
			<th>省份运营商</th>
			<th>主机名称</th>
			<th>主机地址</th>
			<th>主机端口</th>
			<th>站点名称</th>
			<th>FTP用户</th>
			<th>站点描述</th>
			<th>数据类型</th>
		</tr>
		<% 
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];
		            
		    String hostIp = request.getParameter("hostIp").trim();
		    
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    
		    FtpsitesBo ftpsitesBo = new FtpsitesBo();
		    if(proId!=null && !"".equals(proId))ftpsitesBo.setProCode(proId);
		    if(provinceCode!=null && !"".equals(provinceCode))ftpsitesBo.setProvinceCode(provinceCode);
		    if(tellType!=null && !"".equals(tellType))ftpsitesBo.setTellType(tellType);
		    if(hostIp!=null && !"".equals(hostIp))ftpsitesBo.setHostIp(hostIp);
		    ftpsitesBo.setLoginNo(session.getAttribute("loginNo").toString());
		    
		    ChnDes des;
		    String passPw;
		%>
		<si:pagelist name="ftplist" id="sftpsites.qryFtpsites" param="<%=ftpsitesBo %>" scope="end" url="ftpsitesList.jsp">
			 <logic:iterate id="show" name="ftplist" indexId="i" type="com.sitech.rom.common.bo.FtpsitesBo">    
		   		<tr>
		   			<td><input type="button" class="b_foot" value="选择FTP" 
			   		    onclick="choice('<%=StringUtil.safeValue(show.getSiteId())%>',
			   		    '<%=StringUtil.safeValue(show.getHostIp())%>',
			   		    '<%=StringUtil.safeValue(show.getFtpPort())%>',
			   		    '<%=StringUtil.safeValue(show.getRemotePath())%>',
			   		    '<%=StringUtil.safeValue(show.getSiteName())%>',
			   		    '<% des = new ChnDes();
			   		    	passPw = des.decrypt(show.getFtpPassWd());
			   		    	out.print(Digests.MD5(show.getFtpUser()+passPw));
			   		    %>')"/>
 		   			</td>
			   		<td><%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())%></td>
			   		<td><%=StringUtil.safeValue(show.getHostName())%></td>   
			   		<td><%=StringUtil.safeValue(show.getHostIp())%></td>  
			   		<td><%=StringUtil.safeValue(show.getFtpPort())%></td> 
			   		<td><%=StringUtil.safeValue(show.getSiteName())%></td>
			   		<td><%=StringUtil.safeValue(show.getFtpUser())%></td>
			   		<td><%=StringUtil.safeValue(show.getRemarks())%></td>								   		      
					<td><% if(show.getIsOwn()==0){
			   				   out.print("自建");
			   			   }else{
			   			   	   out.print(show.getLoginNo()+"共享");
			   			   } %>
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
 
<script language="javascript" type="text/javascript">
 
function choice(siteId,hostIp,ftpPort,remotePath,siteInfo,desStr){
    parent.setFtp(siteId,hostIp,ftpPort,remotePath,siteInfo,desStr);
} 

</script>
</html>
