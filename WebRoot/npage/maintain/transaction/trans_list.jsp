<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.TransactionBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">交易信息列表</div></div>  
<div class="list">
 
	<table id="mTable">
		<tr>
			<th>产品</th>
			<th>省份运营商</th>
			<th>主机IP</th>
			<th>业务功能代码</th>
			<th>业务功能名称</th>
			<th>交易代码</th>
			<th>交易名称</th>
			<th>数据类型</th>
			<th>操作</th>
		</tr>
		<% 
			String dataFuncCode=request.getParameter("dataFuncCode");
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];
		    
		    String hostIp = request.getParameter("hostIp");
		    String busiName = request.getParameter("busiName");
		    String transName = request.getParameter("transName");
		    
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    
		    TransactionBo transactionBo = new TransactionBo();
		    if(proId!=null && !"".equals(proId))transactionBo.setProCode(proId);
		    if(provinceCode!=null && !"".equals(provinceCode))transactionBo.setProvinceCode(provinceCode);
		    if(tellType!=null && !"".equals(tellType))transactionBo.setTellType(tellType);
		    if(hostIp!=null && !"".equals(hostIp))transactionBo.setHostIp(hostIp.trim());
		    if(busiName!=null && !"".equals(busiName))transactionBo.setBusiName(busiName.trim());
		    if(transName!=null && !"".equals(transName))transactionBo.setTransName(transName.trim());
			
		    transactionBo.setLoginNo(session.getAttribute("loginNo").toString());
		    transactionBo.setFuncCode(dataFuncCode);
		    	     
		%>
		<si:pagelist name="progresslist" id="stransaction.selectTransactions" param="<%=transactionBo %>" scope="end" url="trans_list.jsp">
			 <logic:iterate id="show" name="progresslist" indexId="i" type="com.sitech.rom.common.bo.TransactionBo">    
		   		<tr>
		   			<td><%=StringUtil.safeValue(show.getProName())%></td>
			   		<td><%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())%></td>
			   		<td><%=StringUtil.safeValue(show.getHostIp())%></td>
			   		<td><%=StringUtil.safeValue(show.getBusiCode())%></td>
			   		<td><%=StringUtil.safeValue(show.getBusiName())%></td>
			   		<td><%=StringUtil.safeValue(show.getTransCode())%></td>
			   		<td><%=StringUtil.safeValue(show.getTransName())%></td>
			   		<td><% if(show.getIsOwn()==0){
			   				   out.print("自建");
			   			   }else{
			   			   	   out.print(show.getLoginNo()+"共享");
			   			   } %>
			   		</td>
			   		<td>
						<% if(show.getIsOwn()==0){ %>
							<input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('<%=StringUtil.safeValue(show.getTransId())%>','<%=StringUtil.safeValue(show.getItemId())%>','<%=dataFuncCode %>')"/>
			   		    	<input type="button" class="butDel" name="del" style="display:none" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'<%=StringUtil.safeValue(show.getTransId())%>\',\'<%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())+"-"+StringUtil.safeValue(show.getHostIp())%>\',\'<%=StringUtil.safeValue(show.getBusiCode())%>\',\'<%=StringUtil.safeValue(show.getTransCode())%>\')');"/>  
						<% } %>
					</td>
		   		</tr>
		   	 </logic:iterate>  
	    </si:pagelist>
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
function editRow(transId,itemId,dataFuncCode){
	var qryPara="transId="+transId+"&itemId="+itemId+"&dataFuncCode="+dataFuncCode+"&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode=<%=provinceCode%>&tellType=<%=tellType%>";
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateTransaction.do?"+qryPara,"修改业务配置","800","200");
	parent.refreshByClose();
}
//删除行
function delRow(transId,hostName,busiCode,transCode){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delTransaction.do");
	packet.data.add("transId" ,transId);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=provinceCode%>');
	packet.data.add("tellType" ,'<%=tellType%>');
	packet.data.add("hostName" ,hostName);
	packet.data.add("busiCode" ,busiCode);
	packet.data.add("transCode" ,transCode);
	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("交易节点删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("交易节点删除失败！",0);
  	}
}

</script>
</html>
