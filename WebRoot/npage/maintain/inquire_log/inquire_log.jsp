<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>日志查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div id="operation">
		<form name="inquireLogForm" target="ifm" method=post>
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
							<th>网元名称：</th>
							<td>
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
							<td colspan="4" style="text-align:center">
								<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()" />&nbsp;&nbsp;
								<input type="button" class="b_foot" value="重置" onclick="javascript:document.forms('inquireLogForm').reset();" />&nbsp;&nbsp;
							</td>
						</tr>
					</table>
				</div>

				<iframe name="ifm" src="" style="width:100%;height:400px;"
					frameborder="0"></iframe>


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
	
	if(opersForPage.indexOf('7')>-1){//远程脚本调用配置的权限
		param=param+'scriptConf=Y&';
	}else{
		param=param+'scriptConf=N&';
	}
 
}
/***********显示隐藏功能权限对应按钮 end***************/


//查询表单提交
function doSrchSubmit(){
    document.forms['inquireLogForm'].action="<%=request.getContextPath()%>/npage/maintain/inquire_log/inquire_log_list.jsp"+param;
    document.forms['inquireLogForm'].submit();
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

//更新cellName的列表
function setCellName(){
	
}
</script>
</html>