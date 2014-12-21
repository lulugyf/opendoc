<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.WorkOrderBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">工单列表</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>产品</th>
			<th>省份运营商</th>
			<th>主机IP</th>
			<th>业务功能代码</th>
			<th>动作名称</th>
			<th>脚本目录</th>
			<th>脚本名称</th>
			<th>脚本类型</th>
			<th>请求URL</th>
			<th>数据类型</th>
			<th>操作</th>
		</tr>
		<% 
			String dataFuncCode=request.getParameter("dataFuncCode");
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];
		    String hostIp = request.getParameter("hostIp").trim();
		    
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    String runstop = request.getParameter("runstop");
		    
		    WorkOrderBo progressBo = new WorkOrderBo();
		    if(proId!=null && !"".equals(proId))progressBo.setProId(proId);
		    if(provinceCode!=null && !"".equals(provinceCode))progressBo.setProvinceCode(provinceCode);
		    if(tellType!=null && !"".equals(tellType))progressBo.setTellType(tellType);
		    if(hostIp!=null && !"".equals(hostIp))progressBo.setHostIp(hostIp);
 
		    String loginNo=session.getAttribute("loginNo").toString();
		    progressBo.setLoginNo(loginNo);
		    progressBo.setFuncCode(dataFuncCode);
		    
		%>
		<si:pagelist name="progresslist" id="sworkorderScript.qryWorkOrderInfo" param="<%=progressBo %>" scope="end" url="businessScript_list.jsp">
			 <logic:iterate id="show" name="progresslist" indexId="i" type="com.sitech.rom.common.bo.WorkOrderBo">    
		   		<tr>
		   			<td><%=StringUtil.safeValue(show.getProName())%></td>
			   		<td><%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())%></td>
			   		<td><%=StringUtil.safeValue(show.getHostIp())%></td>
			   		<td><%=StringUtil.safeValue(show.getItemName())%></td>
					<td><%=StringUtil.safeValue(show.getActionName())%></td>				   		      
			   		<td><%=StringUtil.safeValue(show.getScriptsDir())%></td>
			   		<td><%=StringUtil.safeValue(show.getScriptsName())%></td>
			   		<td><%if("0".equals(StringUtil.safeValue(show.getScriptsType()))){
			   		          out.print("定时执行的脚本");
			   		      }else if("1".equals(StringUtil.safeValue(show.getScriptsType()))){
			   		          out.print("手工执行的脚本");
			   		      }%></td>			   		
			   		<td><%=StringUtil.safeValue(show.getReqUrl())%></td>
			   		<td><% if(show.getIsOwn()==0){
			   				   out.print("自建");
			   			   }else{
			   			   	   out.print(show.getLoginNo()+"共享");
			   			   } %>
			   		</td>
			   		<td>
			   		    <A class="btn_begin" name="run" style="display:none" title="执行" onclick="runScript('<%=StringUtil.safeValue(show.getScriptsType())%>','<%=StringUtil.safeValue(show.getScriptsId())%>','<%=StringUtil.safeValue(show.getTaskId())%>','<%=StringUtil.safeValue(show.getItemName())%>','<%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())+"-"+StringUtil.safeValue(show.getHostIp())%>')"><SPAN></SPAN></A>
			   		    <%if("0".equals(StringUtil.safeValue(show.getScriptsType()))){%>
			   		    <A class="btn_cancel" name="stop" style="display:none" title="停止" onclick="stopScript('<%=StringUtil.safeValue(show.getScriptsType())%>','<%=StringUtil.safeValue(show.getScriptsId())%>','<%=StringUtil.safeValue(show.getTaskId())%>','<%=StringUtil.safeValue(show.getItemName())%>','<%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())+"-"+StringUtil.safeValue(show.getHostIp())%>')"><SPAN></SPAN></A>	
			   		    <%}%>
			   		    <% if(show.getIsOwn()==0){ %>
							<input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('<%=StringUtil.safeValue(show.getItemId())%>','<%=StringUtil.safeValue(show.getActionId())%>','<%=StringUtil.safeValue(show.getScriptsId())%>')"/>
			   		    	<input type="button" class="butDel" name="del" style="display:none" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'<%=StringUtil.safeValue(show.getItemId())%>\',\'<%=StringUtil.safeValue(show.getActionId())%>\',\'<%=StringUtil.safeValue(show.getScriptsId())%>\',\'<%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())+"-"+StringUtil.safeValue(show.getHostIp())%>\',\'<%=StringUtil.safeValue(show.getItemName())%>\',\'<%=StringUtil.safeValue(show.getActionName())%>\')')"/>  
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
    if('<%=runstop%>'=='Y'){
        $("a[name='run']").each(function(){
            $(this).css('display','');
        })
        $("a[name='stop']").each(function(){
            $(this).css('display','');
        })        
    }
   parent.unLoading('ajaxLoadingDiv');
});
//编辑当前行内容
function editRow(itemId,actionId,scriptsId){
	var qrystr="itemId="+itemId+"&actionId="+actionId+"&scriptsId="+scriptsId+
		"&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode=<%=provinceCode%>&tellType=<%=tellType%>";	
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateBusinessScript.do?"+qrystr,"修改业务信息","800","300");
	parent.refreshByClose();
}
//删除行
function delRow(itemId,actionId,scriptsId,hostName,itemName,actionName){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delBusinessScript.do");
	packet.data.add("itemId" ,itemId);
	packet.data.add("actionId" ,actionId);
	packet.data.add("scriptsId" ,scriptsId);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=provinceCode%>');
	packet.data.add("tellType" ,'<%=tellType%>');
	packet.data.add("hostName" ,hostName);
	packet.data.add("itemName" ,itemName);
	packet.data.add("actionName" ,actionName);
	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("业务删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("业务删除失败！",0);
  	}
}

