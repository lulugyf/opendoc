<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>查询主机信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" target="ifmHost" method=post>
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
						<th>主机环境：</th>
						<td>
							<select name="hostEnv" id="hostEnv" >
								<option value="" ></option>
								<option value="0">测试环境</option>
								<option value="1">生产环境</option>
								<option value="2">开发环境</option>							
							</select>								
						</td>
					</tr> 
					<tr>					
						<th>主机操作系统：</th>
						<td>
							<select name="hostOs" id="hostOs" >
								<option value="" ></option>
								<option value="0">aix</option>
								<option value="1">hp</option>
								<option value="2">sun</option>
								<option value="3">linux</option>
								<option value="4">其他</option>						
							</select>				
						</td><th>主机IP：</th>
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
			
			<iframe name="ifmHost" src="" style="width:100%;height:230px;" frameborder="0"></iframe>
			 
			 	
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>						
</body>

<script language="javascript" type="text/javascript">
$(document).ready(function () {
    $("#provinceTell option").each(function(){
    	if($(this).val()!=$('#provinceCode').val()+'_'+$('#tellType').val()){
    		$(this).remove();
    	}
    });
});
//查询表单提交
function doSrchSubmit(){
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/host/host/hostInfoList.jsp";
    document.forms['srchFrm'].submit();
    unLoading('ajaxLoadingDiv');
}

function setHost(hostId,hostInfo,hostIp){
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	
	var packet = new AJAXPacket("<%=request.getContextPath()%>/doRelateHost.do");
	packet.data.add("hostId" ,hostId);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,provinceCode);
	packet.data.add("tellType" ,tellType);
	core.ajax.sendPacket(packet,doRelateRow);
	packet =null;
}

function doRelateRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("主机关联成功！",2);
  	    parent.closeDivWin();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("主机关联失败，主机关联或已存在！",0);
  	}
}
</script>
</html>