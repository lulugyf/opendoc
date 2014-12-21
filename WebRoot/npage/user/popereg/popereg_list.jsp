<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.common.bo.PoperegBo" %>
<%@ page import="com.sitech.rom.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">功能注册信息列表</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>功能链接</th>
			<th>所属功能</th>
			<th>对应操作项</th>
			<th>操作</th>
		</tr>
		<% 
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    
 
		%>
		<c:forEach items="${popereglist }" var="show">    
	   		<tr>
		   		<td>${show.actionName }</td>
		   		<td>${show.functionName} ${show.functionCode}</td>
		   		<td>${show.operationName }
		   		</td>
		   		<td>
		   			<input type="button" name="edit" style="display:none" class="butCha" title="编辑" onclick="editRow('${show.actionName}','${show.functionCode}')"/>
		   		    <input type="button" name="del" style="display:none" class="butDel" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'${show.actionName}\',\'${show.functionCode}\',\'${show.functionName}\')');"/>  
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
