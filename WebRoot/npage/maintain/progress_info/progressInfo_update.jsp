<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.bo.HostBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%
String provinceCode= request.getParameter("provinceCode");
String tellType= request.getParameter("tellType");

HostBo hostBo=(HostBo)request.getAttribute("hostBo");
String hostinfostr="";
if(null!=hostBo){
	hostinfostr=hostBo.getProvinceName()+hostBo.getTellName()+"-"+hostBo.getHostIp();
}
%>
<html>
<head>
<title>修改进程配置信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm">
		
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=provinceCode%>">
			<input type=hidden name="tellType" id="tellType" value="<%=tellType%>">
			
			<input type=hidden name="itemId" id="itemId" value="${romMaintainItems.itemId}">
			<div class="input">
				<table>
 					<tr>
 						<th>主机信息：</th>
						<td>
							<input type="text" name="hostinfostr" id="hostinfostr" class="" readonly="readonly" value="<%=hostinfostr %>"  size="80"/>
						</td> 						
 					</tr> 
					<tr>
						<th><font color="red">*进程名称：</font></th>
						<td>
							<input type="text" name="itemName" id="itemName" value="${romMaintainItems.itemName}" class="required isCharLengthOf" v_maxlength="128" v_minlength="0"/>
							<input type="hidden" name="itemNameOld" id="itemNameOld" value="${romMaintainItems.itemName}"/>
						</td>
					</tr>
					<tr>
						<th><font color="red">*进程功能描述：</font></th>
						<td>
 							<input type="text" name="itemDesc" id="itemDesc" value="${romMaintainItems.itemDesc}" class="required isCharLengthOf" v_maxlength="256" v_minlength="0"/>
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
							<input type=hidden name="grantLogins" id="grantLogins" value="${romMaintainItems.grantLogins}"/>
							<input type="text" name="grantLoginNames" id="grantLoginNames" style="width:450px" value="${loginsMess}" readonly="readonly"/>
							<input type="button" name="choiceButton" id="choiceButton" onClick="choiceLogins();" class="b_foot" value="选择" />
							<input type="button" name="clr" id="clr" onClick="clrLogins();" class="b_foot" value="清空" />
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="updateProgInfoConfSubmit()" class="b_foot" value="确定" />
				<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
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
		    parent.doSrchSubmit();
	    }catch(e){}
	});
	
	if('${romMaintainItems.isGrant}'==0){ //共享
		$("input[name='isGrant']").each(function(){
	        if($(this).val()==0){
	            $(this).click();
	        }
	    });
	    if($.trim('${romMaintainItems.grantLogins}')!=''){ //部分共享
	    	$("input[name='grantMethod']").each(function(){
		        if($(this).val()==0){
		            $(this).click();
		        }
		    });
	    }
	}
});

function updateProgInfoConfSubmit(){
    if(!checksubmit(hostForm)){
		return false;
	}
	
	if($("input[name='isGrant']:checked").val()==1){ //不共享
		$('#grantLogins').val('');
	}else if($("input[name='grantMethod']:checked").val()==1){
		$('#grantLogins').val('');
	}
	
	document.hostForm.action='<%=request.getContextPath()%>/updateProgInfoConf.do';
	document.hostForm.submit();
}

function choiceHostInfo(){
	var qryPara="proId=<%=proId%>&opCode=<%=opCode%>&provinceCode="+$('#provinceCode').val()+'&tellType='+$('#tellType').val();
	openDivWin("<%=request.getContextPath()%>/gotoQryHostInfo.do?"+qryPara,"查询主机信息","700","300");
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
	qryPara=qryPara+'&treeExists='+$('#grantLogins').val();
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
</script>
</body>
</html>