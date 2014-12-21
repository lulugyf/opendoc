<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>功能权限注册</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" target="ifm" method=post>
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<%@ include file="/npage/include/header.jsp"%>
	
				<table class="myoptable">
					<tr>
						<th>功能链接</th>
						<td><input id="actionName" name="actionName" type="text" /></td>
						<th>所属功能</th>
						<td>
							<input id="functionCode" name="functionCode" type="hidden" />
							<input id="functionLabel" name="functionLabel" type="text" />（请模糊匹配输入）
						</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="document.forms('srchFrm').reset();"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" id="add" style="display:none" value="新增" onclick="addM()"/>
					  </td>
					</tr>
				</table>
			
			
			<iframe name="ifm" src="" style="width:100%;height:400px;" frameborder="0"></iframe>
			 
			 	
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>						
</body>
<!-- 自动补全引入js -->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/myactb.js"></script>

<script language="javascript" type="text/javascript">

//查询表单提交
function doSrchSubmit(){
	
	if(checkMatch($('#functionLabel').val())==false){
	    $('#functionCode').val($('#functionLabel').val());
	}else{
	    $('#functionCode').val($('#functionLabel').val().substring($('#functionLabel').val().indexOf(' ')+1))
	}
	
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/poperegList.do"+param;
    document.forms['srchFrm'].submit();
}

//检查手工输入的功能节点是否正确
function checkMatch(text){
    var flag=false;
    for(var i=0;functions&&i<functions.length;i++){
		if(functions[i] && text==functions[i].label){
			flag=true;
			break;
		}
	}
	return flag;
}

//增加关联模块，打开弹出窗口
function addM(){
	openDivWin("<%=request.getContextPath()%>/gotoAddPopereg.do?proId=<%=proId%>&opCode=<%=opCode%>","新增功能注册信息","800","300");
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


/***********功能自动补全 begin***************/
function Function(sName,sNo){	  
	this.functionName = sName;		
	this.functionCode=sNo;
	this.label=this.functionName+" "+this.functionCode;
}

var functions=new Array();

<c:forEach var="item" items="${functionList}">
	functions.push(
	new Function("<c:out value="${item.functionName}"/>","<c:out value="${item.functionCode}"/>"));		
</c:forEach>

var searchArr=[];
for(var i=0;functions&&i<functions.length;i++){
	searchArr.push(functions[i].label);
}

var obj = new actb(document.getElementById('functionLabel'),searchArr,handerFunction);
//obj.actb_startcheck=2; //用户输入2个字符才开始提示(根据输入模糊查询并显示产品)
//obj.actb_fSize = '14px';
function handerFunction(text){
	var foundFunction=null;
	for(var i=0;functions&&i<functions.length;i++){
		if(functions[i] && text==functions[i].label){
			foundFunction=functions[i];
				break;
		}
	}

	if(foundFunction){
		document.getElementById('functionLabel').value = foundFunction.label;
	}else{
		document.getElementById('functionLabel').value = "";
	}
	
}
/***********功能自动补全 end***************/

/***********显示隐藏功能权限对应按钮 begin***************/
$(document).ready(function () {
    getOpersForPage(); 
});

var param='?';
function getOpersForPage(){
	var opersForPage = '${opersForPage}';
    if(opersForPage!='' && opersForPage!='NULL'){
    	var opers = opersForPage.split(':')[1].split(';');
        for(var i=0; i<opers.length; i++){
            if(opers[i]=='1'){
                $('#add').css('display','');
            }else if(opers[i]=='2'){
                param=param+'edit=Y&';
            }else if(opers[i]=='3'){
                param=param+'del=Y&';
            }
        }
    }
}
/***********显示隐藏功能权限对应按钮 end***************/

</script>
</html>