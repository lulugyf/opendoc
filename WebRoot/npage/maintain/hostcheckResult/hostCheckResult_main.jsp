<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,java.text.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>日检结果展现</title>
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
						<th>省份运营商：</th>
						<td>
							<select name="provinceTell" id="provinceTell" onchange="provinceTellChange()">
							<c:if test="${provinceTellcorpList!=null}"> 
							<c:forEach items="${provinceTellcorpList}" var="item">
								<option value="${item.provinceCode}_${item.tellcorpCode}" >${item.provinceName}${item.tellcorpName}</option>
							</c:forEach>
							</c:if>
							</select>
							<input type="hidden" name="provinceTellName" id="provinceTellName"/>
						</td>
					    <th>日检分类：</th>
						<td>
						    <select name="proCode" id="proCode">
								<option value="" ></option>
								<option value="主机" >主机</option>
								<option value="进程" >进程</option>
								<option value="接口表" >接口表</option>
								<option value="文件" >文件</option>
								<option value="网络" >网络</option>
								<option value="其他" >其他</option>
								<!-- 
								<c:if test="${productList!=null}"> 
								<c:forEach items="${productList}" var="item">	
									<option value="${item.proCode}" >${item.proName} ${item.proVersion}</option>
								</c:forEach>
								</c:if>
								-->
							</select>
							<input type="hidden" name="proName" id="proName"/>
						</td>
					</tr> 
					<tr>
						<th>*开始时间：</th>
						<td><input id="checkTimeStart" name="checkTimeStart" type="text" class="required"
									onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,maxDate:'#F{$dp.$D(\'checkTimeEnd\')}'})"/></td>
						<th>*结束时间：</th>
						<td><input id="checkTimeEnd" name="checkTimeEnd" type="text" class="required"
									onfocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,minDate:'#F{$dp.$D(\'checkTimeStart\')}'})"/></td>
					</tr>
					<tr>
						<th>检查结果：</th>
						<td>
							<select name="checkStatus" id="checkStatus" >
							    <option value=""></option>
								<option value="0">正常</option>
								<option value="1">异常</option>						
							</select>	
						</td>
					    <th></th>
						<td></td>
					</tr> 
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="javascript:document.forms('srchFrm').reset();"/>&nbsp;&nbsp;
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

<script language="javascript" type="text/javascript">
/***********显示隐藏功能权限对应按钮 begin***************/
$(document).ready(function () {
    getOpersForPage(); 
    provinceTellChange();
});

function getOpersForPage(){
	var opersForPage = '${opersForPage}';
    if(opersForPage!='' && opersForPage!='NULL'){
        
        var attr = opersForPage.split(',');
        for(var i=0; i<attr.length-1; i++){
        	var protell=attr[i].split(':')[0];
        	var opers = attr[i].split(':')[1];
        	$("#provinceTell option[value='"+protell+"']").attr("opers",opers);
        }
    }
}
var param='?';
function provinceTellChange(){
	var opersForPage = $("#provinceTell").find("option:selected").attr("opers");	
	if(opersForPage.indexOf('1')>-1){
		$('#add').css('display','');
	}else{
		$('#add').css('display','none');
	}
	param='?';
	if(opersForPage.indexOf('2')>-1){
		param=param+'edit=Y&';
	}else{
		param=param+'edit=N&';
	}
	
	if(opersForPage.indexOf('3')>-1){
		param=param+'del=Y&';
	}else{
		param=param+'del=N&';
	}
  document.getElementById('provinceTellName').value=document.srchFrm.provinceTell.options[document.srchFrm.provinceTell.selectedIndex].text;
}
/***********显示隐藏功能权限对应按钮 end***************/
//查询表单提交
function doSrchSubmit(){
	if(!checksubmit(srchFrm)){
		return false;
	}
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/maintain/hostcheckResult/hostCheckResult_list.jsp" + param;
    document.forms['srchFrm'].target='ifm';
    document.forms['srchFrm'].submit();
}
//导出页面数据
function doReport(){
	if(!checksubmit(srchFrm)){
		return false;
	}
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);

	var qryPara='?proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;	
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/hostCheckResultExport.do"+ qryPara;
    document.forms['srchFrm'].target='rptExport';
    document.forms['srchFrm'].submit();
    unLoading('ajaxLoadingDiv');
    doSrchSubmit();
}

//list页面弹出窗口的关闭事件执行
function refreshByClose(){
    $(".window .close:last").click(function(){
		try{
		    doSrchSubmit();
	    }catch(e){}
	});
}

</script>
</html>