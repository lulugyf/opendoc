<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.dto.RomSysLogin" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <form name="listFrm" method="post" action="loginList.do">
    	<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="pageNum" id="pageNum" value="">
		
		<input type=hidden name="loginNo" id="loginNo" value="${bo.loginNo}">
		<input type=hidden name="loginName" id="loginName" value="${bo.loginName}">
		<input type=hidden name="useFlg" id="useFlg" value="${bo.useFlg}">
	<table id="mTable" width="100%" border="0" cellSpacing="2" cellpadding="0" bgcolor="#FFFFFF">
		<tr class="f14 white">
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">工号</td>
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">姓名</td>
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">使用标识</td>
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">联系号码</td>
          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">操作</td>
		</tr>
		<% 

		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    //<si:pagelist name="loginlist" id="RomSysLogin.selectRomSysLogin" param="<%=romSysLogin --" scope="end" url="login_list.jsp">
			 //<logic:iterate id="show" name="loginlist" indexId="i" type="RomSysLogin">
		//</logic:iterate>  
	    //</si:pagelist>
		%>
		    <c:forEach items="${loginlist }" var="show">
		   		<tr>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${show.loginNo }</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${show.loginName }</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;"><c:choose><c:when test="${show.useFlg == 0 }">有效</c:when>
			   		<c:otherwise>无效</c:otherwise>
			   		</c:choose>
			   		</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${show.phoneNo }</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
			   			<input type="button" class="butright" name="set" style="display:none" title="角色设置" onclick="setLoginRole('${show.loginNo}')"/>
			   			<input type="button" name="edit" class="butwrite" title="编辑" onclick="editRow('${show.loginNo}')"/>
			   		    <c:if test="${show.useFlg == 0 }">
			   		    <input type="button" name="del" class="butdelete" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'${show.loginNo}\')');"/>  
			   		    </c:if>
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
        $("input[name='set']").each(function(){ 
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
function editRow(loginNo){
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateLogin.do?proId=<%=proId%>&opCode=<%=opCode%>&loginNo="+loginNo,"修改工号","800","300");
	parent.refreshByClose();
}
//删除行
function delRow(loginNo){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delLogin.do");
	packet.data.add("loginNo" ,loginNo);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("工号删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("工号删除失败！",0);
  	}
}

function setLoginRole(loginNo){
	parent.openDivWin("<%=request.getContextPath()%>/gotoSetLoginRole.do?proId=<%=proId%>&opCode=<%=opCode%>&loginNo="+loginNo,"设置工号角色关系","800","300");
	parent.refreshByClose();
}
</script>
</html>
