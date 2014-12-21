<%@ page language="java" import="java.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.util.*" %>
<html>
<head>
<title>新增功能注册信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="PoperegForm">
			<div class="input">
				<table>
					<tr>
						<th><font color="red">*功能链接</font></th>
						<td>
							<input id="actionName" name="actionName" type="text" class="required isCharLengthOf" v_maxlength="256" v_minlength="0"/>
						</td>
						<th><font color="red">*所属功能</font></th>
						<td>
							<input id="functionCode" name="functionCode" type="hidden" class="required"/>
							<input id="functionLabel" name="functionLabel" type="text" class="required" /> 请模糊匹配输入
						</td>
					</tr>
					<tr>
					    <th><font color="red">*对应操作项</font></th>
						<td>
							<select name="operationCode" id="operationCode">
								<option value=""><%=Constants.OPER_NULL_NAME %></option>
							</select>
						</td>
						<th></th>
						<td></td>
					</tr>
					
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" id="su" onclick="addPoperegSubmit()" class="b_foot" value="确定" />
				<input type="reset" name="re" id="re" onclick="document.forms('PoperegForm').reset();" class="b_foot" value="重置" />
				<input type="button" name="close" id="close" onclick="parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
			</div>
			<div align="center">
			    <font color="red"><span id="operInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>

<!-- 自动补全引入js -->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/myactb.js"></script>

<script>
$(document).ready(function () {

    //关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSrchSubmit();
	    }catch(e){}
	});
	//--end
	
});

//提交
function addPoperegSubmit(){
    if(!checksubmit(PoperegForm)){
		return false;
	}
	if(checkMatch==false){
		$('#operInfo').html('请通过模糊匹配输入方式填写所属功能！');
		return false;
	}else if($('#functionCode').val()!=$('#functionLabel').val().substring($('#functionLabel').val().indexOf(' ')+1)){
		$('#operInfo').html('请通过模糊匹配输入方式填写所属功能！');
		return false;
	}
	
	var packet = new AJAXPacket("<%=request.getContextPath()%>/addPopereg.do");
	packet.data.add("functionCode" ,$('#functionCode').val());
	packet.data.add("actionName" ,$.trim($('#actionName').val()));
	packet.data.add("operationCode" ,$('#operationCode').val());
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("functionLabel" ,$('#functionLabel').val());
	core.ajax.sendPacketHtml(packet,doAddBack);
	packet =null;
}
function doAddBack(data){
	if(data=='0'){
	    $('#operInfo').html('新增成功！');
	}else if(data=='1'){
	    $('#operInfo').html('新增异常，请正确填写相关信息！');
	}else if(data=='repeat'){
	    $('#operInfo').html('新增异常：该功能链接已存在！');
	}else if(data=='noright'){
	    $('#operInfo').html('您没有权限进行此操作！');
	}
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
//获取功能项下拉列表
function getFuncOpers(functionCode){
    var packet = new AJAXPacket("<%=request.getContextPath()%>/getFuncOpers.do");
	packet.data.add("functionCode" ,functionCode);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	core.ajax.sendPacketHtml(packet,doGetBack);
	packet =null;
}
function doGetBack(data){
	if(data=='noright'){
	    $('#operInfo').html('您没有权限进行此操作！');
	}else{
		$('#operationCode').html(decodeURI(data));
	}
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
		document.getElementById('functionCode').value = foundFunction.functionCode;
		getFuncOpers(foundFunction.functionCode);
	}else{
		document.getElementById('functionLabel').value = "";
	}
	
}
/***********功能自动补全 end***************/
</script>
</body>
</html>