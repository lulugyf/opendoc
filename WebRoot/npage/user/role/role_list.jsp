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
<div class="title"> <div class="text">角色列表</div></div>  
<div class="list11">
	<table id="mTable1">
		<tr>
			<th>角色名称</th>
			<th>角色类别</th>
			<th>是否有效</th>
			<!--  <th>省份</th>
			<th>运营商类型</th>-->
			<th>所属产品</th>
			<th>操作</th>
		</tr>
		<% 

		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    String pope = request.getParameter("pope");
		    		    

		    //<si:pagelist name="rolelist" id="srole.qryRomRoleInfo" param="<%=romSysRole --" scope="end" url="role_list.jsp">
			 // <logic:iterate id="show" name="rolelist" indexId="i" type="com.sitech.rom.common.bo.RoleBo">
		    //</logic:iterate>  
	    //</si:pagelist>
		%>
		    <c:forEach items="${roleList }" var="show">
		   		<tr>
			   		<td>${show.roleName }</td>
			   		
			   		<td><c:choose>
			   		 <c:when test="${show.roleType == 1 }">普通管理员</c:when>
			   		 <c:otherwise >  超级管理员</c:otherwise>
			   		 </c:choose></td>
			   		<td>
				   		<c:choose>
				   		 <c:when test="${show.roleState == 1}">无效</c:when>
				   		 <c:otherwise>有效</c:otherwise>
				   		</c:choose>
			   		</td>
			   		<!--  <td>${show.provinceName}</td>
			   		<td>${show.tellcorpName}</td> -->
			   		<td>${show.proName}</td>
			   		<td>
			   		   <c:choose>
			   		    <c:when test="${show.roleState == 0 }">
			   		    <input type="button" class="butAmed" name="pope" style="display:none" title="权限设置" onclick="setPopedom('${show.roleId}','${show.roleName}')"/>
			   		    <input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('${show.roleId}')"/>
			   		    <input type="button" class="butDel" name="del" style="display:none" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'${show.roleId}\',\'${show.roleName}\',\'${show.roleName}\')');"/>  
			   		    </c:when>
			   		    <c:otherwise>
			   		    
			   		    <input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('${show.roleId}')"/>
			   		    </c:otherwise></c:choose>
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
    if('<%=pope%>'=='Y'){
        $("input[name='pope']").each(function(){
            $(this).css('display','');
        })
    }
    parent.unLoading('ajaxLoadingDiv');
});
//权限设置
function setPopedom(roleId,roleName){
    parent.openDivWin("<%=request.getContextPath()%>/gotoSetPopedom.do?proId=<%=proId%>&opCode=<%=opCode%>&roleId="+roleId+"&roleName="+encodeURI(roleName),"权限设置","600","350");
}
//编辑当前行内容
function editRow(roleId){
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateRole.do?proId=<%=proId%>&opCode=<%=opCode%>&roleId="+roleId,"修改角色","800","300");
	parent.refreshByClose();
}
//删除行
function delRow(roleId,roleName,proName){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delRole.do");
	packet.data.add("roleId" ,roleId);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("roleName" ,roleName);
	packet.data.add("proName" ,proName);
	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("角色删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("角色删除失败！",0);
  	}
}

</script>
</html>
