<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>业务报表</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" method=post>
		<%@ include file="/npage/include/header.jsp"%>
	    <div id="operation_table">			
			<div class="input">
				<table>
					<tr>
						<th>*省份运营商：</th>
						<td>
							<select name="provinceTell" id="provinceTell" onchange="clearHost()">
							<c:if test="${provinceTellcorpList!=null}"> 
							<c:forEach items="${provinceTellcorpList}" var="item">
								<option value="${item.provinceCode}_${item.tellcorpCode}" >${item.provinceName}${item.tellcorpName}</option>
							</c:forEach>
							</c:if>
							</select>
							<input type="hidden" name="provinceName" id="provinceName"/>
						</td>
						<th>*主机：</th>
						<td>
							<input type="text" name="hostName" id="hostName" class="required" readonly="readonly" />
							<input type=hidden name="hostId" id="hostId" >
							<input type="button" name="choiceButton" onClick="choiceHostInfo();" class="b_foot" value="选择主机" />
						</td>
					</tr>
					<tr>
						<th>*开始时间：</th>
						<td><input id="createDateStart" name="createDateStart" type="text" class="required"
									onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,maxDate:'#F{$dp.$D(\'createDateEnd\')}'})"/></td>
						<th>*结束时间：</th>
						<td><input id="createDateEnd" name="createDateEnd" type="text" class="required"
									onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,minDate:'#F{$dp.$D(\'createDateStart\')}'})"/></td>
					</tr>
					<tr>
						<th>业务功能代码：</th>
						<td><input id="busiId" name="busiId" type="text" class=""/></td>
						<th>交易代码：</th>
						<td><input id="transId" name="transId" type="text" class=""/></td>
					</tr>
					<tr>
						<th>趋势图类型：</th>
						<td>
							<input type="radio" name="chartType" value="month"/>按月
							<input type="radio" name="chartType" value="day"/>按天
							<input type="radio" name="chartType" value="hour" checked="true"/>按小时
							<input type="button" class="b_foot" value="趋势图" onclick="doShowChart()"/>
						</td>
						<th></th>
						<td></td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="document.forms('srchFrm').reset();"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="导出" onclick="doReport()"/>
					  </td>
					</tr>
				</table>
					
			</div>
			
			<iframe name="ifm" id="ifm" src="" style="width:100%;height:400px" frameborder="0"></iframe>
			
			<iframe name="rptExport" id="rptExport" src="" style="display:none"></iframe>
			
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>						
</body>

<script language="javascript" type="text/javascript">
//查询表单提交
function doSrchSubmit(){
	
	if(!checksubmit(srchFrm)){
		return false;
	}
	
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var qryPara='?proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/maintain/business_report/businessreport_list.jsp"+qryPara;
    document.forms['srchFrm'].target='ifm';
    document.forms['srchFrm'].submit();
    
}

//趋势图
function doShowChart(){	
	if(!checksubmit(srchFrm)){
		return false;
	}
	if($.trim($('#busiId').val())==''){
		alert('请填写业务功能代码！');
		return false;
	}
	if($.trim($('#transId').val())==''){
		alert('请填写交易代码！');
		return false;
	}
	
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var param='?hostId='+$('#hostId').val();
	    param=param+'&createDateStart='+$('#createDateStart').val();
	    param=param+'&createDateEnd='+$('#createDateEnd').val();
	    param=param+'&chartType='+$("input[name='chartType']:checked").eq(0).val();
	    param=param+'&busiId='+$('#busiId').val();
	    param=param+'&transId='+$('#transId').val();
	    param=param+'&proId=<%=proId%>';
	    param=param+'&opCode=<%=opCode%>';
	    param=param+'&provinceCode='+provinceCode;
	    param=param+'&tellType='+tellType;
	    
	openDivWin("<%=request.getContextPath()%>/businessReportChart.do"+param,"趋势图","800","450");
	doSrchSubmit();
}

function doReport(){
	
	if(!checksubmit(srchFrm)){
		return false;
	}
	
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	$('#provinceName').val($('#provinceTell :selected').text());
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var qryPara='?proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/businessReportExport.do"+qryPara;
    document.forms['srchFrm'].target='rptExport';
    document.forms['srchFrm'].submit();
    unLoading('ajaxLoadingDiv');
    
    doSrchSubmit();
}

function choiceHostInfo(){
	var arr = document.getElementById('provinceTell').value.split('_');
	var provinceCode=arr[0];
	var tellType=arr[1];
	var qryPara="proId=<%=proId%>&opCode=<%=opCode%>&provinceCode="+provinceCode+'&tellType='+tellType;
	openDivWin("<%=request.getContextPath()%>/gotoQryHostInfo.do?"+qryPara,"查询主机信息","700","300");
}
function setHost(hostId,hostInfo){
	$("#hostName").val(hostInfo);
	$("#hostId").val(hostId);
}

function clearHost(){
	$("#hostName").val('');
	$("#hostId").val('');
	$('#provinceName').val('');
}
</script>
</html>