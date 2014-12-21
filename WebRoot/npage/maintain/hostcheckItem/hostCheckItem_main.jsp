<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>日常巡检项目配置</title>
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
					    <th>日检项名称</th>
						<td><input type="text" name="fatherSection" id="fatherSection"/></td>			
						<th>KPI编码：</th>
						<td>
						   <input type="text" name="kpiId" id="kpiId"/>（请模糊匹配输入）	
						</td>						
					</tr>
					 
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="javascript:document.forms('srchFrm').reset();"/>&nbsp;&nbsp;
							<input id="add"  type="button"  class="b_foot"   value="新增" onclick="addM()"/>&nbsp;&nbsp;
							<input id="advM" type="button" class="b_foot"  value="消息通知" onclick="addMess()"/>
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
<!-- 自动补全引入js -->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/myactb.js"></script>

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

}
/***********显示隐藏功能权限对应按钮 end***************/

//查询表单提交
function doSrchSubmit(){
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/maintain/hostcheckItem/hostCheckItem_list.jsp"+param;
    document.forms['srchFrm'].submit();
}

//增加检查项，打开弹出窗口
function addM(){
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var qryPara='?proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;
	openDivWin("<%=request.getContextPath()%>/gotoAddHostCheckItem.do"+qryPara,"新增日检项目","800","300");
	refreshByClose();
}

//增加消息通知配置项，打开弹出窗口
function addMess(){
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var qryPara='?proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;
	openDivWin("<%=request.getContextPath()%>/gotoAddMessageNotification.do"+qryPara,"消息通知配置","800","400");
	refreshByClose();
}

//list页面弹出窗口的关闭事件执行
function refreshByClose(){
    $(".window .close:last").click(function(){
		try{
		    doSrchSubmit();
	    }catch(e){}
	});
}


/***********kpi 编码自动补全 begin***************/
var kpiAry=new Array();

<c:forEach var="item" items="${kpiList}">
   kpiAry.push("${item.kpiId}");		
</c:forEach>

var searchArr=[];
for(var i=0;kpiAry&&i<kpiAry.length;i++){
	searchArr.push(kpiAry[i]);
}

var obj = new actb(document.getElementById('kpiId'),searchArr,handerKpi);
//obj.actb_startcheck=2; //用户输入2个字符才开始提示(根据输入模糊查询并显示产品)
//obj.actb_fSize = '14px';
function handerKpi(text){
	var foundKpi=null;
	for(var i=0;kpiAry && i<kpiAry.length;i++){
		if(kpiAry[i] && text==kpiAry[i]){
			foundKpi=kpiAry[i];
				break;
		}
	}
	
	if(foundKpi){
		document.getElementById('kpiId').value = foundKpi;	
	}else{
		document.getElementById('kpiId').value = "";
	}
}
/***********kpi 编码自动补全 end***************/

</script>
</html>