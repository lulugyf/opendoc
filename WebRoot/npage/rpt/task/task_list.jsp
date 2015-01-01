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
<div class="title"> <div class="text">任务配置列表</div></div>  
<div class="list11">
	<table id="mTable1">
		<tr>
			<th>作业名称</th>
			<th>对应数据库</th>
			<th>作业类型</th>
			<th>作业开始时间</th>
			<th>运行频次</th>
			<th>定时方式</th>
			<th>可否运行</th>
			<th>运行类型</th>
			<th>数据源表</th>
			<th>目的表</th>
			<!--  <th>导出语句</th> -->
			<th>操作</th>
		</tr>
		<% 

		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		%>
		    <c:forEach items="${rlist }" var="item">
		   		<tr>
			   		<td>${item.job_name }</td>
			   		<td>${item.serv_ip}</td>
			   		<td>
				   		<c:if test="${item.job_mode == 'D'}" >日作业</c:if>
				   		<c:if test="${item.job_mode == 'M'}">月作业</c:if>
				   		<c:if test="${item.job_mode == 'S'}">实时作业</c:if>
			   		</td>
			   		<td>
			   			<c:if test="${item.job_mode == 'D'}" >
							${item.job_run_time_H }:${item.job_run_time_m }:${item.job_run_time_S }
						</c:if>
						<c:if test="${item.job_mode == 'M'}" >
							${item.job_run_time_M }日 &nbsp;${item.job_run_time_H }:${item.job_run_time_m }:${item.job_run_time_S }
						</c:if>
						<c:if test="${item.job_mode == 'S'}" >
							${item.job_run_time}秒
						</c:if>
			   		</td>
			   		<td>
				   		${item.job_run_freq }
			   		</td>
			   		<td>
			   			<c:if test="${item.job_run_mode == '1'}" >定时</c:if>
				   		<c:if test="${item.job_run_mode == '2'}">实时</c:if></td>
			   		<td>
			   			<c:if test="${item.job_enable == '0'}" >不可运行</c:if>
				   		<c:if test="${item.job_enable == '1'}">可运行</c:if>
			   		</td>
			   		<td>
			   			<c:if test="${item.job_type == '0'}" >全量</c:if>
				   		<c:if test="${item.job_type == '1'}">增量</c:if>
			   		</td>
			   		<td>${item.s_tab}</td>
			   		<td>${item.d_tab}</td>
			   		<!--  <td>${item.etl_sql}</td> -->
			   		<td>
			   		   
		   		    <input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('${item.job_id}')"/>
		   		    <input type="button" class="butDel" name="del" style="display:none" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'${item.job_id}\')');"/>  
			   		    
			   		</td>
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
