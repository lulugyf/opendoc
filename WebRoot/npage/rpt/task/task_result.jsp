<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>任务管理</title>
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
	<form name="srchFrm" target="ifm" method="post">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="pageNum" id="pageNum" value="1">
<div id="operation" class="bb_right_cont1">
      <div height="12"><table><tr height="12"></tr></table> </div>
				<table width="100%" border="0" cellspacing="2" cellpadding="0"  bgcolor="#FFFFFF">
				        <tr>
                            <td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">作业名称：</td>
						    <td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
								<select name="job_id" id="job_id" style="width:186px;height:24px">
									<option value ="">--请选择--</option>
									<c:forEach items="${taskConfList }" var="item">
						   				<option value="${item.job_id }">${item.job_name }</option>
						   			</c:forEach>
							    </select>				
						    </td>
						    <td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">运行状态：</td>
							<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
								<select name="run_status" id="run_status" style="width:186px;height:24px">
									<option value ="">--请选择--</option>
									<option value ="0">等待运行</option>
									<option value ="1">开始导出</option>
									<option value ="2">导出成功</option>
									<option value ="3">导出失败</option>
									<option value ="4">开始导入</option>
									<option value ="5">导入成功</option>
									<option value ="6">导入失败</option>
								</select>
							</td>
					</tr>
					<tr>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">运行开始时间：</td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<input id="start_time" name="start_time" type="text"  v_maxlength="64" v_minlength="0" class="anc"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true,maxDate:'#F{$dp.$D(\'end_time\')}'})"/>
						</td>
						<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">运行结束时间：</td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
							<input id="end_time" name="end_time" type="text"  v_maxlength="64" v_minlength="0" class="anc"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true,minDate:'#F{$dp.$D(\'start_time\')}'})"/>
						</td>
					</tr>
					<tr>
						
					</tr> 
					<tr>
						<td height="32" align="center" class="blue" colspan="4">
            				<input name="" type="button" class="bb_right_sub1" value="查  询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            				<input name="" type="button" class="bb_right_sub1" value="重  置" onclick="doReset()"/>&nbsp;&nbsp;&nbsp;
							<!-- <input type="button" class="b_foot" id="add" style="display:none" value="新增" onclick="addTask()"/>  -->
					  </td>
					</tr>
				</table>

			<iframe name="ifm" src="" style="width:100%;height:400px;" frameborder="0"></iframe>

		</div>
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
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/taskresultList.do"+param;
    document.forms['srchFrm'].submit();
}

function doReset(){
	$('#job_id').val('');
	$('#run_status').val('');
	$('#start_time').val('');
	$('#end_time').val('');
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