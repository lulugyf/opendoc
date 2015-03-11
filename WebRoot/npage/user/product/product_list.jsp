<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.common.dto.RomProCode" %>
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
    <form name="listFrm" method="post" action="productList.do">
    	<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="pageNum" id="pageNum" value="">
		
		<input type=hidden name="proCode" id="proCode" value="${bo.proCode}">
		<input type=hidden name="proName" id="proName" value="${bo.proName}">
	<table id="mTable" width="100%" border="0" cellSpacing="2" cellpadding="0" bgcolor="#FFFFFF">
		<tr class="f14 white">
	        <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">产品代码</td>
	        <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">产品名称</td>
	        <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">产品版本</td>
	        <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">备注</td>
	        <td width="8%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">操作</td>
		</tr>
		<% 
		    String proCode = request.getParameter("proCode").trim();
		    String proName = request.getParameter("proName").trim();
			
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    
		    RomProCode qryobj = new RomProCode();
		    if(proCode!=null && !"".equals(proCode))qryobj.setProCode(proCode);
		    if(proName!=null && !"".equals(proName))qryobj.setProName(proName);
			
			//<si:pagelist name="productlist" id="sproduct.selectRomProCode" param="<%=qryobj -->" scope="end" url="product_list.jsp">
	    //</si:pagelist>
	    //<logic:iterate id="show" name="productlist" indexId="i" type="com.sitech.rom.common.dto.RomProCode">
	    //</logic:iterate>  
		%>
			     
		   		<c:forEach var="item" items="${productList}">
		   		<tr>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.proCode}</td>    
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.proName }</td>	
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.proVersion }</td>
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">${item.remarks }</td>								   		      
			   		<td height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
			   		    <input type="button" class="butright" name="set" title="功能设置" onclick="setRow('${item.proCode }')"/>
			   		    <input type="button" class="butwrite" name="edit" title="编辑" onclick="editRow('${item.proCode }')"/>    
			   		    <input type="button" class="butdelete" name="del" title="删除" onclick="showDialog('请确认是否删除?',3,'retT=delRow(\'${item.proCode }\')');"/>
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
function editRow(productCode){
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateProduct.do?proId=<%=proId%>&opCode=<%=opCode%>&productCode="+productCode,"修改产品","800","200");
	parent.refreshByClose();
}
//删除行
function delRow(productCode,proName,proVersion){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delProduct.do");
	packet.data.add("productCode" ,productCode);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("proName" ,proName);
	packet.data.add("proVersion" ,proVersion);
	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("产品删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else {
  	    parent.parent.showDialog("产品删除失败！",0);
  	}
}
 
function setRow(productCode){
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateProductFunc.do?proId=<%=proId%>&opCode=<%=opCode%>&productCode="+productCode,"修改产品功能关系","800","500");
	parent.refreshByClose();
}
</script>
</html>