function runScript(scriptsType,scriptsId,taskId,busiId,hostName){

	if(scriptsType=="0"){//定时执行的脚本
		var packet = new AJAXPacket("<%=request.getContextPath()%>/exceBusinessScriptByAuto.do");
		packet.data.add("scriptsId" ,scriptsId);
		packet.data.add("taskId" ,taskId);
		packet.data.add("busiId" ,busiId);
		packet.data.add("proId" ,"<%=proId%>");
		packet.data.add("opCode" ,"<%=opCode%>");
		packet.data.add("provinceCode" ,'<%=provinceCode%>');
		packet.data.add("tellType" ,'<%=tellType%>');
		packet.data.add("hostName" ,hostName);

		core.ajax.sendPacket(packet,doScriptsRunRow);
		packet =null;
	}else{//手工执行的脚本
		var qryPara="proId=<%=proId%>&opCode=<%=opCode%>&scriptsId="+scriptsId+"&busiId="+busiId+"&provinceCode=<%=provinceCode%>&tellType=<%=tellType%>&hostName="+encodeURI(hostName);
		parent.openDivWin("<%=request.getContextPath()%>/exceBusinessScriptByManual.do?"+qryPara,"执行业务","800","300");
		parent.refreshByClose();	
	}

}


function doScriptsRunRow(packet){
	var showtext="";
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=='0'){
		showtext=packet.data.findValueByName("retMsg");
		showtext=decodeURI(showtext);
		parent.parent.showDialog(showtext,2);
	}else{
		if(retCode=='noright'){
			showtext="您没有权限进行此操作！";	
			parent.parent.showDialog(showtext,0);		
		}else{
			showtext=packet.data.findValueByName("retMsg");
			showtext=decodeURI(showtext);
			parent.parent.showDialog(showtext,0);
		}
	}
 
}

//停止脚本
function stopScript(scriptsType,scriptsId,taskId,busiId,hostName){
		var packet = new AJAXPacket("<%=request.getContextPath()%>/stopBusinessScriptByAuto.do");
		packet.data.add("scriptsId" ,scriptsId);
		packet.data.add("taskId" ,taskId);
		packet.data.add("busiId" ,busiId);
		packet.data.add("proId" ,"<%=proId%>");
		packet.data.add("opCode" ,"<%=opCode%>");
		packet.data.add("provinceCode" ,'<%=provinceCode%>');
		packet.data.add("tellType" ,'<%=tellType%>');
		packet.data.add("hostName" ,hostName);

		core.ajax.sendPacket(packet,doStopScriptsRow);
		packet =null;

}

function doStopScriptsRow(packet){
	var showtext="";
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=='0'){
		showtext=packet.data.findValueByName("retMsg");
		showtext=decodeURI(showtext);
		parent.parent.showDialog(showtext,2);
	}else{
		if(retCode=='noright'){
			showtext="您没有权限进行此操作！";	
			parent.parent.showDialog(showtext,0);		
		}else{
			showtext=packet.data.findValueByName("retMsg");
			showtext=decodeURI(showtext);
			parent.parent.showDialog(showtext,0);
		}
	}
 
}

</script>
</html>
