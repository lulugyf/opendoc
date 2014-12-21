<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>业务明细查询</title>
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
						<th style="width:130px">*省份运营商：</th>
						<td>
							<select name="provinceTell" id="provinceTell" onchange="clearHost()">
							<c:if test="${provinceTellcorpList!=null}"> 
							<c:forEach items="${provinceTellcorpList}" var="item">
								<option value="${item.provinceCode}_${item.tellcorpCode}" >${item.provinceName}${item.tellcorpName}</option>
							</c:forEach>
							</c:if>
							</select>
						</td>
						<th style="width:130px">*主机：</th>
						<td>
							<input type="text" name="hostName" id="hostName" class="required" readonly="readonly" />
							<input type=hidden name="hostId" id="hostId" >
							<input type="button" name="choiceButton" onClick="choiceHostInfo();" class="b_foot" value="选择主机" />
						</td>
					</tr>
					<tr>
						<th>业务流水号：</th>
						<td><input id="procId" name="procId" type="text" class=""/></td>
						<th>发起方交易流水号：</th>
						<td><input id="transIdo" name="transIdo" type="text" class=""/></td>
					</tr>
					<tr>
						<th>归属方交易流水号：</th>
						<td><input id="transIdh" name="transIdh" type="text" class=""/></td>
						<th>一级Boss交易流水号：</th>
						<td><input id="transIdc" name="transIdc" type="text" class=""/></td>
					</tr>
					<tr>
						<th>*交易处理时间：</th>
						<td><input id="transTime" name="transTime" type="text" class="required"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true})"/></td>
						<th></th>
						<td></td>
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
	
	var busiId='<%=request.getParameter("busiID")%>';
	var funcCode='<%=request.getParameter("dataFuncCode")%>';
	var hostId=$('#hostId').val();
	
	var procId=$('#procId').val();
	var transIdo=$('#transIdo').val();
	var transIdh=$('#transIdh').val();
	var transIdc=$('#transIdc').val();
	var transTime=$('#transTime').val();
	
	var qryPara='busiId='+busiId+'&funcCode='+funcCode+'&hostId='+hostId+'&procId='+procId+'&transIdo='+transIdo+'&transIdh='+transIdh+'&transIdc='+transIdc+'&transTime='+transTime+'&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;
	var url="<%=request.getContextPath()%>/businessDetailList.do?"+qryPara;
    $('#ifm').attr('src',url);
    
	loading();
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