<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>

<html>
<head>
<title>新增节点配置信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="dataFuncCode" id="dataFuncCode" value="<%=request.getParameter("dataFuncCode")%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
			<div class="input">
				<table>
 					<tr>
 						<th><font color="red">*主机：</font></th>
						<td>
							<input type="text" name="hostName" id="hostName" class="" readonly="readonly" />
							<input type=hidden name="hostId" id="hostId" >
							<input type="button" name="choiceButton" onClick="choiceHostInfo();" class="b_foot" value="选择主机" />
						</td>
 					
 					</tr>
					<tr>
						<th><font color="red">*总线名称：</font></th>
						<td>
							<input type="text" name="itemName" id="itemName" class="required isCharLengthOf" v_maxlength="32" v_minlength="0"/>
						</td>
					</tr>
					<tr>
						<th><font color="red">*总线描述：</font></th>
						<td>
 							<input type="text" name="itemDesc" id="itemDesc" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
					</tr>
					<tr>
						<th><font color="red">*是否共享：</font></th>
						<td>
							<input type="radio" name="isGrant" value="1" checked="true" onclick="showGrantMethod(this)"/>否
 							<input type="radio" name="isGrant" value="0" onclick="showGrantMethod(this)"/>是
						</td>
					</tr>
					<tr id="grantMethodTr" style="display:none">
						<th><font color="red">*共享方式：</font></th>
						<td>
							<input type="radio" name="grantMethod" value="1" checked="true" onclick="showGrantLogin(this)"/>完全共享
 							<input type="radio" name="grantMethod" value="0" onclick="showGrantLogin(this)"/>部分共享
						</td>
					</tr>
					<tr id="grantLoginTr" style="display:none">
						<th><font color="red">*选择工号：</font></th>
						<td>
							<input type=hidden name="grantLogins" id="grantLogins" />
							<input type="text" name="grantLoginNames" id="grantLoginNames" style="width:450px" readonly="readonly"/>
							<input type="button" name="choiceButton" id="choiceButton" onClick="choiceLogins();" class="b_foot" value="选择" />
							<input type="button" name="clr" id="clr" onClick="clrLogins();" class="b_foot" value="清空" />
						</td>
					</tr>
				</table>
			</div>
			
			<div id="formTab" style="margin:10px 0 0 0">
				<ul>
					<li class="current" id="title_0"><a href="#this">主总线配置</a></li>
				</ul>
			</div>
			<div id="table_0" class="input">
				<table>
 					<tr>
 						<th>端口：</th>
						<td>
							<input type="text" name="ipPort" id="ipPort" class="required for0_9 isLengthOf" v_maxlength="11" v_minlength="0"/><span class="red">*</span>
						</td>
 						<th>最大连接数：</th>
						<td>
							<input type="text" name="maxConnect" id="maxConnect" value="1024" class="required for0_9 isLengthOf" v_maxlength="11" v_minlength="0"/><span class="red">*</span>
						</td>
 					</tr>
 					<tr>
 						<th>超时时间：</th>
						<td>
							<input type="text" name="netTimeout" id="netTimeout" value="180000" class="required for0_9 isLengthOf" v_maxlength="11" v_minlength="0"/><span class="red">*单位:ms</span>
						</td>
 						<th>日志目录：</th>
						<td>
							<input type="text" name="logDir" id="logDir" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/><span class="red">*</span>
						</td>
 					</tr>
 					<tr>
 						<th>队列长度：</th>
						<td>
							<input type="text" name="queueLength" id="queueLength" value="100000" class="required for0_9 isLengthOf" v_maxlength="11" v_minlength="0"/><span class="red">*</span>
						</td>
 						<th></th>
						<td></td>
 					</tr>
				</table>
			</div>
			<div id="formTab" style="margin:10px 0 0 0">
				<ul>
					<li class="current" id="title_0"><a href="#this">备用总线配置</a></li>
					<li style="background:none;" id="title_0">&nbsp;&nbsp;<input type="checkbox" id="bakOn" name="bakOn" onclick="checkBak(this)"/>启用</li>
				</ul>
			</div>
			<div id="table_1" class="input" style="display:none;background-color:#ccc;">
				<table>
 					<tr>
 						<th style="background-color:#ccc">端口：</th>
						<td>
							<input type="text" name="ipPortBak" id="ipPortBak" class="required for0_9 isLengthOf" v_maxlength="11" v_minlength="0"/><span class="red">*</span>
						</td>
 						<th style="background-color:#ccc">最大连接数：</th>
						<td>
							<input type="text" name="maxConnectBak" id="maxConnectBak" value="1024" class="required for0_9 isLengthOf" v_maxlength="11" v_minlength="0"/><span class="red">*</span>
						</td>
 					</tr>
 					<tr>
 						<th style="background-color:#ccc">超时时间：</th>
						<td>
							<input type="text" name="netTimeoutBak" id="netTimeoutBak" value="100000" class="required for0_9 isLengthOf" v_maxlength="11" v_minlength="0"/><span class="red">*单位:ms</span>
						</td>
 						<th style="background-color:#ccc">日志目录：</th>
						<td>
							<input type="text" name="logDirBak" id="logDirBak" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/><span class="red">*</span>
						</td>
 					</tr>
 					<tr>
 						<th style="background-color:#ccc">队列长度：</th>
						<td>
							<input type="text" name="queueLengthBak" id="queueLengthBak" class="required for0_9 isLengthOf" v_maxlength="11" v_minlength="0"/><span class="red">*</span>
						</td>
 						<th style="background-color:#ccc"></th>
						<td></td>
 					</tr>
				</table>
			</div>
			
			<div id="operation_button" style="margin-top:10px">
				<input type="button" name="su" onClick="addProgInfoConfSubmit()" class="b_foot" value="确定" />
				<input type="reset" name="re" onClick="javascript:document.forms('hostForm').reset();" class="b_foot" value="重置" />
				<input type="button" name="close" onClick="parent.doSubmit_0();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
			</div>
			<div align="center">
			    <font color="red"><span id="succInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>
