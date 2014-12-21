<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">角色列表</div></div>  
<form action="" method="post" name="popedomForm">
	<div class="list">
		<table id="mTable">
			<tr>
				<th style="width:30px">选择</th>
				<th>产品</th>
				<th>省份运营商</th>
				<th>主机名称</th>
				<th>主机IP</th>
				<th>脚本名称</th>
				<th>监控项名称</th> 
				<th>监控项描述</th> 
				<th>数据类型</th>
				<th>备注</th>
			</tr>
			<tbody id="tb" >
			<c:if test="${itemList!=null}"> 
				<c:forEach items="${itemList}" var="item">
					<tr>
						<td><input type="radio" id="radio" name="radioset" value="${item.taskId},${item.itemName},${item.intervalTime}" /></td>
			   			<td>${item.proName}</td>
				   		<td>${item.provinceName}${item.tellName}</td>
				   		<td>${item.hostName}</td>
				   		<td>${item.hostIp}</td>
				   		<td>${item.scriptName}</td>
				   		<td>${item.itemName}</td>
				   		<td>${item.itemDesc}</td>
				   		<td>
				   			<c:choose>
						       <c:when test="${item.isOwn=='0'}">							
						             自建							
						       </c:when>
						       <c:otherwise>								
						            ${item.loginNo}共享
						       </c:otherwise>       									
							</c:choose>
				   		</td>
				   		<td>${item.remark}</td>
			   		</tr>
				</c:forEach>
			</c:if>
			</tbody> 
		</table>
	</div>
	<div id="operation_button">
	    <input type="button" name="su" id="su" onclick="doSet()" class="b_foot" value="确定" />
		<input type="button" name="close" id="close" onclick="parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
	</div>
</form>
</div>	
</div>
<%@ include file="/npage/include/footer.jsp"%>
 </body>
 
<script language="javascript" type="text/javascript">
function doSet(){
    $(":radio").each(function(){
        if($(this).attr("checked")==true){
        	parent.setTaskId($(this).val());
        }
    });
    parent.removeDivWin('divWin');
}
</script>
</html>
