<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>日志管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" target="ifm" method=post>
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		
		<%@ include file="/npage/include/header.jsp"%>
	    <div id="operation_table">			
			<div class="input">	
				<table>
					<tr>
						<th>操作人工号：</th>
						<td><input type="text" name="opStaff" id="opStaff"/></td>
						<th></th>
						<td></td>						
					</tr>
					<tr>
						<th>产品名称：</th>
						<td>
						    <select name="proCode" id="proCode" onchange="getFuncList();getProName()">
								<option value="" ></option>
								<c:if test="${productList!=null}"> 
								<c:forEach items="${productList}" var="item">	
									<option value="${item.proCode}" >${item.proName} ${item.proVersion}</option>
								</c:forEach>
								</c:if>
							</select>
							<input type="hidden" name="proName" id="proName"/>
						</td>
						<th>模块名称：</th>
						<td>
							<select name="functionCode" id="functionCode" onchange="getFuncName()">
								<option value="" ></option>
							</select>
							<input type="hidden" name="functionName" id="functionName"/>
						</td>						
					</tr>
 					<tr>
						<th>*操作时间起：</th>
						<td><input id="opTimeStart" name="opTimeStart" type="text" class="required"
									onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,maxDate:'#F{$dp.$D(\'opTimeEnd\')}'})"/></td>
						<th>*操作时间止：</th>
						<td><input id="opTimeEnd" name="opTimeEnd" type="text" class="required"
									onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,minDate:'#F{$dp.$D(\'opTimeStart\')}'})"/></td>
					</tr>
 
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="javascript:document.forms('srchFrm').reset();"/>
					  		<input type="button" class="b_foot" value="导出" onclick="doReport()"/>
					  	</td>
					</tr>
				</table>
			</div>
			
			<iframe name="ifm" src="" style="width:100%;height:400px;" frameborder="0"></iframe>
			<iframe name="rptExport" id="rptExport" src="" style="display:none"></iframe>
			
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>						
</body>
<!-- 自动补全引入js -->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/myactb.js"></script>
<script language="javascript" type="text/javascript">

//查询表单提交
function doSrchSubmit(){
	if(!checksubmit(srchFrm)){
		return false;
	}
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/log/log_list.jsp";
    document.forms['srchFrm'].target='ifm';
    document.forms['srchFrm'].submit();
}

function doReport(){
	if(!checksubmit(srchFrm)){
		return false;
	}
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/logReportExport.do";
    document.forms['srchFrm'].target='rptExport';
    document.forms['srchFrm'].submit();
    unLoading('ajaxLoadingDiv');
    doSrchSubmit();
}

function getProName(){
	$('#proName').val($('#proCode :selected').text());
}

function getFuncName(){
	$('#functionName').val($('#functionCode :selected').text());
}


//分组选择
function getFuncList(){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/getFunctionByProCode.do");
	packet.data.add("loginNo" ,'<%=session.getAttribute("loginNo").toString()%>');
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("proCode" ,$("#proCode").val());
	core.ajax.sendPacketHtml(packet,doGetFuncBack);
	packet =null;
}
function doGetFuncBack(data){
	$("#functionCode").empty();
	$("#functionCode").append('<option value=""></option>');
	if(data=='noright'){
	    parent.parent.showDialog("您没有权限进行此操作！",0);
	}else if(data!=''){
		var arr=decodeURI(data).split(',');
		for(var i=0;i<arr.length;i++){
			var sp=arr[i].split('_');
			$("#functionCode").append('<option value="'+sp[0]+'">'+sp[1]+'</option>');
		}
	}
}

</script>
</html>