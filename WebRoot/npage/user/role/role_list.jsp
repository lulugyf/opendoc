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
<div id="operation" class="pz_cont_wiap100 fr">
    <div class="blankH12"></div>
    <div class="pz_cont_main">
    <form name="listFrm" method="post" action="roleList.do">
    	<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="pageNum" id="pageNum" value="">
		
		<input type=hidden name="proCode" id="proCode" value="${bo.proCode}">
	<table id="mTable1" width="100%" border="0" cellSpacing="2" cellpadding="0" bgcolor="#FFFFFF">
		<tr class="f14 white">
          <td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">角色名称</td>
          <td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">角色类别</td>
          <td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">是否有效</td>
          <td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">所属产品</td>
          <td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">操作</td>
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
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${show.roleName }</td>
			   		
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;"><c:choose>
			   		 <c:when test="${show.roleType == 1 }">普通管理员</c:when>
			   		 <c:otherwise >  超级管理员</c:otherwise>
			   		 </c:choose></td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
				   		<c:choose>
				   		 <c:when test="${show.roleState == 1}">无效</c:when>
				   		 <c:otherwise>有效</c:otherwise>
				   		</c:choose>
			   		</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${show.proName}</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
			   		   <c:choose>
			   		    <c:when test="${show.roleState == 0 }">
			   		    <input type="button" class="butright" name="pope" style="width:20px;" title="权限设置" onclick="setPopedom('${show.roleId}','${show.roleName}')"/>
			   		    <input type="button" class="butwrite" name="edit" style="width:20px;" title="编辑" onclick="editRow('${show.roleId}')"/>
			   		    <input type="button" class="butdelete" name="del" style="width:20px;" title="删除" onclick="showDialog('请确认是否删除?',3,'retT=delRow(\'${show.roleId}\',\'${show.roleName}\',\'${show.roleName}\')');"/>  
			   		    </c:when>
			   		    <c:otherwise>
			   		    
			   		    <input type="button" class="butwrite" name="edit" style="width:20px;" title="编辑" onclick="editRow('${show.roleId}')"/>
			   		    </c:otherwise></c:choose>
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
