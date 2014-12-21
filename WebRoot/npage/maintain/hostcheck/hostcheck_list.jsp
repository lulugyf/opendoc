<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.HostCheckBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="list">
 
	<table id="mTable">
		<tr>
			<th>省份运营商</th>
			<th>主机环境</th>
			<th>主机名称</th>
			<th>主机IP</th>
			<th>主机操作系统</th>
			<th>操作</th>
		</tr>
		<% 
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    String runstop = request.getParameter("runstop");
		    
		    HostCheckBo hostCheckBo = new HostCheckBo();
		    String loginNo=session.getAttribute("loginNo").toString();
		    hostCheckBo.setLoginNo(loginNo);
		    hostCheckBo.setFuncCode(opCode);
		    	     
		%>
		<si:pagelist name="hostchecklist" id="shostcheck.qryHostsByLoginNo" param="<%=hostCheckBo %>" scope="end" url="hostcheck_list.jsp">
			 <logic:iterate id="show" name="hostchecklist" indexId="i" type="HostCheckBo">    
		   		<tr>
			   		<td><%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())%></td>
			   		<td><%if("0".equals(StringUtil.safeValue(show.getHostEnv()))){
			   		          out.print("测试环境");
			   		      }else if("1".equals(StringUtil.safeValue(show.getHostEnv()))){
			   		          out.print("生产环境");
			   		      }else if("2".equals(StringUtil.safeValue(show.getHostEnv()))){
			   		          out.print("开发环境");
			   		      }%></td>
			   		<td><%=StringUtil.safeValue(show.getHostName())%></td>
			   		<td><%=StringUtil.safeValue(show.getHostIp())%></td>
			   		<td><%if("0".equals(StringUtil.safeValue(show.getHostOs()))){
			   		          out.print("aix");
			   		      }else if("1".equals(StringUtil.safeValue(show.getHostOs()))){
			   		          out.print("hp");
			   		      }else if("2".equals(StringUtil.safeValue(show.getHostOs()))){
			   		          out.print("sun");
			   		      }else if("3".equals(StringUtil.safeValue(show.getHostOs()))){
			   		          out.print("linux");
			   		      }else if("4".equals(StringUtil.safeValue(show.getHostOs()))){
			   		          out.print("其他");
			   		      }%></td>
			   		<td>
						<input type="button" class="b_foot" value="编辑脚本" onclick="setScript('<%=StringUtil.safeValue(show.getItemId())%>','<%=StringUtil.safeValue(show.getScriptId())%>','<%=StringUtil.safeValue(show.getHostId())%>','<%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())+"-"+StringUtil.safeValue(show.getHostIp())%>')" />
						
						<%if(!"".equals(StringUtil.safeValue(show.getScriptId()))){%>
							<input type="button" class="b_foot" value="执行" onclick="runScript('<%=StringUtil.safeValue(show.getScriptType())%>','<%=StringUtil.safeValue(show.getScriptId())%>','<%=StringUtil.safeValue(show.getTaskId())%>','<%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())+"-"+StringUtil.safeValue(show.getHostIp())%>')" />
						<%if("0".equals(StringUtil.safeValue(show.getScriptType()))){%>
				   		    <input type="button" class="b_foot" value="停止" onclick="stopScript('<%=StringUtil.safeValue(show.getScriptType())%>','<%=StringUtil.safeValue(show.getScriptId())%>','<%=StringUtil.safeValue(show.getTaskId())%>','<%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())+"-"+StringUtil.safeValue(show.getHostIp())%>')" />
						<%}%>
			   		    <%}%>
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
//新增、编辑巡检脚本
function setScript(itemId,scriptsId,hostId,hostMesLog){
	var qryPara="itemId="+itemId+"&scriptsId="+scriptsId+"&hostId="+hostId+"&proId=<%=proId%>&opCode=<%=opCode%>&hostMesLog="+encodeURI(hostMesLog);
	parent.openDivWin("<%=request.getContextPath()%>/hostCheckScriptMain.do?"+qryPara,"设置巡检脚本","800","300");
	parent.refreshByClose();
}

//执行脚本
function runScript(scriptsType,scriptsId,taskId,hostMesLog){
	if(scriptsType=="0"){//定时执行的脚本
		var packet = new AJAXPacket("<%=request.getContextPath()%>/exceHostCheckScriptByAuto.do");
		packet.data.add("scriptsId" ,scriptsId);
		packet.data.add("taskId" ,taskId);
		packet.data.add("proId" ,"<%=proId%>");
		packet.data.add("opCode" ,"<%=opCode%>");
		packet.data.add("hostMesLog" ,hostMesLog);

		core.ajax.sendPacket(packet,doScriptsRunRow);
		packet =null;
	}else{//手工执行的脚本
		var qrystr="scriptsId="+scriptsId+"&proId=<%=proId%>&opCode=<%=opCode%>&hostMesLog="+encodeURI(hostMesLog);	
		parent.openDivWin("<%=request.getContextPath()%>/exceHostCheckScriptByManual.do?"+qrystr,"执行主机巡检脚本","800","300");
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
function stopScript(scriptsType,scriptsId,taskId,hostMesLog){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/stopHostCheckScriptByAuto.do");
	packet.data.add("scriptsId" ,scriptsId);
	packet.data.add("taskId" ,taskId);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
		packet.data.add("hostMesLog" ,hostMesLog);

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
