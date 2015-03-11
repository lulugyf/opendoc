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
    <form name="listFrm" method="post" action="tasklist.do">
    	<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="pageNum" id="pageNum" value="">
		
		<input type=hidden name="job_name" id="job_name" value="${bo.job_name}">
		<input type=hidden name="job_mode" id="job_mode" value="${bo.job_mode}">
		<input type=hidden name="job_run_mode" id="job_run_mode" value="${bo.job_run_mode}">
		<input type=hidden name="job_enable" id="job_enable" value="${bo.job_enable}">
		<input type=hidden name="job_type" id="job_type" value="${bo.job_type}">
		<input type=hidden name="job_run_time" id="job_run_time" value="${bo.job_run_time}">
		<input type=hidden name="h_order_id" id="h_order_id" value="${bo.h_order_id}">
		<input type=hidden name="s_tab" id="s_tab" value="${bo.s_tab}">
		<input type=hidden name="d_tab" id="d_tab" value="${bo.d_tab}">
      <table width="100%" border="0" cellSpacing="2" cellpadding="0" bgcolor="#FFFFFF">
        <tr class="f14 white">
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">作业名称</td>
          <td width="12%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">对应数据库</td>
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">作业类型</td>
          <td width="11%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">作业开始时间</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">运行频次</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">定时方式</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">可否运行</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">运行类型</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">数据源表</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">目的表</td>
          <td width="6%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">操作</td>
        </tr>
		<% 

		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		%>
		    <c:forEach items="${rlist }" var="item">
        <tr>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.job_name }</td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.serv_ip}</td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
				   		<c:if test="${item.job_mode == 'D'}" >日作业</c:if>
				   		<c:if test="${item.job_mode == 'M'}">月作业</c:if>
				   		<c:if test="${item.job_mode == 'S'}">实时作业</c:if>
          </td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
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
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.job_run_freq }</td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
			   			<c:if test="${item.job_run_mode == '1'}" >定时</c:if>
				   		<c:if test="${item.job_run_mode == '2'}">实时</c:if>
	      </td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
			   			<c:if test="${item.job_enable == '0'}" >不可运行</c:if>
				   		<c:if test="${item.job_enable == '1'}">可运行</c:if>
          </td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
			   			<c:if test="${item.job_type == '0'}" >全量</c:if>
				   		<c:if test="${item.job_type == '1'}">增量</c:if>
		  </td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.s_tab}</td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.d_tab}</td>
          <td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
                    <input type="button" class="butwrite" name="edit" style="width:20px;" title="编辑" onclick="editRow('${item.job_id}')"/>
		   		    <input type="button" class="butdelete" name="del" style="width:20px;" title="删除" onclick="showDialog('请确认是否删除?',3,'retT=delRow(\'${item.job_id}\')');"/>  
          </td>
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
