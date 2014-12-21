<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>业务进程信息监控</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div id="operation">
		<form name="proMonitorForm" target="ifm" method=post>
			<input type=hidden name="proId" id="proId" value="<%=proId%>" />
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>" />

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
							</td>
							<th><font color="red">*业务类型：</font></th>
							<td>
								<select name="busiIdentify" id="busiIdentify" onchange="onChangeBusiIdentify()" class="required">
									<option value="" ></option>
									<option value="100" >网元业务</option>
								</select>
							</td>
						</tr>
						
						<tr id="tr_100" style="display:none;">
							<th>网元名称：</th>
							<td colspan="3">
								<select name="cellName" id="cellName">
									<option value="" ></option>
									<c:if test="${cellNameList!=null}"> 
									<c:forEach items="${cellNameList}" var="item">
										<option value="${item.cellName}" >${item.cellName}</option>
									</c:forEach>
									</c:if>
								</select>
							</td>
						</tr>
						
						<tr>			
							<th>刷新频率:</th>
							<td colspan="3">
								<select id="refreshTime" onchange="refreshTime()">
									<option value="5">5秒</option>
									<option value="10">10秒</option>
									<option value="15">15秒</option>
								</select>
								<input type="checkbox" title="暂停刷新" name="isRefresh" id="isRefresh" checked="checked" />暂停刷新				
							</td>	
						</tr>
						
						<tr>
							<td colspan="4" style="text-align:center">
								<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()" />&nbsp;&nbsp;
								<input type="button" class="b_foot" value="重置" onclick="javascript:document.forms('proMonitorForm').reset();" />&nbsp;&nbsp;								
							</td>
						</tr>

					</table>
				</div>

				<iframe name="ifm" id="ifm" src="" style="width:100%;height:400px;" frameborder="0"></iframe>


			</div>
			<%@ include file="/npage/include/footer.jsp"%>
		</form>
	</div>
</body>
<script language="javascript" type="text/javascript">
/***********显示隐藏功能权限对应按钮 begin***************/
$(document).ready(function () {
    getOpersForPage(); 
    provinceTellChange();
    doSrchSubmitWithRefresh();
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
	
	if(opersForPage.indexOf('5')>-1){
		param=param+'runstop=Y&';
	}else{
		param=param+'runstop=N&';
	}
	
	if(opersForPage.indexOf('7')>-1){//远程脚本调用配置的权限
		param=param+'scriptConf=Y&';
	}else{
		param=param+'scriptConf=N&';
	}
 
}
/***********显示隐藏功能权限对应按钮 end***************/
function refreshTime(){
	//更改时间时,立即刷新;不能直接调用doSrchSubmitWithRefresh,那样会引起设置多个定时器的问题
	doSrchSubmit();
}

//业务标识发生变化
function onChangeBusiIdentify(){
	var busiIdentify = g("busiIdentify").value;	
	var size = 99+g("busiIdentify").options.length;	
	
	//全部隐藏
	for( var i=100; i < size; i++ ){
		g('tr_'+i).style.display='none';
	}
		
	//显示指定的
	if(busiIdentify != ""){				
		g('tr_' + busiIdentify).style.display='';
		doSrchSubmit();
	}else{
		g("ifm").style.display='none';
	}
	
	
}
//查询--不带刷新
function doSrchSubmit(){
	if(!checksubmit(proMonitorForm)){
		return false;
	}

	var busiIdentify = g("busiIdentify").value;
	
	if(busiIdentify != ""){	
    	document.forms['proMonitorForm'].action="<%=request.getContextPath()%>/npage/maintain/promonitor/pm002/pm002_list_"+busiIdentify+".jsp" + param +"&busiIdentify=" + busiIdentify;
    	document.forms['proMonitorForm'].submit();
    	g("ifm").style.display='';
	}	
}

//查询表单提交--带刷新
function doSrchSubmitWithRefresh(){
	//这样调用定时刷新,可以避免把提交本身耗费的时间也计算在内
    setTimeout("doSrchSubmitWithRefresh()", document.getElementById("refreshTime").value * 1000);
    
	if(!checksubmit(proMonitorForm)){
		return false;
	}

	var busiIdentify = g("busiIdentify").value;
	
	if( !document.getElementById("isRefresh").checked ){
		if(busiIdentify != ""){	
	    	document.forms['proMonitorForm'].action="<%=request.getContextPath()%>/npage/maintain/promonitor/pm002/pm002_list_"+busiIdentify+".jsp" + param +"&busiIdentify=" + busiIdentify;
	    	document.forms['proMonitorForm'].submit();
	    	g("ifm").style.display='';
		}
	}
}


	
//list页面弹出窗口的关闭事件执行
function refreshByClose() {
	$(".window .close:last").click(function() {
		try {
			doSrchSubmit();
		} catch (e) {
		}
	});
}

/////////////////////////////////////////////////
function g(o){
	return document.getElementById(o);
}
</script>
</html>