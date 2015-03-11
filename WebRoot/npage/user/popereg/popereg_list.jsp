<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.common.bo.PoperegBo" %>
<%@ page import="com.sitech.rom.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<link rel="stylesheet" type="text/css" href="style/conf_style.css"/>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/menu_min.js"></script>
<body>
<div class="pz_cont_wiap100 fr">
    <div class="blankH12"></div>
    <div class="pz_cont_main">
    <form name="listFrm" method="post" action="poperegList.do">
    	<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="pageNum" id="pageNum" value="">
		
		<input type=hidden name="actionName" id="actionName" value="${bo.actionName}">
		<input type=hidden name="functionCode" id="functionCode" value="${bo.functionCode}">
	<table id="mTable" width="100%" border="0" cellSpacing="2" cellpadding="0" bgcolor="#FFFFFF">
		<tr class="f14 white">
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">功能链接</td>
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">所属功能</td>
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">对应操作项</td>
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">操作</td>
		</tr>
		<% 
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    
 
		%>
		<c:forEach items="${popereglist }" var="show">    
	   		<tr>
		   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${show.actionName }</td>
		   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${show.functionName} ${show.functionCode}</td>
		   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${show.operationName }
		   		</td>
		   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
		   			<input type="button" name="edit" style="width:20px;" class="butwrite" title="编辑" onclick="editRow('${show.actionName}','${show.functionCode}')"/>
		   		    <input type="button" name="del" style="width:20px;" class="butdelete" title="删除" onclick="showDialog('请确认是否删除?',3,'retT=delRow(\'${show.actionName}\',\'${show.functionCode}\',\'${show.functionName}\')');"/>  
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
function editRow(actionName,functionCode){
	var param="proId=<%=proId%>&opCode=<%=opCode%>&actionName="+actionName+"&functionCode="+functionCode;
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdatePopereg.do?"+param,"修改功能注册信息","800","300");
	parent.refreshByClose();
}
//删除行
function delRow(actionName,functionCode,functionName){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delPopereg.do");
	packet.data.add("actionName" ,actionName);
	packet.data.add("functionCode" ,functionCode);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("functionName" ,functionName);
	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("删除失败！",0);
  	}
}

</script>
</html>
