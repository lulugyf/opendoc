<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>


<html>
<link rel="stylesheet" type="text/css" href="style/conf_style.css"/>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/menu_min.js"></script>
<body>
<div class="pz_cont_wiap100 fr">
    <div class="blankH12"></div>
    <div class="pz_cont_main">
    <form name="listFrm" method="post" action="taskresultList.do">
    	<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="pageNum" id="pageNum" value="">
		
		<input type=hidden name="job_id" id="job_id" value="${bo.job_id}">
		<input type=hidden name="run_status" id="run_status" value="${bo.run_status}">
		<input type=hidden name="start_time" id="start_time" value="${bo.start_time}">
		<input type=hidden name="end_time" id="end_time" value="${bo.end_time}">
		
      <table width="100%" border="0" cellSpacing="2" cellpadding="0" bgcolor="#FFFFFF">
        <tr class="f14 white">
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">作业名称</td>
          <td width="12%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">作业执行日期</td>
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">开始时间</td>
          <td width="11%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">结束时间</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">运行状态</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">运行情况</td>
        </tr>
		<% 

		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		%>
		    <c:forEach items="${rlist }" var="item">
        <tr>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.job_name }</td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.op_date}</td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.start_time}</td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.end_time}</td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
			   			<c:if test="${item.run_status == '0'}" >等待运行</c:if>
				   		<c:if test="${item.run_status == '1'}">开始导出</c:if>
				   		<c:if test="${item.run_status == '2'}" >导出成功</c:if>
				   		<c:if test="${item.run_status == '3'}">导出失败</c:if>
				   		<c:if test="${item.run_status == '4'}" >开始导入</c:if>
				   		<c:if test="${item.run_status == '5'}">导入成功</c:if>
				   		<c:if test="${item.run_status == '6'}" >导入失败</c:if>
          </td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.run_msg}</td>
        </tr>
	  </c:forEach>
      </table>
      </form>
      <div class="blankH22"></div>
      <div align="center">
        <!-- 分页 begin -->
        <jsp:include page="/npage/public/pagination.jsp" />
        <!-- 分页 end -->
      </div>
      <div class="blankH18"></div>
    </div>
  <p class="clear"></p>
 </body>
 
<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>
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
