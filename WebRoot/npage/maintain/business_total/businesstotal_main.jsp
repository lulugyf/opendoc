<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>业务汇总实时监控</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" target="ifm" method=post>
		<%@ include file="/npage/include/header.jsp"%>
	    <div id="operation_table">			
			<div class="input">
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
							<input type="button" onClick="choiceHostInfo();" class="b_foot" value="选择" />
						</td>
					</tr>
					<!-- tr>
						<th>业务功能代码：</th>
						<td><input id="busiId" name="busiId" type="text" class=""/></td>
						<th>交易代码：</th>
						<td><input id="transId" name="transId" type="text" class=""/></td>
					</tr -->
					<tr>
						<th>分组名称：</th>
						<td>
							<select name="groupId" id="groupId" onchange="clearBusiTrans()">
							<option value=""></option>
							</select>
						</td>
						<th>业务交易信息：</th>
						<td>
							<input id="busiTrans" name="busiTrans" type="text" readonly="readonly"/>
							<input type="button" onClick="choiceBusiTrans()" class="b_foot" value="选择" />
							<input type="button" onClick="clearBusiTrans()" class="b_foot" value="清除" />
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
			
			<iframe name="ifm" id="ifm" src="" style="width:100%;" frameborder="0"></iframe>
			
			<iframe name="ifmTime" id="ifmTime" src="" style="width:100%;" frameborder="0"></iframe>
			
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>						
</body>

<script language="javascript" type="text/javascript">

getDefaultHostGroup();

//查询表单提交
function doSrchSubmit(){
	
	if(!checksubmit(srchFrm)){
		return false;
	}
	getBusiParam();
	
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	
	var scriptId=$('#scriptId').val();
	var busiId=$('#busiId').val();
	var transId=$('#transId').val();
	var groupId=$('#groupId').val();
	var busiTrans=encodeURI($('#busiTrans').val());
	var hostId=$('#hostId').val();
	var dataFuncCode='<%=request.getParameter("dataFuncCode")%>';
	
	var qryPara='busiId='+busiId+'&hostId='+hostId+'&groupId='+groupId+'&busiTrans='+busiTrans+'&dataFuncCode='+dataFuncCode+'&scriptId='+scriptId+'&transId='+transId+'&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;
	var url="<%=request.getContextPath()%>/businessTotalAmount.do?"+qryPara;
    $('#ifm').attr('src',url);
    
    //交易时长
	var scriptIdTime=$('#scriptIdTime').val();
    var qryParaTime="busiId="+busiId+'&hostId='+hostId+'&groupId='+groupId+'&busiTrans='+busiTrans+'&dataFuncCode='+dataFuncCode+'&scriptId='+scriptIdTime+'&transId='+transId+'&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;
    var url="<%=request.getContextPath()%>/businessTotalTime.do?"+qryParaTime;
	$('#ifmTime').attr('src',url);
	
	loading();
}

function getBusiParam(){
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	
	var packet = new AJAXPacket("<%=request.getContextPath()%>/busiTotalQuantity.do");
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
		$('#scriptId').val(arr[0]);
		$('#scriptIdTime').val(arr[1]);
	}else{
		$('#scriptId').val('');
		$('#scriptIdTime').val('');
	}
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
	getGroupList();
}

function clearHost(){
	$("#hostName").val('');
	$("#hostId").val('');
	getGroupList();
}

//分组选择
function getGroupList(){
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	
	var packet = new AJAXPacket("<%=request.getContextPath()%>/getGroupList.do");
	packet.data.add("loginNo" ,'<%=session.getAttribute("loginNo").toString()%>');
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("proCode" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,provinceCode);
	packet.data.add("tellType" ,tellType);
	packet.data.add("hostId" ,$("#hostId").val());
	core.ajax.sendPacketHtml(packet,doGetGroupBack);
	packet =null;
}
function doGetGroupBack(data){
	$("#groupId").empty();
	$("#groupId").append('<option value=""></option>');
	if(data=='noright'){
	    parent.parent.showDialog("您没有权限进行此操作！",0);
	}else if(data!=''){
		var arr=decodeURI(data).split(',');
		for(var i=0;i<arr.length;i++){
			var sp=arr[i].split('_');
			$("#groupId").append('<option value="'+sp[0]+'">'+sp[1]+'</option>');
		}
	}
}

function choiceBusiTrans(){
	
	if($.trim($('#hostId').val())==''){
		parent.showDialog("请选择主机！",0);
		return;
	}
	
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var hostId=$('#hostId').val();
	var dataFuncCode='<%=request.getParameter("dataFuncCode")%>';
	
	var qryPara="groupId="+$('#groupId').val()+"&hostId="+hostId+"&dataFuncCode="+dataFuncCode+"&busiTrans="+encodeURI($("#busiTrans").val())+"&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode="+provinceCode+"&tellType="+tellType;
	openDivWin("<%=request.getContextPath()%>/getBusiTrans.do?"+qryPara,"业务交易信息选择","400","400");
}

function setBusiTrans(busiTrans){
	$('#busiTrans').val(busiTrans);
}

function clearBusiTrans(){
	$("#busiTrans").val('');
}

//获取默认分组
function getDefaultHostGroup(){
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	
	var packet = new AJAXPacket("<%=request.getContextPath()%>/getDefaultHostGroup.do");
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,provinceCode);
	packet.data.add("tellType" ,tellType);
	packet.data.add("loginNo" ,'<%=session.getAttribute("loginNo").toString()%>');
	packet.data.add("proCode" ,"<%=proId%>");
	core.ajax.sendPacketHtml(packet,doDefaultHostGroupBack);
	packet =null;
}
function doDefaultHostGroupBack(data){
	if(data!=''){
		var arr=decodeURI(data).split(',');
		$('#hostId').val(arr[0]);
		$('#hostName').val(arr[1]);
		getGroupList();
		$('#groupId').val(arr[2]);
	}
}

</script>
</html>