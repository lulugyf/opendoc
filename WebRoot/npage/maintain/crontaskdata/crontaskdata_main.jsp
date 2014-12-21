<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>定时任务执行结果展示</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" target="ifm" method=post>
		<%@ include file="/npage/include/header.jsp"%>
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">		
	    <div id="operation_table">			
			<div class="input">	
				<table>
					<tr>
						<th>*省份运营商：</th>
						<td>
							<select name="provinceTell" id="provinceTell">
							<c:if test="${provinceTellcorpList!=null}"> 
							<c:forEach items="${provinceTellcorpList}" var="item">
								<option value="${item.provinceCode}_${item.tellcorpCode}" >${item.provinceName}${item.tellcorpName}</option>
							</c:forEach>
							</c:if>
							</select>
						</td>
						<th>*监控项：</th>
						<td><input id="taskId" name="taskId" type="hidden" readonly="true"/>
							<input id="itemName" name="itemName" type="text" readonly="true" class="required"/>
							<input type="button" class="b_text" name="choiceButton" onClick="openSet()" value="选择" />
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
						<th>趋势图类型：</th>
						<td colspan="3">
							<input type="radio" name="chartType" value="month" checked="true"/>按月
							<input type="radio" name="chartType" value="day"/>按天
							<input type="radio" name="chartType" value="hour"/>按小时
							<input type="radio" name="chartType" value="second"/>按分
							<input type="button" class="b_foot" value="趋势图" onclick="doShowChart()"/>
						</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="document.forms('srchFrm').reset();"/>
					  </td>
					</tr>
				</table>
			</div>
			
			<iframe name="ifm" src="" style="width:100%;height:400px;" frameborder="0"></iframe>
			 
			 	
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
	
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/maintain/crontaskdata/crontaskdata_list.jsp";
    document.forms['srchFrm'].submit();
    
    setIntervalFresh();
}
//趋势图
function doShowChart(){	
	if(!checksubmit(srchFrm)){
		return false;
	}	
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var param='?taskId='+$('#taskId').val();
	    param=param+'&createDateStart='+$('#createDateStart').val();
	    param=param+'&createDateEnd='+$('#createDateEnd').val();
	    param=param+'&chartType='+$("input[name='chartType']:checked").eq(0).val();
	    param=param+'&proId=<%=proId%>';
	    param=param+'&opCode=<%=opCode%>';
	    param=param+'&provinceCode='+provinceCode;
	    param=param+'&tellType='+tellType;
	    
	openDivWin("<%=request.getContextPath()%>/cronTaskDataChart.do"+param,"趋势图","800","450");
}
//选择监控项
function openSet(){
	if(!validateElement($('#provinceTell').get(0)) ){
		return false;
	}
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var param='?provinceTell='+document.getElementById('provinceTell').value;
	    param=param+'&funcCode=<%=request.getParameter("dataFuncCode")%>';
	    param=param+'&proId=<%=proId%>';
	    param=param+'&opCode=<%=opCode%>';
	    param=param+'&provinceCode='+provinceCode;
	    param=param+'&tellType='+tellType;
	    
	openDivWin("<%=request.getContextPath()%>/gotoItemSet.do"+param,"设置数据项","800","300");
}

//返回taskId
function setTaskId(taskLabel){
	if(taskLabel.indexOf(',')>-1){
		$('#taskId').val(taskLabel.substring(0,taskLabel.indexOf(',')));
		$('#itemName').val(taskLabel.substring(taskLabel.indexOf(',')+1,taskLabel.lastIndexOf(',')));
		
		timeout=taskLabel.substring(taskLabel.lastIndexOf(',')+1);
	}
}

var intervalProcess;
var timeout;
function setIntervalFresh(){
	clearInterval(intervalProcess);//清除上次设置
	
	var patrn = /^[0-9]*[1-9][0-9]*$/; //判断是否正整数
    if (timeout.search(patrn) != -1) {
        intervalProcess = setInterval("doSrchSubmit()", eval(timeout*1000));
    }
    
}

</script>
</html>