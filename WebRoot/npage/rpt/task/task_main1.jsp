<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>任务管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<form name="srchFrm" target="ifm" method="post">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
<div id="operation">
		<%@ include file="/npage/include/header.jsp"%>
</div>	 
				<table class="myoptable">
					<th>作业名称</th>
						<td>
							<input type="text" name="job_name" id="job_name" v_maxlength="64" v_minlength="0"/>
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
							<input type="text" name="job_run_freq" id="job_run_freq" onkeyup="value=value.replace(/[^\d]/g,'')" v_maxlength="64" v_minlength="0"/>							
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
							<input type="text" name="s_tab" id="s_tab" v_maxlength="64" v_minlength="0"/>							
						</td>
						<th>目的表</th>
						<td>
							<input type="text" name="d_tab" id="d_tab" v_maxlength="64" v_minlength="0"/>							
						</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="doReset()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" id="add" style="display:none" value="新增" onclick="addTask()"/>
					  </td>
					</tr>
				</table>

			<iframe name="ifm" src="" style="width:100%;height:400px;" frameborder="0"></iframe>

		<%@ include file="/npage/include/footer.jsp" %>
	</form>
						
</body>
<!-- 自动补全引入js -->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/myactb.js"></script>
<script src="<%=request.getContextPath()%>/npage/rpt/task/task.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
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
            }else if(opers[i]=='4'){
                param=param+'pope=Y&';
            }
        }
    }
}
/***********显示隐藏功能权限对应按钮 end***************/

//查询表单提交
function doSrchSubmit(){
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/tasklist.do"+param;
    document.forms['srchFrm'].submit();
}

//增加关联模块，打开弹出窗口
function addTask(){
	openDivWin("<%=request.getContextPath()%>/gotoAddTask.do?proId=<%=proId%>&opCode=<%=opCode%>","新增任务配置","800","300");
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


</script>
</html>