<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.util.*" %>
<%
String sys=Constants.PROD_SYSTEM;
 %>
<html>
<head>
<title>新增任务配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="style/conf_style.css"/>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/menu_min.js"></script>
<script>  
//加载时适应浏览器高度
$(document).ready(function() {
    //模块尺寸  
	$('.pz_menu').css('height', $(window).height() - 141); 
	$('.pz_cont_wiap100').css('height', $(window).height() - 10); 
})
//改变窗体大小时适应浏览器高度
$(window).resize(function() {
    //模块尺寸
	$('.pz_menu').css('height', $(window).height() - 141);
	$('.pz_cont_wiap100').css('height', $(window).height() - 250);
});
</script>
<script type="text/javascript">
$(document).ready(function (){ 
  
  $(".pz_menu_cont ul li").menu();
  
}); 
</script>

</head>
<body>
   <div class="bb_right_cont1">
	<div id="operation_table">
		<form action="" method="post" name="frm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<div class="input">
				<table width="100%" border="0" cellspacing="2" cellpadding="0"  bgcolor="#FFFFFF">
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">作业名称：</td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;"><input type="text" name="job_name" id="job_name" v_maxlength="64" v_minlength="0" class="anc"/></td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">对应数据库：</td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<select name="h_order_id" id="h_order_id" style="width:186px;height:24px">
								<option value ="">--请选择--</option>
								<c:forEach items="${DBConnList }" var="item">
					   				<option value="${item.order_id }">${item.serv_ip }</option>
					   			</c:forEach>
						    </select>				
						</td>
					</tr>
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">作业类型：</td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<select name="job_mode" id="job_mode" onchange="selectRunTime(this.value);" style="width:186px;height:24px">
								<option value ="">--请选择--</option>
						    	<option value ="D">日作业</option>
						    	<option value ="M">月作业</option>
						    	<option value ="S">实时作业</option>
						    </select>				
						</td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">作业开始时间：</td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<div id="jobRunTime" style="display:none" ><input type="text" name="job_run_time" id="job_run_time" class="anc" onkeyup="value=value.replace(/[^\d]/g,'')" />秒</div>
							<select name="job_run_time_M" id="job_run_time_M" style="WIDTH: 20%;display:none">
								<option value ="">--</option>
								<c:forEach items="${jobRunTimeMList }" var="item">
					   				<option value="${item }">${item }日</option>
					   			</c:forEach>
						    </select>
						    <select name="job_run_time_H" id="job_run_time_H" style="WIDTH: 20%;display:none">
								<option value ="">--</option>
								<c:forEach items="${jobRunTimeHList }" var="item">
					   				<option value="${item }">${item }时</option>
					   			</c:forEach>
						    </select>
						    <select name="job_run_time_m" id="job_run_time_m" style="WIDTH: 20%;display:none">
								<option value ="">--</option>
								<c:forEach items="${jobRunTimemList }" var="item">
					   				<option value="${item }">${item }分</option>
					   			</c:forEach>
						    </select>
						    <select name="job_run_time_S" id="job_run_time_S" style="WIDTH: 20%;display:none">
								<option value ="">--</option>
								<c:forEach items="${jobRunTimemList }" var="item">
					   				<option value="${item }">${item }秒</option>
					   			</c:forEach>
						    </select>
						</td>
					</tr>
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">定时方式：</td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<select name="job_run_mode" id="job_run_mode" style="width:186px;height:24px">
								<option value ="">--请选择--</option>
						    	<option value ="1">定时</option>
						    	<option value ="2">实时</option>
						    </select>				
						</td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">运行频次：</td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<input type="text" name="job_run_freq" id="job_run_freq" v_maxlength="64" v_minlength="0" class="anc" onkeyup="value=value.replace(/[^\d]/g,'')"/>							
						</td>
					</tr> 
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">可否运行：</td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<select name="job_enable" id="job_enable" style="width:186px;height:24px">
								<option value ="">--请选择--</option>
						    	<option value ="0">不可运行</option>
						    	<option value ="1">可运行</option>
						    </select>				
						</td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">运行类型：</td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<select name="job_type" id="job_type" style="width:186px;height:24px">
								<option value ="">--请选择--</option>
						    	<option value ="0">全量</option>
						    	<option value ="1">增量</option>
						    </select>				
						</td>
					</tr>
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">数据源表：</td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;"><input type="text" name="s_tab" id="s_tab" v_maxlength="64" v_minlength="0" class="anc"/></td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">目的表：</td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;"><input type="text" name="d_tab" id="d_tab" v_maxlength="64" v_minlength="0" class="anc"/></td>
					</tr> 
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">导出语句：</td>
						<td colspan="3" width="22%" height="32" bgcolor="#f6f6f6" align="left">
							<textarea name="etl_sql" id="etl_sql" rows="4" cols="81" ></textarea>						
						</td>
					</tr>
      				<tr height="12"></tr>
					<tr>
			          <td height="32" align="center" class="blue" colspan="6">
			            <input name="su" type="button" class="bb_right_sub1" value="确  定" onclick="addDBConnSubmit()"/>&nbsp;&nbsp;&nbsp;
			            <input name="re" type="button" class="bb_right_sub1" value="重  置" onclick="doReset()"/>&nbsp;&nbsp;&nbsp;
						<input name="close" type="button" class="bb_right_sub1" value="关  闭" onclick="parent.doSrchSubmit();parent.removeDivWin('divWin');"/>
						</td>
			        </tr>
				</table>
			</div>
			<div align="center">
			    <font color="red"><span id="operInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script src="<%=request.getContextPath()%>/npage/rpt/task/task.js" type="text/javascript"></script>
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

function addDBConnSubmit(){
    if(!checksubmit(frm)){
		return false;
	}
	document.frm.action='<%=request.getContextPath()%>/addTask.do';
	document.frm.submit();
	
}

//超级管理员只能选择后台管理功能，普通管理员不能选择后台管理功能
function getPro(){
    $('#proCode').html($proCode);
    if($('#roleType').val()=='0'){
    	$('#proCode').val('<%=sys%>');
    	$('#proCode').attr('disabled','true');
    	validateField($('#proCode').get(0));
    }else{
        $('#proCode').attr('disabled','');
        $("#proCode option[value='<%=sys%>']").remove();
    }
}

function getProName(){
	$('#proName').val($('#proCode :selected').text());
}
</script>
</body>
</html>