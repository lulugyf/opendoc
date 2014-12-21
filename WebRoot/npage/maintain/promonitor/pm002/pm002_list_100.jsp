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
<div class="title"> <div class="text">网元进程信息监控</div></div>  
<div class="list">
	<table id="mTable" style="table-layout:fixed;word-wrap:break-word;">

		<tr>
			<th style="width:7%">省份运营商</th>
			<th style="width:10%">网元名称</th>
			<th style="width:10%">网元IP地址</th>
			<th style="width:7%">网元监听端口</th>
			<th style="width:10%">进程名称</th>
			<th style="width:10%">进程描述</th>
			<th style="width:5%">监控阀值</th>			
			<th style="width:5%">检查结果</th>
			<th style="width:5%">进程状态</th>
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
		    String runstop = request.getParameter("runstop");
		           
		    //业务变量
		    String cellName = request.getParameter("cellName").trim();
		    		    
			BusicheckBo busicheckBo = new BusicheckBo();
			busicheckBo.setLoginNo(loginNo);
			busicheckBo.setProvinceCode(provinceCode);
			busicheckBo.setTellType(tellType);
		    if(cellName!=null && !"".equals(cellName))busicheckBo.setCellName(cellName);		    
		    		    		     		
		%>
		<si:pagelist name="progressList" id="sbusicheck.select_1_100_monitor" param="<%=busicheckBo%>" scope="end" url="pm001_list_100.jsp">
			 <logic:iterate id="show" name="progressList" indexId="i" type="com.sitech.rom.common.bo.BusicheckBo">    
		   		<tr>
		   			<td><%=StringUtil.safeValue(show.getProvinceName())%><%=StringUtil.safeValue(show.getTellcorpName())%></td>			   		
					<td><%=StringUtil.safeValue(show.getCellName())%></td>
			   		<td><%=StringUtil.safeValue(show.getIpAddr())%></td>
			   		<td><%=StringUtil.safeValue(show.getPort())%></td>
			   		<td><%=StringUtil.safeValue(show.getCheckNodes())%></td>
			   		<td><%=StringUtil.safeValue(show.getChildNode())%></td>
			   		<td><%=StringUtil.safeValue(show.getCheckLimitValue())%></td>			   		
			   		<td><% if("0".equals(show.getErrFlag()) ){
			   				   out.print(StringUtil.safeValue(show.getCheckValue()));
			   			   }else if("1".equals(show.getErrFlag()) ){
			   			   	   out.print("<font color='red'><b>" + StringUtil.safeValue(show.getCheckValue()) +"</b></font>");
			   			   }else{
			   			   	   out.print("");
			   			   }
			   			%></td>
			   		<td><% if("0".equals(show.getErrFlag()) ){
			   				   out.print(StringUtil.safeValue(show.getMonitorRemark()));
			   			   }else if("1".equals(show.getErrFlag()) ){
			   			   	   out.print("<font color='red'><b>" + StringUtil.safeValue(show.getMonitorRemark()) +"</b></font>");
			   			   }else{
			   			   	   out.print("");
			   			   }
			   			%>
			   		</td>						   		     
			   		<td>
			   			<% if(show.getIsOwn()==0){ %>
			   		    <input type="button" class="b_foot" name="runstop" style="display:none" value="启动" onclick="exeCmd('<%=show.getSeqId()%>',0)"/>
			   		    <input type="button" class="b_foot" name="runstop" style="display:none" value="停止" onclick="exeCmd('<%=show.getSeqId()%>',1)"/>			   		    			   		         
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
        $("input[name='runstop']").each(function(){
            $(this).css('display','');
        })
    }
    
    parent.unLoading('ajaxLoadingDiv');
});
/////////////////////////////////////////////////////////////////////////


//执行命令
function exeCmd(seqId,actionId){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/pm002ExeCmd.do");
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=provinceCode%>');
	packet.data.add("tellType" ,'<%=tellType%>');
	
	packet.data.add("seqId" ,seqId);
	packet.data.add("actionId" ,actionId);

	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	retMsg = decodeURI(retMsg);
	
  	if(retCode=='1'){
  	    parent.parent.showDialog(retMsg,2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else if(retCode=='0'){
  		parent.parent.showDialog("执行结果为:" + retMsg,2);
  	}else if(retCode=='3'){
  		parent.parent.showDialog(retMsg,0);
  	}else{
  	    parent.parent.showDialog("进程执行失败！",0);
  	}
}

</script>
</html>
