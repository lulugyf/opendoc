<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page import="com.sitech.rom.common.bo.HostBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="list">
	<table id="mTable">
		<tr>
			<th>操作</th>
			<th>省份运营商</th>
			<th>主机IP</th>
			<th>进程名称</th>
			<th>进程描述</th>
			<th>数据类型</th>
		</tr>
 		<tbody>
	 		<c:if test="${progInfoList!=null}"> 
	 			<c:forEach items="${progInfoList}" var="item">
					<tr>
						<td><input type="button" class="b_foot" value="选择" 
			   		    onclick="choice('${item.itemId}','${item.itemName}')"/>
 		   				</td>
						<td>${item.provinceName}${item.tellName}</td>
 						<td>${item.hostIp}</td>
 						<td>${item.itemName}</td>
 						<td>${item.itemDesc}</td>
 						<td>自建</td>
					</tr>	 			
	 			</c:forEach>
	 		</c:if>
 		</tbody>
	</table>
</div>
  
</div>	
</div>
<%@ include file="/npage/include/footer.jsp"%>
 </body>
 
<script language="javascript" type="text/javascript">
 
//选择当前行内容
function choice(itemId,itemName){
	//alert("1111 "+itemId+":"+itemName);
	parent.setItem(itemId,itemName);
	closeDivWin();	
}
 

</script>
</html>
