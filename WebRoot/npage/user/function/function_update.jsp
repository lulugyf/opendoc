<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.rom.util.Constants" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<title>系统功能管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="updateFrm" target="ifm" method=post>
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
	    <div id="operation_table">			
			<div class="input">	
				<table>
					<tr>
						<th><font color="red">*功能代码</font></th>
						<td>
							<input type="hidden" name="functionCode" id="functionCode" value="${functionBo.functionCode}"/>
						    ${functionBo.functionCode}
						</td>
						<th><font color="red">*功能名称</font></th>
						<td>
							<input type="text" name="functionName" id="functionName" value="${functionBo.functionName}" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
					</tr>
					<tr>
						<th><font color="red">*父功能</font></th>
						<td colspan="3">
							<%=Constants.TREE_PARENT_NAME%><input type="checkbox" name="checkParent" id="checkParent" onclick="checkParentFunc(this)" checked="true"/>
							&nbsp;&nbsp;
							<input type="text" name="parentCode" id="parentCode" style="color:#999;display:none" value="模糊匹配输入" onclick="clickParentCode()" onblur="blurParentCode()" style="color:#999" class="required" v_maxlength="8" v_minlength="0"/>
						</td>
					</tr>
					<tr valign="top">
						<th><font color="red">*节点类型</font></th>
						<td>
							<select name="nodeType" id="nodeType">
								<option value="0" selected="true" >可见</option>
								<option value="1">不可见</option>
							</select>
						</td>
						<th>操作项</th>
						<td>
						 <c:if test="${operaArr!=null}">
							    <c:forTokens items="${operaArr}" delims=";" var="tech">
									${fn:split(tech, "_")[1]}<input type="checkbox" name="chkoper" id="chkoper" value="${fn:split(tech, "_")[0]}" /><br/>
								</c:forTokens>
							</c:if>
						</td>
					</tr>
					<tr>
					    <th>显示顺序</th>
						<td>
							<input type="text" name="noteSeq" id="noteSeq" value="${functionBo.noteSeq}" class="nonNegInt"/>
						</td>
                        <th>打开方式：</th> 
                        <td>
                        	<select id="openType" name="openType"  class="required" > 
								<option value="1">一级TAB</option>
								<option value="2">二级TAB</option>
								<option value="3">动态</option>
								<option value="4">集成页面</option>
								<option value="9">弹出</option>
							</select>
                    	</td>
					</tr>
					<tr>
					    <th>功能链接</th>
						<td colspan="3">
							<input type="text" style="width:60%" name="actionName" id="actionName" value="${functionBo.actionName}" class="isCharLengthOf urlForInput" v_maxlength="256" v_minlength="0"/>
						</td>
					</tr>
					
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="确定" onclick="doUpdateSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="javascript:parent.setValue('${functionBo.functionCode}')"/>
					  </td>
					</tr>
				</table>
				<div align="center">
				    <font color="red"><span id="operInfo">${operInfo}</span></font>
				</div>
			</div>
				
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>				
</body>
<!-- 自动补全引入js -->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/myactb.js"></script>

<script>
$(document).ready(function () {
	if('${functionBo.parentCode}'!='<%=Constants.TREE_PARENT%>'){
	    $('#checkParent').attr('checked',false);
	    checkParentFunc($('#checkParent').get(0));
	    clickParentCode();
	    $('#parentCode').val('${functionBo.parentName} ${functionBo.parentCode}');
	}
	$('#nodeType').val('${functionBo.nodeType}');
	if('${functionBo.operationName}'!=''){
	    var operArr='${functionBo.operationName}'.split(';');
	    for(var i=0; i<operArr.length; i++){
	        if(operArr[i].indexOf('_')>-1){
	            $("input[name='chkoper'][value='"+operArr[i].substring(0,operArr[i].indexOf('_'))+"']").eq(0).attr('checked',true);
	        }
	    }
	}
	
	//去掉校验特殊字符
	var c=$('#actionName').attr('class');
	c=c.substring(0,c.lastIndexOf(' '));
	$('#actionName').attr('class',c);
	
	
	//初始化信息	
	for(var i=0;i<g("openType").length;i++){//打开方式
		if(g("openType")[i].value == "${functionBo.openType}"){
			g("openType")[i].selected = true;
			break;
		}
	}
	
	
});

function doUpdateSubmit(){
	clickParentCode();
	
	if(!checksubmit(updateFrm)){
		return false;
	}
	
	var parentCode;
	
	if($('#checkParent').attr("checked")==true){
	    parentCode='<%=Constants.TREE_PARENT%>';
	}else{
		
		if(checkMatch($('#parentCode').val())==false){
		    $('#operInfo').html('请正确输入父功能信息！');
			return;
		}
		
	    var matchValue=$('#parentCode').val();
		parentCode=matchValue.substring(matchValue.indexOf(' ')+1);
	}
	
	var chkoper='';
	
	$("input[name='chkoper']").each(function(){
		if($(this).attr("checked")==true){
        	chkoper=chkoper+$(this).val()+';';
        }
    });
	
    var packet = new AJAXPacket("<%=request.getContextPath()%>/functionUpdate.do");
	packet.data.add("functionCode" ,$('#functionCode').val());
	packet.data.add("functionName" ,$('#functionName').val());
	packet.data.add("parentCode" ,parentCode);
	packet.data.add("nodeType" ,$('#nodeType').val());
	packet.data.add("operationCode" ,chkoper);
	packet.data.add("noteSeq" ,$('#noteSeq').val());
	packet.data.add("openType" ,$('#openType').val());
	packet.data.add("actionName" ,$('#actionName').val());
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	core.ajax.sendPacketHtml(packet,doUpdateBack);
	packet =null;
}
function doUpdateBack(data){
	if(data=='0'){
	    $('#operInfo').html('功能修改成功！');
	    parent.getFunctionTree(); //刷新功能树
	}else if(data=='1'){
	    $('#operInfo').html('功能修改异常，请正确填写相关信息！');
	}else if(data=='noright'){
	    $('#operInfo').html('您没有权限进行此操作！');
	}
}

//检查手工输入的父节点是否正确
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

//是否根节点
function checkParentFunc(obj){
	if(obj.checked==false){
		$('#parentCode').css('display','');
	}else{
		$('#parentCode').css('display','none');
	}
}

function clickParentCode(){
    if($('#parentCode').val()=='模糊匹配输入'){
        $('#parentCode').val('');
        $('#parentCode').css('color','#000');
    }
}
function blurParentCode(){
    if($('#parentCode').val()==''){
        $('#parentCode').val('模糊匹配输入');
        $('#parentCode').css('color','#999');
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

var obj = new actb(document.getElementById('parentCode'),searchArr,handerFunction);
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
		document.getElementById('parentCode').value = foundFunction.label;
	}else{
		document.getElementById('parentCode').value = "";
	}
	
}
/***********功能自动补全 end***************/
/////////////////////////////////////////////////
function g(o){
	return document.getElementById(o);
}
</script>
</html>