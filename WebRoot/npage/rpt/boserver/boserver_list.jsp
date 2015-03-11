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
    <form name="listFrm" method="post" action="boserverList.do">
    	<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="pageNum" id="pageNum" value="">
		
		<input type=hidden name="boname" id="boname" value="${bo.boname}">
		<input type=hidden name="authaddr" id="authaddr" value="${bo.authaddr}">
		<input type=hidden name="username" id="username" value="${bo.username}">
		<input type=hidden name="opendocaddr" id="opendocaddr" value="${bo.opendocaddr}">
	<table width="100%" border="0" cellSpacing="2" cellpadding="0" bgcolor="#FFFFFF">
		<tr class="f14 white">
	          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">名称</td>
	          <td width="12%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">验证服务地址</td>
	          <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">用户名</td>
	          <td width="11%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">文档服务地址</td>
	          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">备注</td>
	          <td width="9%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">操作</td>
		</tr>
		<% 

		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		%>
		    <c:forEach items="${list }" var="item">
		   		<tr>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.boname }</td>
			   		
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.authaddr }</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
				   		${item.username }
			   		</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.opendocaddr}</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.remarks}</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
                    <input type="button" class="butwrite" name="edit" style="width:20px;" title="编辑" onclick="editRow('${item.boid}')"/>
		   		    <input type="button" class="butdelete" name="del" style="width:20px;" title="删除" onclick="showDialog('请确认是否删除?',3,'retT=delRow(\'${item.boid}\')');"/>  
			   		    
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
function editRow(boid){
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateBOServer.do?proId=<%=proId%>&opCode=<%=opCode%>&boid=" + boid ,"修改BO服务配置","800","300");
	parent.refreshByClose();
}
//删除行
function delRow(boid){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delBOServer.do");
	packet.data.add("boid" ,boid);
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
