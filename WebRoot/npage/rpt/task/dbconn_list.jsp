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
    <form name="listFrm" method="post" action="dbconnsList.do">
    	<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="pageNum" id="pageNum" value="">
		
		<input type=hidden name="serv_ip" id="serv_ip" value="${bo.serv_ip}">
		<input type=hidden name="serv_name" id="serv_name" value="${bo.serv_name}">
		<input type=hidden name="serv_user" id="serv_user" value="${bo.serv_user}">
		<input type=hidden name="db_type" id="db_type" value="${bo.db_type}">
		<input type=hidden name="db_name" id="db_name" value="${bo.db_name}">
		<input type=hidden name="db_port" id="db_port" value="${bo.db_port}">
		<input type=hidden name="db_user" id="db_user" value="${bo.db_user}">
	<table width="100%" border="0" cellSpacing="2" cellpadding="0" bgcolor="#FFFFFF">
		<tr class="f14 white">
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">数据库IP</td>
          <td width="12%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">主机名</td>
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">主机用户名</td>
          <td width="11%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">源数据库时间</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">数据库名</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">数据库端口</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">数据库用户名</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">导出路径</td>
          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">操作</td>
		</tr>
		<% 

		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		%>
		    <c:forEach items="${rlist }" var="item">
		   		<tr>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.serv_ip }</td>
			   		
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.serv_name }</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
				   		${item.serv_user }
			   		</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.db_type}</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.db_name}</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.db_port}</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.db_user}</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.data_dir}</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
                    <input type="button" class="butwrite" name="edit" style="width:20px;" title="编辑" onclick="editRow('${item.order_id}')"/>
		   		    <input type="button" class="butdelete" name="del" style="width:20px;" title="删除" onclick="showDialog('请确认是否删除?',3,'retT=delRow(\'${item.order_id}\')');"/>  
			   		    
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
function editRow(order_id){
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateDBConn.do?proId=<%=proId%>&opCode=<%=opCode%>&order_id=" + order_id ,"修改数据库连接","800","300");
	parent.refreshByClose();
}
//删除行
function delRow(order_id){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delDBConn.do");
	packet.data.add("order_id" ,order_id);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("连接删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("连接删除失败！"+retMsg,0);
  	}
}

</script>
</html>
