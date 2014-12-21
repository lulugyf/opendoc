<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomHostCheckItem" %>
<%@ page import="com.sitech.rom.util.*" %>
<html>
<head>
<title>修改日检项目</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostCheckItemForm">
			<br><input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
			<input type=hidden name="seqId" id="seqId" value="${hostCheckItemBo.seqId}">
			<div class="input">
				<table>
					<tr>
						<th><font color="red">*省份运营商:</font></th>
							<td>
								<select name="provinceTell" id="provinceTell">
								<c:if test="${provinceTellcorpList!=null}"> 
								<c:forEach items="${provinceTellcorpList}" var="item">
									<option value="${item.provinceCode}_${item.tellcorpCode}" >${item.provinceName}${item.tellcorpName}</option>
								</c:forEach>
								</c:if>
								</select>
							</td>
						<th><font color="red">*日检分类:</font></th>
							<td>
								<select name="proCode" id="proCode" class="required" onchange="getProName()">
									<option value="" selected="true"></option>
									<option value="主机" >主机</option>
									<option value="进程" >进程</option>
									<option value="接口表" >接口表</option>
									<option value="文件" >文件</option>
									<option value="网络" >网络</option>
									<option value="其他" >其他</option>
									<!-- 
							    	<c:forEach var="item" items="${productList}">
							    		<option value="${item.proCode}">${item.proCode}</option>		
									</c:forEach>
									 -->
								</select>
								<input type="hidden" name="proName" id="proName"/>	
							</td>
					</tr>
					<tr>
						<th><font color="red">*KPI编号:</font></th>
						<td>
							<input type="text" name="kpiId" id="kpiId" value="${hostCheckItemBo.kpiId}"  class="required isCharLengthOf" v_maxlength="32" v_minlength="0" size="30"/>	
						</td>
						<th>检查周期:</th>
						<td>
							<input type="text" name="checkCycle" id="checkCycle"  value="${hostCheckItemBo.checkCycle}"  class="isCharLengthOf" v_maxlength="32" v_minlength="0" size="30"/>	
						</td>
					</tr>
					<tr>						
						<th><font color="red">*日检项名称:</font></th>
						<td>
							<input type="text" name="fatherSection" id="fatherSection"  value="${hostCheckItemBo.fatherSection}"  class="required isCharLengthOf" v_maxlength="64" v_minlength="0" size="30"/>
						</td>
						<th><font color="red">*日检子项名称:</font></th>
						<td>
							<input type="text" name="childSection" id="childSection"  value="${hostCheckItemBo.childSection}"  class="required isCharLengthOf" v_maxlength="64" v_minlength="0" size="30"/>						
						</td>
					</tr> 

					<tr>
						<th>备注:</th>
						<td colspan="3">
								<input type="text" name="remark" id="remark" value="${hostCheckItemBo.remark}" class="isCharLengthOf" v_maxlength="64" v_minlength="0" size="108"/>
						</td> 
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="updateSrchSubmit()" class="b_foot" value="确定" />
				<input type="button" name="re" onClick="resetFrm()" class="b_foot" value="重置" />
				<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
			</div>
			<div align="center">
			    <font color="red"><span id="operInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>
$(document).ready(function () {
	
	//处理下拉列表选中
		//处理下拉列表选中
	var provinceTell=$("#provinceCode").val()+"_"+$("#tellType").val();
	$("#provinceTell").val(provinceTell);

	$("#proCode").val("${hostCheckItemBo.proCode}");

    //关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSrchSubmit();
	    }catch(e){}
	});
	//--end
	$('#proName').val($('#proCode :selected').text());
	$proCode=$('#proCode').html();
});

function resetFrm(){
   	document.forms('hostCheckItemForm').reset();
	var provinceTell=$("#provinceCode").val()+"_"+$("#tellType").val();
	$("#provinceTell").val(provinceTell);
	$("#proCode").val("${hostCheckItemBo.proCode}");
	$("#fatherSection").val("${hostCheckItemBo.fatherSection}");
	$("#childSection").val("${hostCheckItemBo.childSection}");
	$("#kpiId").val("${hostCheckItemBo.kpiId}");
	$("#checkCycle").val("${hostCheckItemBo.checkCycle}");	
	$("#remark").val("${hostCheckItemBo.remark}");	
	/* $("#provinceTell option").each(function(){
    	if($(this).val()!=$('#provinceCode').val()+'_'+$('#tellType').val()){
    		$(this).remove();
    	}
    }); */
    
    	document.forms('hostForm').reset();
	var provinceTell=$("#provinceCode").val()+"_"+$("#tellType").val();
	$("#provinceTell").val(provinceTell);
	$("#proCode").val("${hostCheckItemBo.proCode}");
/* 	$("#provinceTell option").each(function(){
    	if($(this).val()!=$('#provinceCode').val()+'_'+$('#tellType').val()){
    		$(this).remove();
    	}
    }); */
}

function updateSrchSubmit(){
    if(!checksubmit(hostCheckItemForm)){
		return false;
	}
	document.hostCheckItemForm.action='<%=request.getContextPath()%>/updateHostCheckItem.do';
	document.hostCheckItemForm.submit();
	
}

</script>
</body>
</html>