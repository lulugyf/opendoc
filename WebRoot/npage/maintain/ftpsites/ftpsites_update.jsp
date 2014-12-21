<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
 
<html>
<head>
<title>修改FTP站点信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="ftpForm">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>"><!-- 为主机选择提供参数 -->
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
		<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
			
		<c:if test="${romFtpsitesInfo!=null}">
			<div class="input">
				<table>
					<tr>
						<th><font color="red">*站点名称：</font></th>
						<td>
							<input type="hidden" name="siteId" id="siteId" value="${romFtpsitesInfo.siteId}" />
							<input type="hidden" name="siteNameOld" id="siteNameOld" value="${romFtpsitesInfo.siteName}" />
							<input type="text" name="siteName" id="siteName" value="${romFtpsitesInfo.siteName}" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th></th>
						<td></td>
					</tr>				
					<tr>
						<th><font color="red">*主机：</font></th>
						<td>
							<input type="hidden" name="hostId" id="hostId" value="${romFtpsitesInfo.hostId}"/>
							<input type="hidden" name="hostNameOld" id="hostNameOld" value="${hostinfostr}" />
							<input type="text" name="hostName" id="hostName" class="required" value="${hostinfostr}" readonly="true"/>
							<input type="button" class="b_text" name="choiceButton" onClick="choiceHostInfo()" value="选择主机" />
						</td>
						<th><font color="red">*端口：</font></th>
						<td>
							<input type="text" name="ftpPort" id="ftpPort" value="${romFtpsitesInfo.ftpPort}" class="required posInt"/>					
						</td>
					</tr>
					<tr>
						<th><font color="red">*用户名：</font></th>
						<td>
							<input type="text" name="ftpUser" id="ftpUser" value="${romFtpsitesInfo.ftpUser}" class="required isCharLengthOf" v_maxlength="8" v_minlength="0"/>
						</td>
						<th><font color="red">*SSL：</font></th>
						<td>
							<select name="sslFlag" id="sslFlag" onchange="showSSLcert()">
								<option value="0">无</option>
								<option value="1">认证SSL</option>
							</select>
						</td>				
					</tr>
					<tr>
						<th><font color="red">*密码：</font></th>
						<td>
							<input type="password" name="ftpPasswd" id="ftpPasswd" value="${romFtpsitesInfo.ftpPasswd}" class="required isCharLengthOf" v_maxlength="8" v_minlength="0"/>
						</td>	
						<th><span id="sslCertSpan" style="display:none">客户端证书：</span></th>
						<td>
							<select id="sslCertSel" style="display:none">
								<option>无</option>
							</select>
							<input id="sslCertBut" style="display:none" type="button" class="b_text" value="证书管理器" />
						</td>
					</tr>
					<tr>
						<th>远端路径：</th>
						<td colspan="3">
							<input type="text" name="remotePath" id="remotePath" value="${romFtpsitesInfo.remotePath}" style="width:60%;" class="isCharLengthOf" v_maxlength="128" v_minlength="0"/>
						</td>
					</tr>
					<tr>
						<th>本地路径：</th>
						<td colspan="3">
							<input type="text" name="localPath" id="localPath" value="${romFtpsitesInfo.localPath}" style="width:60%;" class="isCharLengthOf" v_maxlength="128" v_minlength="0"/>
						</td>
					</tr>
					<tr>
						<th>代理服务器：</th>
						<td colspan="3">
							<input type="text" name="agentAddr" id="agentAddr" value="${romFtpsitesInfo.agentAddr}" style="width:60%;" class="ipAddress isCharLengthOf" v_maxlength="32" v_minlength="0"/>
						</td>
					</tr>
					<tr>
						<th>备注：</th>
						<td colspan="3">
							<input type="text" name="remarks" id="remarks" style="width:60%;" class="isCharLengthOf" v_maxlength="256" v_minlength="0" value="${romFtpsitesInfo.remarks}"/>
						</td> 				
					</tr>
					<tr>
						<th><font color="red">*是否共享：</font></th>
						<td colspan="3">
							<input type="radio" name="isGrant" value="1" checked="true" onclick="showGrantMethod(this)"/>否
 							<input type="radio" name="isGrant" value="0" onclick="showGrantMethod(this)"/>是
						</td>
					</tr>
					<tr id="grantMethodTr" style="display:none">
						<th><font color="red">*共享方式：</font></th>
						<td colspan="3">
							<input type="radio" name="grantMethod" value="1" checked="true" onclick="showGrantLogin(this)"/>完全共享
 							<input type="radio" name="grantMethod" value="0" onclick="showGrantLogin(this)"/>部分共享
						</td>
					</tr>
					<tr id="grantLoginTr" style="display:none">
						<th><font color="red">*选择工号：</font></th>
						<td colspan="3">
							<input type=hidden name="grantLogins" id="grantLogins" value="${romFtpsitesInfo.grantLogins}"/>
							<input type="text" name="grantLoginNames" id="grantLoginNames" style="width:450px" value="${loginsMess}" readonly="readonly"/>
							<input type="button" name="choiceButton" id="choiceButton" onClick="choiceLogins();" class="b_foot" value="选择" />
							<input type="button" name="clr" id="clr" onClick="clrLogins();" class="b_foot" value="清空" />
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="updateFtpSubmit()" class="b_foot" value="确定" />
				<input type="button" name="re" onClick="resetFrm()" class="b_foot" value="重置" />
				<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
			</div>
			<div align="center">
			    <font color="red"><span id="succInfo">${operInfo}</span></font>
			</div>
		</c:if>
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
	
	$('#sslFlag').val('${romFtpsitesInfo.sslFlag}');
	showSSLcert();
	
	if('${romFtpsitesInfo.isGrant}'==0){ //共享
		$("input[name='isGrant']").each(function(){
	        if($(this).val()==0){
	            $(this).click();
	        }
	    });
	    if($.trim('${romFtpsitesInfo.grantLogins}')!=''){ //部分共享
	    	$("input[name='grantMethod']").each(function(){
		        if($(this).val()==0){
		            $(this).click();
		        }
		    });
	    }
	}
});

function updateFtpSubmit(){
    if(!checksubmit(ftpForm)){
		return false;
	}
	
	if($("input[name='isGrant']:checked").val()==1){ //不共享
		$('#grantLogins').val('');
	}else if($("input[name='grantMethod']:checked").val()==1){
		$('#grantLogins').val('');
	}
	
	document.ftpForm.action='<%=request.getContextPath()%>/updateFtpsite.do';
	document.ftpForm.submit();
}

function choiceHostInfo(){
	var qryPara="proId=<%=proId%>&opCode=<%=opCode%>&provinceCode="+$('#provinceCode').val()+'&tellType='+$('#tellType').val();
	openDivWin("<%=request.getContextPath()%>/gotoQryHostInfo.do?"+qryPara,"查询主机信息","700","300");
}

function setHost(hostId,hostInfo){
	$("#hostName").val(hostInfo);
	$("#hostId").val(hostId);
}

function showSSLcert(){
	if($('#sslFlag').val()=='0'){
		$('#sslCertSpan').css('display','none');
		$('#sslCertSel').css('display','none');
		$('#sslCertBut').css('display','none');
	}else{
		$('#sslCertSpan').css('display','');
		$('#sslCertSel').css('display','');
		$('#sslCertBut').css('display','');
	}
}
function resetFrm(){
	document.forms('ftpForm').reset();
	$('#sslFlag').val('${romFtpsitesInfo.sslFlag}');
	showSSLcert();
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