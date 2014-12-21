<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>端口监控</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div id="operation">
		<form name="netCellFrom" target="ifm" method=post>
			<input type=hidden name="proId" id="proId" value="<%=proId%>" />
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>" />

			<%@ include file="/npage/include/header.jsp"%>
			<div id="operation_table">
				<div class="input">
					<table>
						<tr style="display:none">
							<th>省份运营商：</th>
							<td colspan="3">
								<select name="provinceTell" id="provinceTell" onchange="provinceTellChange()">								
								<c:if test="${provinceTellcorpList!=null}"> 
								<c:forEach items="${provinceTellcorpList}" var="item">
									<option value="${item.provinceCode}_${item.tellcorpCode}" >${item.provinceName}${item.tellcorpName}</option>
								</c:forEach>
								</c:if>
								</select>
							</td>
						</tr>
						<tr>
							<th >刷新频率:</th>
							<td colspan="3">
								<select id="refresTime" onchange="refreshTime()">
									<option value="5">5秒</option>
									<option value="10">10秒</option>
									<option value="15">15秒</option>
								</select>
								<input type="checkbox" title="暂停刷新" name="isRefresh" id="isRefresh" />暂停刷新 
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
    
    doSrchSubmit();    
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
	
	var attr = $("#provinceTell").val().split('_');
	param = param + 'provinceCode=' + attr[0] + '&tellType=' +  attr[1];
	
 
}
/***********显示隐藏功能权限对应按钮 end***************/

function refreshTime(){
	//更改时间时,立即刷新;不能直接调用doSrchSubmit,那样会引起设置多个定时器的问题
	document.forms['netCellFrom'].action="<%=request.getContextPath()%>/npage/maintain/portcheck/portcheck_list.jsp"+param;
    document.forms['netCellFrom'].submit();
}

//查询表单提交
function doSrchSubmit(){

	if( !document.getElementById("isRefresh").checked ){
	    document.forms['netCellFrom'].action="<%=request.getContextPath()%>/npage/maintain/portcheck/portcheck_list.jsp"+param;
	    document.forms['netCellFrom'].submit();
	}

    
    //这样调用定时刷新,可以避免把提交本身耗费的时间也计算在内
    setTimeout("doSrchSubmit()", document.getElementById("refresTime").value * 1000);
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


</script>
</html>