<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.dto.RomSysLogin" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">工号列表</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>工号</th>
			<th>姓名</th>
			<th>使用标识</th>
			<th>联系号码</th>
			<th>操作</th>
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
			   		<td>${show.loginNo }</td>
			   		<td>${show.loginName }</td>
			   		<td><c:choose><c:when test="${show.useFlg == 0 }">有效</c:when>
			   		<c:otherwise>无效</c:otherwise>
			   		</c:choose>
			   		</td>
			   		<td>${show.phoneNo }</td>
			   		<td>
			   			<input type="button" class="butAmed" name="set" style="display:none" title="角色设置" onclick="setLoginRole('${show.loginNo}')"/>
			   			<input type="button" name="edit" style="display:none" class="butCha" title="编辑" onclick="editRow('${show.loginNo}')"/>
			   		    <c:if test="${show.useFlg == 0 }">
			   		    <input type="button" name="del" style="display:none" class="butDel" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'${show.loginNo}\')');"/>  
			   		    </c:if>
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
