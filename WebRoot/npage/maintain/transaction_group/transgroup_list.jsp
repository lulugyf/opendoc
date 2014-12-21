<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.TransGroupBo" %>
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
			<th>分组名称</th>
			<th>是否默认</th>
			<th>备注</th>
			<th>操作</th>
		</tr>
		<% 
			String dataFuncCode=request.getParameter("dataFuncCode");
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];
		    
		    String hostIp = request.getParameter("hostIp");
		    String groupName = request.getParameter("groupName");
		    
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    
		    TransGroupBo transGroupBo = new TransGroupBo();
		    if(proId!=null && !"".equals(proId))transGroupBo.setProCode(proId);
		    if(provinceCode!=null && !"".equals(provinceCode))transGroupBo.setProvinceCode(provinceCode);
		    if(tellType!=null && !"".equals(tellType))transGroupBo.setTellType(tellType);
		    if(hostIp!=null && !"".equals(hostIp))transGroupBo.setHostIp(hostIp.trim());
		    if(groupName!=null && !"".equals(groupName))transGroupBo.setGroupName(groupName.trim());
		    transGroupBo.setLoginNo(session.getAttribute("loginNo").toString());
		%>
		
		<si:pagelist name="progresslist" id="stransGroup.selectTransGroups" param="<%=transGroupBo %>" scope="end" url="transgroup_list.jsp">
			 <logic:iterate id="show" name="progresslist" indexId="i" type="com.sitech.rom.common.bo.TransGroupBo">    
		   		<tr>
		   			<td><%=StringUtil.safeValue(show.getProName())%></td>
			   		<td><%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())%></td>
			   		<td><%=StringUtil.safeValue(show.getHostIp())%></td>
			   		<td><%=StringUtil.safeValue(show.getGroupName())%></td>
			   		<td><% if(show.getIsdefault()==0){ %>否<% } else{%>是<%} %></td>
			   		<td><%=StringUtil.safeValue(show.getRemarks())%></td>
			   		<td style="width:90px">
						<input type="button" class="butAmed" name="pope" style="display:none" title="关联交易节点" onclick="setTransRelate('<%=StringUtil.safeValue(show.getGroupId())%>','<%=StringUtil.safeValue(show.getHostId())%>','<%=StringUtil.safeValue(show.getGroupName())%>','<%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())+"-"+StringUtil.safeValue(show.getHostIp())%>')"/>
						<input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('<%=StringUtil.safeValue(show.getGroupId())%>')"/>
			   		    <input type="button" class="butDel" name="del" style="display:none" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'<%=StringUtil.safeValue(show.getGroupId())%>\',\'<%=StringUtil.safeValue(show.getGroupName())%>\',\'<%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())+"-"+StringUtil.safeValue(show.getHostIp())%>\')');"/>  
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
        $("input[name='pope']").each(function(){
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
function editRow(groupId){
	var qryPara="groupId="+groupId+"&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode=<%=provinceCode%>&tellType=<%=tellType%>";
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateTransGroup.do?"+qryPara,"修改分组配置","800","400");
	parent.refreshByClose();
}
//删除行
function delRow(groupId,groupName,hostName){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delTransGroup.do");
	packet.data.add("groupId" ,groupId);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=provinceCode%>');
	packet.data.add("tellType" ,'<%=tellType%>');
	packet.data.add("hostName" ,hostName);
	packet.data.add("groupName" ,groupName);
	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("分组删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("分组删除失败！",0);
  	}
}
//设置
function setTransRelate(groupId,hostId,groupName,hostName){
	var qryPara="groupId="+groupId+"&hostId="+hostId+"&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode=<%=provinceCode%>&tellType=<%=tellType%>"+"&dataFuncCode=<%=dataFuncCode%>"+"&groupName="+encodeURI(groupName)+"&hostName="+encodeURI(hostName);
	parent.openDivWin("<%=request.getContextPath()%>/gotoSetTransRelate.do?"+qryPara,"交易节点与分组关系配置","400","400");
}

</script>
</html>
