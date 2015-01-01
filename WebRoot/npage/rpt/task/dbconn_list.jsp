﻿<%@ page contentType="text/html;charset=UTF-8" %>
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
<div class="title"> <div class="text">数据源配置列表</div></div>  
<div class="list11">
	<table id="mTable1">
		<tr>
			<th>数据库IP</th>
			<th>主机名</th>
			<th>主机用户名</th>
			<th>源数据库类型</th>
			<th>数据库名</th>
			<th>数据库端口</th>
			<th>数据库用户名</th>
			<th>导出路径</th>
			<th>操作</th>
		</tr>
		<% 

		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		%>
		    <c:forEach items="${rlist }" var="item">
		   		<tr>
			   		<td>${item.serv_ip }</td>
			   		
			   		<td>${item.serv_name }</td>
			   		<td>
				   		${item.serv_user }
			   		</td>
			   		<td>${item.db_type}</td>
			   		<td>${item.db_name}</td>
			   		<td>${item.db_port}</td>
			   		<td>${item.db_user}</td>
			   		<td>${item.data_dir}</td>
			   		<td>
			   		   
		   		    <input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('${item.order_id}')"/>
		   		    <input type="button" class="butDel" name="del" style="display:none" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'${item.order_id}\')');"/>  
			   		    
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
