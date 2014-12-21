<%@page import="groovy.util.MapEntry"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.util.*" %>
<%@ page import="java.util.*" %>

<html>
<head>
<title>消息通知配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/NumericStepper/stepper/jquery.stepper.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/njs/plugins/NumericStepper/stepper/jquery.stepper.min.css"/> 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="messForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">

            <%
               String enable=StringUtil.safeValue(request.getAttribute("ENABLE").toString().trim());
               String week=StringUtil.safeValue(request.getAttribute("WEEK").toString().trim());
               String clock=StringUtil.safeValue(request.getAttribute("CLOCK").toString().trim());
               String sendMail=StringUtil.safeValue(request.getAttribute("SENDEMAIL").toString().trim());
               String sendTo=StringUtil.safeValue(request.getAttribute("SENDTO").toString().trim());
               String ccTo=StringUtil.safeValue(request.getAttribute("CCTO").toString().trim());
               String sendMess=StringUtil.safeValue(request.getAttribute("SENDMESSAGE").toString().trim());
               String msTo=StringUtil.safeValue(request.getAttribute("MSTO").toString().trim());
            %>

			<div class="input">
				<table>
					<tr>
						<th>消息提醒频率：</th>
							<td colspan="3">
								      <input type="checkbox" name="week" value="monday"    style="vertical-align:middle" <% if(week.indexOf("monday") != -1 ) {%> checked="checked"<% }%>>周一 </input>
									  <input type="checkbox" name="week" value="tuesday"   style="vertical-align:middle" <% if(week.indexOf("tuesday") != -1 ) {%> checked="checked"<% }%>>周二</input>
									  <input type="checkbox" name="week" value="wednesday" style="vertical-align:middle" <% if(week.indexOf("wednesday") != -1 ) {%> checked="checked"<% }%>>周三</input>
									  <input type="checkbox" name="week" value="thursday"  style="vertical-align:middle" <% if(week.indexOf("thursday") != -1 ) {%> checked="checked"<% }%>>周四</input>
									  <input type="checkbox" name="week" value="friday"    style="vertical-align:middle" <% if(week.indexOf("friday") != -1 ) {%> checked="checked"<% }%>>周五</input>
									  <input type="checkbox" name="week" value="saturday"  style="vertical-align:middle" <% if(week.indexOf("saturday") != -1 ) {%> checked="checked"<% }%>>周六</input>
									  <input type="checkbox" name="week" value="sunday"    style="vertical-align:middle" <% if(week.indexOf("sunday") != -1 ) {%> checked="checked"<% }%>>周日</input>
							</td>
					</tr>
					<tr>
						<th>消息提醒时间：</th>
						<td td colspan="3">
							<input type="text" name="clock" id="clock" class="required isSizeOf" v_maxlength="23" v_minlength="0" size="5" value="<%=clock %>"/> (0~23点)
						</td>
					</tr>
					<tr>						
						<th><input type="checkbox" name="isEmail" id="isEmail" style="vertical-align:middle" onclick="displayCHK()" <% if(sendMail.equals("Y")) {%>checked="true"<% }%>>是否发送邮件</input></th>
						<td td colspan="3"></td>						
					</tr> 
					<tr>
					   <th>发送人：</th>
					    <td td colspan="3">
							<input type="text" name="sendTo" id="sendTo" class="isCharLengthOf" v_maxlength="256" v_minlength="0" size="124" disabled="disabled" value="<% if(sendMail.equals("Y")) {%>${SENDTO}<%}%>"/>（多人用，分割）
						</td>
					</tr>
					<tr>
					    <th>抄送人：</th>
						<td td colspan="3">
							<input type="text" name="ccTo" id="ccTo" class="isCharLengthOf" v_maxlength="256" v_minlength="0" size="124" disabled="disabled" value="<% if(sendMail.equals("Y")) {%>${CCTO}<%}%>" />（多人用，分割）
						</td>
					</tr>
					<tr>						
						<th><input type="checkbox" name="isMess" id="isMess" style="vertical-align:middle" onclick="displayCHK()" <% if(sendMess.equals("Y")) {%>checked="true"<% }%>>是否发送短息</input></th>
						<td td colspan="3"><font color="red">**只针对监控异常点发送短信</font></td>						
					</tr> 
					<tr>
					   <th>短信接收人：</th>
					    <td td colspan="3">
							<input type="text" name="messTo" id="messTo" class="isCharLengthOf" v_maxlength="256" v_minlength="0" size="124" disabled="disabled" value="<% if(sendMess.equals("Y")) {%>${MSTO}<%}%>"/>（多人用，分割）
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="addSubmit()" class="b_foot" value="设置" />
				<input type="reset" name="re" onClick="javascript:document.forms('roleForm').reset();" class="b_foot" value="重置" />
				<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
			</div>
			<div align="center">
			    <font color="red"><span id="operInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>

<script>
$(document).ready(function () {
    displayCHK();
   
   	$('#clock').stepper({
    UI: true,          // show up-down button
    type: 'int',       // Allow int point numbers
    wheel_step:1,       // Wheel increment is 1
    arrow_step: 1,    // Up/Down arrows increment is 1
    limit: [0,23]         // limit 0~23 hours
   });
});



function displayCHK(){
   if($("#isEmail").attr("checked")){
       $("#sendTo").removeAttr("disabled");
       $("#ccTo").removeAttr("disabled");
   }else{
       $("#sendTo").attr("disabled","disabled");
       $("#ccTo").attr("disabled","disabled");
   }
   
   if($("#isMess").attr("checked")){
       $("#messTo").removeAttr("disabled");
   }else{
       $("#messTo").attr("disabled","disabled");
   }
}

function addSubmit(){
  var week='';  
  var sendEmail='';  
  var sendMess='';  
  var obj=document.getElementsByName('week');  //选择所有name="'week'"的对象，返回数组    
  for(var i=0; i<obj.length; i++){  
    if(obj[i].checked)
       week+=obj[i].value+',';  //如果选中，将value添加到变量sweek中  
  }   
  week = week.substring(0, week.length-1);
  if(!checksubmit(messForm)){
		return false;
   }
   	if($("#isEmail").attr("checked")){
   	   sendEmail='Y';
   	}else{
   	   sendEmail='N';
   	}
   	if($("#isMess").attr("checked")){
   	   sendMess='Y'
   	}else{
   	  sendMess='N';
   	}
   	  
	document.messForm.action='<%=request.getContextPath()%>/addMessageNotification.do?week='+week+'&sendEmail='+sendEmail+'&sendMess='+sendMess ;
	document.messForm.submit();	
}

function getCHK(){  
  var obj=document.getElementsByName('week');  //选择所有name="'week'"的对象，返回数组  
  var week='';  
  for(var i=0; i<obj.length; i++){  
    if(obj[i].checked)
       week+=obj[i].value+',';  //如果选中，将value添加到变量sweek中  
  }  
  //那么现在来检测s的值就知道选中的复选框的值了  
  alert(week==''?'你还没有选择任何内容！':week);  
}  
  
function jqchk(){  //jquery获取复选框值  
  var chk_value =[];  
  $('input[name="week"]:checked').each(function(){  
   chk_value.push($(this).val());  
  });  
  alert(chk_value.length==0 ?'你还没有选择任何内容！':chk_value);  
}  

</script>
</body>
</html>