<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.BusicheckBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">网元进程信息列表</div></div>  
<div class="list">
	<table id="mTable" style="table-layout:fixed;word-wrap:break-word;">
		<tr>
			<th style="width:7%">进程ID</th>
			<th style="width:7%">省份运营商</th>
			<th style="width:10%">网元名称</th>
			<th style="width:10%">网元IP地址</th>
			<th style="width:7%">网元监听端口</th>
			<th style="width:10%">进程名称</th>
			<th style="width:10%">进程描述</th>	
			<th style="width:7%">数据类型</th>
			<th style="width:10%">操作</th>						
		</tr>
		<% 
			//系统变量
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];
		    String loginNo=session.getAttribute("loginNo").toString();
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    String scriptConf = request.getParameter("scriptConf");
		           
		    //业务变量
		    String cellName = request.getParameter("cellName").trim();
		    		    
			BusicheckBo busicheckBo = new BusicheckBo();
			busicheckBo.setLoginNo(loginNo);
			busicheckBo.setProvinceCode(provinceCode);
			busicheckBo.setTellType(tellType);
		    if(cellName!=null && !"".equals(cellName))busicheckBo.setCellName(cellName);		    
		    		    		     		
		%>
		<si:pagelist name="progressList" id="sbusicheck.select_1_100" param="<%=busicheckBo%>" scope="end" url="pm001_list_100.jsp">
			 <logic:iterate id="show" name="progressList" indexId="i" type="com.sitech.rom.common.bo.BusicheckBo">    
		   		<tr>
		   			<td><%=StringUtil.safeValue(show.getSeqId())%></td>
		   			<td><%=StringUtil.safeValue(show.getProvinceName())%><%=StringUtil.safeValue(show.getTellcorpName())%></td>			   		
					<td><%=StringUtil.safeValue(show.getCellName())%></td>
			   		<td><%=StringUtil.safeValue(show.getIpAddr())%></td>
			   		<td><%=StringUtil.safeValue(show.getPort())%></td>
			   		<td><%=StringUtil.safeValue(show.getCheckNodes())%></td>
			   		<td><%=StringUtil.safeValue(show.getChildNode())%></td>
			   		<td><% if(show.getIsOwn()==0){
			   				   out.print("自建");
			   			   }else{
			   			   	   out.print(show.getLoginNo()+" 共享");
			   			   } 
			   			%>
			   		</td>	    		
			   										   		     
			   		<td>
			   			<% if(show.getIsOwn()==0){ %>
			   		    <input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('<%=show.getScriptsId()%>','<%=show.getSeqId()%>',100)"/>			   		    
			   		    <input type="button" class="butAmed" name="scriptConf" style="display:none" title="配置脚本" onclick="scriptConf('<%=show.getSeqId()%>',100)"/>
			   		    <input type="button" class="butDel" name="del" style="display:none" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'<%=show.getScriptsId()%>\',\'<%=show.getSeqId()%>\',\'<%=show.getActionId()%>\')');"/>			   		         
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
    if('<%=scriptConf%>'=='Y'){    
        $("input[name='scriptConf']").each(function(){
            $(this).css('display','');
        })
    }
    
    parent.unLoading('ajaxLoadingDiv');
});
/////////////////////////////////////////////////////////////////////////

//编辑当前行内容
function editRow(scriptsId,seqId,busiIdentify){
	var qryPara="provinceCode="+'<%=provinceCode%>'
	+"&tellType="+'<%=tellType%>'
	+"&proId=<%=proId%>&opCode=<%=opCode%>"
	+"&scriptsId="+scriptsId
	+"&seqId="+seqId
	+"&busiIdentify="+busiIdentify
	;
	
	parent.openDivWin("<%=request.getContextPath()%>/gotoPm001Update.do?"+qryPara,"修改进程信息","800","300");
	parent.refreshByClose();
}

//编辑脚本信息,新增或更新
function scriptConf(seqId,busiIdentify){
	var qryPara="provinceCode="+'<%=provinceCode%>'
	+"&tellType="+'<%=tellType%>'
	+"&proId=<%=proId%>&opCode=<%=opCode%>"
	+"&seqId="+seqId
	+"&busiIdentify="+busiIdentify
	;
	
	parent.openDivWin("<%=request.getContextPath()%>/gotoPm001ScriptConfig.do?"+qryPara,"配置脚本信息","800","300");
	parent.refreshByClose();
}


//删除行
function delRow(scriptsId,seqId,actionId){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/pm001Delete.do");
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=provinceCode%>');
	packet.data.add("tellType" ,'<%=tellType%>');
	
	packet.data.add("scriptsId" ,scriptsId);
	packet.data.add("seqId" ,seqId);
	packet.data.add("actionId" ,actionId);

	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("进程删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("进程删除失败！",0);
  	}
}

</script>
</html>
