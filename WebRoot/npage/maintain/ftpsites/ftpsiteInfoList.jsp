<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page import="com.sitech.rom.common.bo.FtpsitesBo" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">FTP站点列表</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>操作</th>
			<th>省份运营商</th>
			<th>主机名称</th>
			<th>站点名称</th>
			<th>主机地址</th>
			<th>FTP用户</th>
			<th>站点描述</th>
		</tr>
		<c:if test="${ftpInfoList!=null}"> 
 			<c:forEach items="${ftpInfoList}" var="item">
				<tr>
					<td><input type="button" class="b_foot" value="选择" 
		   		    	onclick="choice('${item.siteId}','${item.siteName}','${item.hostId}')"/>
		   			</td>
					<td>${item.provinceName}${item.tellName}</td>
					<td>${item.hostName}</td>
					<td>${item.siteName}</td>
					<td>${item.hostIp}</td>
					<td>${item.ftpUser}</td>
					<td>${item.remarks}</td>
				</tr>	 			
 			</c:forEach>
 		</c:if>
	</table>
</div>
  
</div>	
</div>
<%@ include file="/npage/include/footer.jsp"%>
 </body>
 
<script language="javascript" type="text/javascript">
 
//选择当前行内容
function choice(siteId,siteName,hostId){
	parent.setSite(siteId,siteName,hostId);
	closeDivWin();
}
 
</script>
</html>
