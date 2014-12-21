<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.FtpScriptBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">FTP脚本列表</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>产品</th>
			<th>省份运营商</th>
			<th>主机IP</th>
			<th>工单名称</th>
			<th>动作名称</th>
			<th>脚本目录</th>
			<th>脚本名称</th>
			<th>请求URL</th>
			<th>操作</th>
		</tr>
		<% 
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];
		    String hostIp = request.getParameter("hostIp").trim();
		    
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    
		    FtpScriptBo ftpScriptBo = new FtpScriptBo();
		    if(proId!=null && !"".equals(proId))ftpScriptBo.setProCode(proId);
		    if(provinceCode!=null && !"".equals(provinceCode))ftpScriptBo.setProvinceCode(provinceCode);
		    if(tellType!=null && !"".equals(tellType))ftpScriptBo.setTellType(tellType);
		    if(hostIp!=null && !"".equals(hostIp))ftpScriptBo.setHostIp(hostIp);	     
		%>
		<si:pagelist name="progresslist" id="sftpScript.qryFtpScriptInfo" param="<%=ftpScriptBo %>" scope="end" url="ftpScript_list.jsp">
			 <logic:iterate id="show" name="progresslist" indexId="i" type="com.sitech.rom.common.bo.FtpScriptBo">    
		   		<tr>
		   			<td><%=StringUtil.safeValue(show.getProName())%></td>
			   		<td><%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())%></td>
			   		<td><%=StringUtil.safeValue(show.getHostIp())%></td>
			   		<td><%=StringUtil.safeValue(show.getSiteName())%></td>
					<td><%=StringUtil.safeValue(show.getActionName())%></td>				   		      
			   		<td><%=StringUtil.safeValue(show.getScriptsDir())%></td>
			   		<td><%=StringUtil.safeValue(show.getScriptsName())%></td>
			   		<td><%=StringUtil.safeValue(show.getReqUrl())%></td>
			   		<td>
			   		   	<input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('<%=StringUtil.safeValue(show.getSiteId())%>','<%=StringUtil.safeValue(show.getActionId())%>','<%=StringUtil.safeValue(show.getScriptsId())%>')"/>
			   		    <input type="button" class="butDel" name="del" style="display:none" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'<%=StringUtil.safeValue(show.getSiteId())%>\',\'<%=StringUtil.safeValue(show.getActionId())%>\',\'<%=StringUtil.safeValue(show.getScriptsId())%>\',\'<%=StringUtil.safeValue(show.getSiteName())%>\',\'<%=StringUtil.safeValue(show.getActionName())%>\')')"/>  
 
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
function editRow(siteId,actionId,scriptsId){
	var qrystr="siteId="+siteId+"&actionId="+actionId+"&scriptsId="+scriptsId+
		"&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode=<%=provinceCode%>&tellType=<%=tellType%>";	
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateFtpScript.do?"+qrystr,"修改工单信息","800","400");
	parent.refreshByClose();
}
//删除行
function delRow(siteId,actionId,scriptsId,siteName,actionName){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delFtpScript.do");
	packet.data.add("siteId" ,siteId);
	packet.data.add("actionId" ,actionId);
	packet.data.add("scriptsId" ,scriptsId);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=provinceCode%>');
	packet.data.add("tellType" ,'<%=tellType%>');
	packet.data.add("siteName" ,siteName);
	packet.data.add("actionName" ,actionName);
	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("FTP脚本删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("FTP脚本删除失败！",0);
  	}
}

</script>
</html>
