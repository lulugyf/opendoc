<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>


<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">任务结果列表</div></div>  
<div class="list11">
	<table id="mTable1">
		<tr>
			<th>作业名称</th>
			<th>作业执行日期</th>
			<th>开始时间</th>
			<th>结束时间</th>
			<th>运行状态</th>
			<th>运行情况</th>
		</tr>
		<% 

		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		%>
		    <c:forEach items="${rlist }" var="item">
		   		<tr>
			   		<td>${item.job_name }</td>
			   		<td>${item.op_date}</td>
			   		<td>${item.start_time }</td>
			   		<td>${item.end_time}</td>
			   		<td>
			   			<c:if test="${item.run_status == '0'}" >等待运行</c:if>
				   		<c:if test="${item.run_status == '1'}">开始导出</c:if>
				   		<c:if test="${item.run_status == '2'}" >导出成功</c:if>
				   		<c:if test="${item.run_status == '3'}">导出失败</c:if>
				   		<c:if test="${item.run_status == '4'}" >开始导入</c:if>
				   		<c:if test="${item.run_status == '5'}">导入成功</c:if>
				   		<c:if test="${item.run_status == '6'}" >导入失败</c:if>
			   		</td>
			   		<td>${item.run_msg}</td>
		   		</tr>
		   	 </c:forEach>
	</table>
</div>
  
</div>	
</div>
<%@ include file="/npage/include/footer.jsp"%>
 </body>
 
<script language="javascript" type="text/javascript">
$(document).ready(function () {
    if('<%=edit%>'=='Y'){
        $("input[name='edit']").each(function(){
            $(this).css('display','');
        })
    }
    if('<%=del%>'=='Y'){
        $("input[name='del']").each(function(){
            $(this).css('display','');
        })
    }
    parent.unLoading('ajaxLoadingDiv');
});

//编辑当前行内容
function editRow(job_id){
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateTask.do?proId=<%=proId%>&opCode=<%=opCode%>&job_id=" + job_id ,"修改任务配置","800","300");
	parent.refreshByClose();
}
//删除行
function delRow(job_id){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delTask.do");
	packet.data.add("job_id" ,job_id);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("任务删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("任务删除失败！"+retMsg,0);
  	}
}

</script>
</html>
