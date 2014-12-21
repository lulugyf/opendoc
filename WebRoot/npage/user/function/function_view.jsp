<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<title>系统功能管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" target="ifm" method=post>
	    <div id="operation_table">			
			<div class="input">	
				<table>
					<tr>
						<th>功能代码</th>
						<td>
							${functionBo.functionCode}
							<input type="hidden" name="functionCode" id="functionCode" value="${functionBo.functionCode}"/>
						</td>
						<th>功能名称</th>
						<td>${functionBo.functionName}</td>
					</tr>
					<tr>
						<th>父功能代码</th>
						<td>${functionBo.parentCode}</td>
						<th>父功能名称</th>
						<td>${functionBo.parentName}</td>
					</tr>
					<tr valign="top">
						<th>节点类型</th>
						<td>
							<c:choose>
						       <c:when test="${functionBo.nodeType=='0'}">							
						             可见
						       </c:when>
						       <c:otherwise>								
						             不可见
						       </c:otherwise>       									
							</c:choose>
						</td>
						<th>操作项</th>
						<td>
						
							<c:if test="${functionBo.operationName!=null}">
							    <c:forTokens items="${functionBo.operationName}" delims=";" var="tech">
									${fn:split(tech, "_")[1]}<br/>
								</c:forTokens>
							</c:if>
						</td>
					</tr>
					<tr>
					    <th>显示顺序</th>
						<td>${functionBo.noteSeq}</td>
                        <th>打开方式：</th> 
                        <td>                        	
                        	<span id="openType" name="openType"></span>
                    	</td>
					</tr>
					<tr>
					    <th>功能链接</th>
						<td colspan="3">${functionBo.actionName}</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" id="del" name="del" style="display:none" value="删除" onclick="showDialog('关联数据信息将同步删除，是否确认删除?',3,'retT=doDelSubmit()');"/>
					  	</td>
					</tr>
				</table>
				<div align="center">
				    <font color="red"><span id="operInfo">${operInfo}</span></font>
				</div>
			</div>
				
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>				
</body>
<script>
function doDelSubmit(){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/functionDelete.do");
	packet.data.add("functionCode" ,'${functionBo.functionCode}');
	packet.data.add("functionName" ,'${functionBo.functionName}');
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	core.ajax.sendPacketHtml(packet,doDelBack);
	packet =null;
}
function doDelBack(data){
	if(data=='0'){
	    $('#operInfo').html('功能删除成功！');
	    parent.resetValue();
	    parent.getFunctionTree(); //刷新功能树
	}else if(data=='1'){
	    $('#operInfo').html('功能删除异常！');
	}else if(data=='noright'){
	    $('#operInfo').html('您没有权限进行此操作！');
	}
}
/***********显示隐藏功能权限对应按钮 begin***************/
$(document).ready(function () {
    if('Y'=='<%=request.getParameter("del")%>'){
    	$('#del').css('display','');
    }
    
    //初始化信息	
	if("${functionBo.openType}" == "1"){
		g("openType").innerText = "一级TAB";
	}else if("${functionBo.openType}" == "2"){
		g("openType").innerText = "二级TAB";
	}else if("${functionBo.openType}" == "3"){
		g("openType").innerText = "动态";
	}else if("${functionBo.openType}" == "4"){
		g("openType").innerText = "集成页面";
	}else if("${functionBo.openType}" == "9"){
		g("openType").innerText = "弹出";
	}
    
});
/***********显示隐藏功能权限对应按钮 end***************/
/////////////////////////////////////////////////
function g(o){
	return document.getElementById(o);
}
</script>
</html>