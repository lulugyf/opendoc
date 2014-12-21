<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.rom.util.*" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>业务执行结果展示</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%
	Date dates = new Date();
	String date=DateFormat.shortDate(dates);
%>
<body>
<div id="operation">
	<form name="srchFrm" target="ifm" method=post>
		<%@ include file="/npage/include/header.jsp"%>
	    <div id="operation_table">			
			<div class="input">	
	            <input id="taskId" name="taskId" type="hidden" />
				<input id="intervalTime" name="intervalTime" type="hidden" />
	            <input id="scriptId" name="scriptId" type="hidden" />
	            <input id="scriptIdTime" name="scriptIdTime" type="hidden" />
	            
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
						<td><input id="createDateStart" name="createDateStart" type="text" class="required" value="<%=date %> 00:00:00" 
									onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,maxDate:'#F{$dp.$D(\'createDateEnd\')}'})"/></td>
						<th>*结束时间：</th>
						<td><input id="createDateEnd" name="createDateEnd" type="text" class="required" value="<%=date %> 23:59:59" 
									onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,minDate:'#F{$dp.$D(\'createDateStart\')}'})"/></td>
					</tr>
					<tr>
						<th>趋势图类型：</th>
						<td>
							<input type="radio" name="chartType" value="month"/>按月
							<input type="radio" name="chartType" value="day"/>按天
							<input type="radio" name="chartType" value="hour"/>按小时
							<input type="radio" name="chartType" value="second" checked="true"/>按分
							<input type="button" class="b_foot" value="趋势图" onclick="doShowChart()"/>
						</td>
						<th>交易代码：</th>
						<td><input id="transId" name="transId" type="text" /></td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="document.forms('srchFrm').reset();"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="停止监控" onclick="doStop()"/>
					  </td>
					</tr>
				</table>
					
			</div>
			
			<iframe name="ifm" id="ifm" src="" style="width:100%;" frameborder="0"></iframe>
			
			<iframe name="ifmTime" id="ifmTime" src="" style="width:100%;" frameborder="0"></iframe>
  
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
	getBusiParam();
	
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var busiId='<%=request.getParameter("busiID")%>';
	var qryPara='busiId='+busiId+'&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/maintain/business_data/businessdata_list.jsp?"+qryPara;
    document.forms['srchFrm'].submit();
    
    //交易时长
	var scriptId=$('#scriptIdTime').val();
	var transId=$('#transId').val();
	var createDateStart=$('#createDateStart').val();
	var createDateEnd=$('#createDateEnd').val();
    var qryParaTime="busiId="+busiId+'&scriptId='+scriptId+'&transId='+transId+'&createDateStart='+createDateStart+'&createDateEnd='+createDateEnd+'&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;
    var url="<%=request.getContextPath()%>/businessTime.do?"+qryParaTime;
	$('#ifmTime').attr('src',url);
    
    setIntervalFresh();
}

function getBusiParam(){
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	
	var packet = new AJAXPacket("<%=request.getContextPath()%>/businessQuantity.do");
	packet.data.add("funcCode" ,'<%=request.getParameter("dataFuncCode")%>');
	packet.data.add("busiId" ,'<%=request.getParameter("busiID")%>');
	packet.data.add("hostId" ,$('#hostId').val());
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,provinceCode);
	packet.data.add("tellType" ,tellType);
	core.ajax.sendPacketHtml(packet,doBusiParamBack);
	packet =null;
}
function doBusiParamBack(data){
	if(data=='noright'){
	    parent.parent.showDialog("您没有权限进行此操作！",0);
	}else if(data!=''){
		var arr=data.split(',');
		$('#taskId').val(arr[0]);
		$('#intervalTime').val(arr[1]);
		$('#scriptId').val(arr[2]);
		$('#scriptIdTime').val(arr[3]);
	}else{
		$('#taskId').val('');
		$('#intervalTime').val('');
		$('#scriptId').val('');
		$('#scriptIdTime').val('');
	}
}

//趋势图
function doShowChart(){	
	if(!checksubmit(srchFrm)){
		return false;
	}
	if($.trim($('#transId').val())==''){
		alert('请填写交易代码！');
		return false;
	}
	
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var param='?taskId='+$('#taskId').val();
	    param=param+'&createDateStart='+$('#createDateStart').val();
	    param=param+'&createDateEnd='+$('#createDateEnd').val();
	    param=param+'&chartType='+$("input[name='chartType']:checked").eq(0).val();
	    param=param+'&busiId=<%=request.getParameter("busiID")%>';
	    param=param+'&transId='+$('#transId').val();
	    param=param+'&proId=<%=proId%>';
	    param=param+'&opCode=<%=opCode%>';
	    param=param+'&provinceCode='+provinceCode;
	    param=param+'&tellType='+tellType;
	    
	openDivWin("<%=request.getContextPath()%>/businessDataChart.do"+param,"趋势图","800","450");
}

var intervalProcess;
function setIntervalFresh(){

	clearInterval(intervalProcess);//清除上次设置
	var timeout=$('#intervalTime').val();
	var patrn = /^[0-9]*[1-9][0-9]*$/; //判断是否正整数
    if (timeout.search(patrn) != -1) {
        intervalProcess = setInterval("doSrchSubmit()", eval(timeout*1000));
    }
}

function doStop(){
	clearInterval(intervalProcess);
}

//iframe自适应
function reinitIframe(){
	var iframe = document.getElementById("ifm");
	try{
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = bHeight;
		iframe.height =  height+20;
	}catch (ex){}
}

function reinitIframeTime(){
	var iframe1 = document.getElementById("ifmTime");
	try{
		bHeight = iframe1.contentWindow.document.body.scrollHeight;
		//dHeight = iframe1.contentWindow.document.documentElement.scrollHeight;
		height = bHeight;//Math.max(bHeight, dHeight)
		iframe1.height =  height+20;
	}catch (ex){}
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
}
</script>
</html>