<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.common.dto.RomProCode" %>
<%@ page import="com.sitech.rom.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">产品列表</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>产品代码</th>
			<th>产品名称</th>
			<th>产品版本</th>
			<th>备注</th>
			<th>操作</th>
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
			   		<td>${item.proCode}</td>    
			   		<td>${item.proName }</td>	
			   		<td>${item.proVersion }</td>
			   		<td>${item.remarks }</td>								   		      
			   		<td>
			   		    <input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('${item.proCode }')"/>    
			   		    <input type="button" class="butDel" name="del" style="display:none" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'${item.proCode }\')');"/>
			   		    <input type="button" class="butAmed" name="set" style="display:none" title="功能设置" onclick="setRow('${item.proCode }')"/>
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
