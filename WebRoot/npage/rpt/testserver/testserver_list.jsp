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
<div class="title"> <div class="text">数据源配置列表</div></div>  
<div class="list11">
	<table id="mTable1">
		<tr>
			<th>序列</th>
			<th>地址</th>
			<th>服务名</th>
			<th>用户名</th>
			<th>操作</th>
		</tr>
		<% 

		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		%>
		    <c:forEach items="${list }" var="item">
		   		<tr>
			   		<td>${item.order_id }</td>
			   		
			   		<td>${item.serv_ip }</td>
			   		<td>
				   		${item.serv_name }
			   		</td>
			   		<td>${item.serv_user}</td>
			   		<td>
			   		   
		   		    <input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('${item.order_id}')"/>
		   		    <input type="button" class="butDel" name="del" style="display:none" title="删除" onclick="showDialog('请确认是否删除?',3,'retT=delRow(\'${item.order_id}\')');"/>  
			   		    
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
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateTESTServer.do?proId=<%=proId%>&opCode=<%=opCode%>&order_id=" + order_id ,"修改BO服务配置","800","300");
	//alert("<%=request.getContextPath()%>/gotoUpdateTESTServer.do?proId=<%=proId%>&opCode=<%=opCode%>&order_id=" + order_id);
	parent.refreshByClose();
}
//删除行
function delRow(order_id){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/deleteTESTServer.do");
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
  	    parent.parent.showDialog("删除配置成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("配置删除失败！"+retMsg,0);
  	}
}

</script>
</html>
