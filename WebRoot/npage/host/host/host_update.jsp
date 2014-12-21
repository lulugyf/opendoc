<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>修改主机信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
			<input type=hidden name="hostId" id="hostId" value="${romHostInfo.hostId}">
			<div class="input">
				<table>
					<tr>
						<th><font color="red">*省份运营商：</font></th>
						<td>
							<select name="provinceTell" id="provinceTell">
							<c:if test="${provinceTellcorpList!=null}"> 
							<c:forEach items="${provinceTellcorpList}" var="item">
								<option value="${item.provinceCode}_${item.tellcorpCode}" >${item.provinceName}${item.tellcorpName}</option>
							</c:forEach>
							</c:if>
							</select>
						</td>
						<th></th>
						<td></td>
					</tr>					
					<tr>
						<th><font color="red">*主机环境：</font></th>
						<td>
							<select name="hostEnv" id="hostEnv" class="required">
								<option value="" ></option>
								<option value="0">测试环境</option>
								<option value="1">生产环境</option>
								<option value="2">开发环境</option>							
							</select>						
						</td>					
						<th><font color="red">*主机操作系统：</font></th>
						<td>
							<select name="hostOs" id="hostOs" class="required">
								<option value="" ></option>
								<option value="0">aix</option>
								<option value="1">hp</option>
								<option value="2">sun</option>
								<option value="3">linux</option>
								<option value="4">其他</option>							
							</select>						
						</td>
					</tr>
					<tr>
						<th><font color="red">*主机IP：</font></th>
						<td>
							<input type="text" name="hostIp" id="hostIp" value="${romHostInfo.hostIp}"  class="required ipAddress isCharLengthOf" v_maxlength="32" v_minlength="0"/>
						</td>
						<th><font color="red">*主机名称：</font></th>
						<td>
							<input type="text" name="hostName" id="hostName" value="${romHostInfo.hostName}"  class="required isCharLengthOf" v_maxlength="32" v_minlength="0"/>
						</td>											
					</tr>					
					<tr>
						<th>备注：</th>
						<td colspan="3">
							<input type="text" name="remark" id="hostIp"  value="${romHostInfo.remark}"  class="isCharLengthOf" v_maxlength="128" v_minlength="0" size="100"/>
						</td> 				
					</tr>					
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="updateHostSubmit()" class="b_foot" value="确定" />
				<input type="button" name="re" onClick="resetFrm()" class="b_foot" value="重置" />
				<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
			</div>
			<div align="center">
			    <font color="red"><span id="succInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>
$(document).ready(function () {
	
	//处理下拉列表选中
	var provinceTell=$("#provinceCode").val()+"_"+$("#tellType").val();
	$("#provinceTell").val(provinceTell);
	$("#hostEnv").val("${romHostInfo.hostEnv}");
	$("#hostOs").val("${romHostInfo.hostOs}");
	
    //关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSrchSubmit();
	    }catch(e){}
	});
	//--end
	
	$("#provinceTell option").each(function(){
    	if($(this).val()!=$('#provinceCode').val()+'_'+$('#tellType').val()){
    		$(this).remove();
    	}
    });
});

function updateHostSubmit(){
    if(!checksubmit(hostForm)){
		return false;
	}
	
	document.hostForm.action='<%=request.getContextPath()%>/updateHost.do';
	document.hostForm.submit();
	
}

function resetFrm(){
	document.forms('hostForm').reset();
	var provinceTell=$("#provinceCode").val()+"_"+$("#tellType").val();
	$("#provinceTell").val(provinceTell);
	$("#hostEnv").val("${romHostInfo.hostEnv}");
	$("#hostOs").val("${romHostInfo.hostOs}");
	$("#provinceTell option").each(function(){
    	if($(this).val()!=$('#provinceCode').val()+'_'+$('#tellType').val()){
    		$(this).remove();
    	}
    });
}
</script>
</body>
</html>