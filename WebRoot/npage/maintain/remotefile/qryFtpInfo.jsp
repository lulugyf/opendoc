<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>FTP站点</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" target="ifm" method=post>
	<input type=hidden name="proId" id="proId" value="<%=proId%>">
	<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
		<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
	    <div id="operation_table">			
			<div class="input">	
				<table>
					<tr>
						<th>省份运营商：</th>
						<td>
							<select name="provinceTell" id="provinceTell">
							<c:if test="${provinceTellcorpList!=null}"> 
							<c:forEach items="${provinceTellcorpList}" var="item">
								<option value="${item.provinceCode}_${item.tellcorpCode}" >${item.provinceName}${item.tellcorpName}</option>
							</c:forEach>
							</c:if>
							</select>
						</td>
						<th>主机IP：</th>
						<td>
							<input type="text" name="hostIp" id="hostIp"/>
						</td>	
					</tr>
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="javascript:document.forms('srchFrm').reset();"/>&nbsp;&nbsp;
					  </td>
					</tr>
				</table>
			</div>
			
			<iframe name="ifm" src="" style="width:100%;height:200px;" frameborder="0"></iframe>
			 
			 	
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>						
</body>
<script language="javascript" type="text/javascript">
/***********显示隐藏功能权限对应按钮 begin***************/
$(document).ready(function () {
    $("#provinceTell option").each(function(){
    	if($(this).val()!=$('#provinceCode').val()+'_'+$('#tellType').val()){
    		$(this).remove();
    	}
    });
});
/***********显示隐藏功能权限对应按钮 end***************/

//查询表单提交
function doSrchSubmit(){
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/maintain/remotefile/ftpsitesList.jsp";
    document.forms['srchFrm'].submit();
    unLoading('ajaxLoadingDiv');
}
 
function setFtp(siteId,hostIp,ftpPort,remotePath,siteInfo,desStr){
	parent.setFtp(siteId,hostIp,ftpPort,remotePath,siteInfo,desStr);
	closeDivWin();
}
 
</script>
</html>