$(document).ready(function () {
	
	//关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSubmit_0();
	    }catch(e){}
	});
});

function addProgInfoConfSubmit(){
    if(!checksubmit(hostForm)){
		return false;
	}
	
	if($("#hostId").val()==""){
		alert("请进行主机选择！");
		return false;
	}
	document.hostForm.action='<%=request.getContextPath()%>/addBusConfig.do';
	document.hostForm.submit();
	
}

function choiceHostInfo(){
	var qryPara="proId=<%=proId%>&opCode=<%=opCode%>&provinceCode="+$('#provinceCode').val()+'&tellType='+$('#tellType').val();
	openDivWin("<%=request.getContextPath()%>/gotoQryHostInfo.do?"+qryPara,"查询主机信息","700","300");
}

function setHost(hostId,hostInfo){
	$("#hostName").val(hostInfo);
	$("#hostId").val(hostId);
}

//是否共享
function showGrantMethod(obj){
	if($(obj).val()==0){
		$('#grantMethodTr').css('display','');
		$("input[name='grantMethod']").each(function(){
	        if($(this).attr("checked")==true && $(this).val()==0){
	            $('#grantLoginTr').css('display','');
	            $('#grantLoginNames').attr('class',$('#grantLoginNames').attr('class')+' required');
	        }
	    });
	}else{
		$('#grantMethodTr').css('display','none');
		$('#grantLoginTr').css('display','none');
		
		if($('#grantLoginNames').attr('class').indexOf('required')>-1){
			$('#grantLoginNames').attr('class',$('#grantLoginNames').attr('class').substring(0,$('#grantLoginNames').attr('class').indexOf(' ')));
		}
	}
}

//共享方式
function showGrantLogin(obj){
	if($(obj).val()==0){
		$('#grantLoginTr').css('display','');
	    $('#grantLoginNames').attr('class',$('#grantLoginNames').attr('class')+' required');
	}else{
		$('#grantLoginTr').css('display','none');
		
		if($('#grantLoginNames').attr('class').indexOf('required')>-1){
			$('#grantLoginNames').attr('class',$('#grantLoginNames').attr('class').substring(0,$('#grantLoginNames').attr('class').indexOf(' ')));
		}
	}
}

//弹出工号树
function choiceLogins(){
	var qryPara="proId=<%=proId%>&opCode=<%=opCode%>&provinceCode="+$('#provinceCode').val()+'&tellType='+$('#tellType').val();
	openDivWin("<%=request.getContextPath()%>/gotoGetLoginTree.do?"+qryPara,"查询工号信息","400","340");
}

//弹出工号树返回数据
function setLogins(out){
	if($.trim(out)!=''){
		var show=out.substring(out.indexOf(',')+1);
		if(show.lastIndexOf(',')==show.length-1){
			show=show.substring(0,show.length-1);
		}
		$('#grantLoginNames').val(show);
		var chksOpts=show.split(',');
		var logins='';
		for(var i=0;i<chksOpts.length;i++){
			logins=logins+chksOpts[i].substring(0,chksOpts[i].indexOf('（'))+',';
		}
		if(logins.length>0){
			logins=logins.substring(0,logins.length-1);
		}
		$('#grantLogins').val(logins);
	}else{
		$('#grantLoginNames').val('');
		$('#grantLogins').val('');
	}
}

//清空工号集合
function clrLogins(){
	$('#grantLoginNames').val('');
	$('#grantLogins').val('');
}

function checkBak(obj){
	if(obj.checked==false){
		$('#table_1').css('display','none');
	}else{
		$('#table_1').css('display','');
	}
}
</script>
</body>
</html>