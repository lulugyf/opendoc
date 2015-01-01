<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.util.*" %>
<%
String sys=Constants.PROD_SYSTEM;
 %>
<html>
<head>
<title>新增数据库连接</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="frm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<div class="input">
				<table>
					<tr>
						<th>作业名称</th>
						<td>
							<input type="text" name="job_name" id="job_name" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>
						</td>
						<th>对应数据库</th>
						<td>
							<select name="h_order_id" id="h_order_id">
								<option value ="">--请选择--</option>
								<c:forEach items="${DBConnList }" var="item">
					   				<option value="${item.order_id }">${item.serv_ip }</option>
					   			</c:forEach>
						    </select>				
						</td>
					</tr>
					<tr>
						<th>作业类型</th>
						<td>
							<select name="job_mode" id="job_mode" onchange="selectRunTime(this.value);">
								<option value ="">--请选择--</option>
						    	<option value ="D">日作业</option>
						    	<option value ="M">月作业</option>
						    	<option value ="S">实时作业</option>
						    </select>				
						</td>
						<th>作业运行时间</th>
						<td>
						 	<div id="jobRunTime" style="display:none" ><input type="text" name="job_run_time" id="job_run_time" onkeyup="value=value.replace(/[^\d]/g,'')" />秒</div>
							<select name="job_run_time_M" id="job_run_time_M" style="WIDTH: 60px;display:none">
								<option value ="">--</option>
								<c:forEach items="${jobRunTimeMList }" var="item">
					   				<option value="${item }">${item }日</option>
					   			</c:forEach>
						    </select>
						    <select name="job_run_time_H" id="job_run_time_H" style="WIDTH: 60px;display:none">
								<option value ="">--</option>
								<c:forEach items="${jobRunTimeHList }" var="item">
					   				<option value="${item }">${item }时</option>
					   			</c:forEach>
						    </select>
						    <select name="job_run_time_m" id="job_run_time_m" style="WIDTH: 60px;display:none">
								<option value ="">--</option>
								<c:forEach items="${jobRunTimemList }" var="item">
					   				<option value="${item }">${item }分</option>
					   			</c:forEach>
						    </select>
						    <select name="job_run_time_S" id="job_run_time_S" style="WIDTH: 60px;display:none">
								<option value ="">--</option>
								<c:forEach items="${jobRunTimemList }" var="item">
					   				<option value="${item }">${item }秒</option>
					   			</c:forEach>
						    </select>
						</td>
					</tr>
					<tr>
						<th>定时方式</th>
						<td>
							<select name="job_run_mode" id="job_run_mode">
								<option value ="">--请选择--</option>
						    	<option value ="1">定时</option>
						    	<option value ="2">实时</option>
						    </select>				
						</td>
						<th>运行频次</th>
						<td>
							<input type="text" name="job_run_freq" id="job_run_freq" onkeyup="value=value.replace(/[^\d]/g,'')" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>							
						</td>
					</tr> 
					<tr>
						<th>可否运行</th>
						<td>
							<select name="job_enable" id="job_enable">
								<option value ="">--请选择--</option>
						    	<option value ="0">不可运行</option>
						    	<option value ="1">可运行</option>
						    </select>				
						</td>
						<th>运行类型</th>
						<td>
							<select name="job_type" id="job_type">
								<option value ="">--请选择--</option>
						    	<option value ="0">全量</option>
						    	<option value ="1">增量</option>
						    </select>				
						</td>
					</tr>
					<tr>
						<th>数据源表</th>
						<td>
							<input type="text" name="s_tab" id="s_tab" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>							
						</td>
						<th>目的表</th>
						<td>
							<input type="text" name="d_tab" id="d_tab" class="required isCharLengthOf" v_maxlength="64" v_minlength="0"/>							
						</td>
					</tr> 
					<tr>
					<th>导出语句</th>
						<td colspan="3">
							<textarea name="etl_sql" id="etl_sql" rows="4" cols="60"></textarea>							
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="addDBConnSubmit()" class="b_foot" value="确定" />
				<input type="reset" name="re" onClick="doReset()" class="b_foot" value="重置" />
				<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
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