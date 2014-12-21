<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.HostCheckItemBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">日常运维检查项目</div></div>  
<div class="list">
	<table id="mTable">
		<tr>	
			<th width="8%">省份运营商</th>
			<th width="8%">日检分类</th>
			<th width="3%">日检项ID</th>
			<th width="14%">日检项名称</th>
			<th width="21%">日检子项名称</th>	
			<th width="14%">KPI编码</th>	
			<th width="8%">巡检周期</th>		
			<th width="16%">备注</th>	
			<th width="8%">操作</th>
		</tr>
		<% 
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];
		    String proCode= request.getParameter("proCode").trim();
		    String kpiId= request.getParameter("kpiId").trim();
		    
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    
		    HostCheckItemBo hostCheckItemBo = new HostCheckItemBo();
		    //if(proCode!=null && !"".equals(proCode)) hostCheckItemBo.setProCode(proCode);
		    if(proCode!=null) hostCheckItemBo.setProCode(proCode);
		    if(provinceCode!=null && !"".equals(provinceCode)) hostCheckItemBo.setProvinceCode(provinceCode);
		    if(tellType!=null && !"".equals(tellType)) hostCheckItemBo.setTellType(tellType); 	
		    if(kpiId!=null && !"".equals(kpiId)) hostCheckItemBo.setKpiId(kpiId); 		
		    
		%>
		<si:pagelist name="hostCheckItemList" id="RomHostCheckItem.qryHostCheckItem" param="<%=hostCheckItemBo %>" scope="end" url="hostCheckItem_list.jsp">
			 <logic:iterate id="show" name="hostCheckItemList" indexId="i" type="com.sitech.rom.common.bo.HostCheckItemBo">    
		   		<tr>
			   		<td><%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())%></td>		
			   		<td><%=StringUtil.safeValue(show.getProCode())%></td>
			   		<td align="center"><%=StringUtil.printLong(show.getSeqId())%></td>
			   		<td><%=StringUtil.safeValue(show.getFatherSection())%></td>
			   		<td><%=StringUtil.safeValue(show.getChildSection())%></td>
			   		<td><%=StringUtil.safeValue(show.getKpiId())%></td>
			   		<td><%=StringUtil.safeValue(show.getCheckCycle())%></td>
			   		<td><%=StringUtil.safeValue(show.getRemark())%></td>			   		
			   		<td>
			   		   <input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('<%=StringUtil.safeValue(show.getSeqId())%>')"/>
			   		   <input type="button" class="butDel" name="del"  style="display:none" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'<%=StringUtil.safeValue(show.getSeqId())%>\')');"/> 
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
 
<script language="javascript" type="text/javascript" >
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
function editRow(seqId){
    var qryPara="seqId="+seqId+"&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode=<%=provinceCode%>&tellType=<%=tellType%>";
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateHostCheckItem.do?"+qryPara,"修改日检项目","800","300");
	parent.refreshByClose();
}
//删除行
function delRow(seqId){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delHostChekcItem.do");
	packet.data.add("seqId" ,seqId);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=provinceCode%>');
	packet.data.add("tellType" ,'<%=tellType%>');
	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}

function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("日检项目删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("日检项目删除失败！",0);
  	}
}
</script>
</html>
