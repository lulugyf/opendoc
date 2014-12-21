<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.ProgressInfoBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">应用进程列表</div></div>  
<div class="list">
 
	<table id="mTable">
		<tr>
			<th>产品</th>
			<th>省份运营商</th>
			<th>主机环境</th>
			<th>主机IP</th>
			<th>主机操作系统</th>
			<th>进程名称</th>
			<th>进程描述</th>
			<th>数据类型</th>
			<th>操作</th>
		</tr>
		<% 
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];	    
	    
	    	String hostIp = request.getParameter("hostIp");
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    String pope = request.getParameter("pope");
		    
		    ProgressInfoBo progressBo = new ProgressInfoBo();
		    if(proId!=null && !"".equals(proId))progressBo.setProCode(proId);
		    if(provinceCode!=null && !"".equals(provinceCode))progressBo.setProvinceCode(provinceCode);
		    if(tellType!=null && !"".equals(tellType))progressBo.setTellType(tellType);
		    if(hostIp!=null && !"".equals(hostIp))progressBo.setHostIp(hostIp.trim());
 			
		    String loginNo=session.getAttribute("loginNo").toString();
		    progressBo.setLoginNo(loginNo);
		    progressBo.setFuncCode(opCode);
		    	     
		%>
		<si:pagelist name="progresslist" id="sprocessInfo.qryProgInfoConf" param="<%=progressBo %>" scope="end" url="progressInfo_list.jsp">
			 <logic:iterate id="show" name="progresslist" indexId="i" type="com.sitech.rom.common.bo.ProgressInfoBo">    
		   		<tr>
		   			<td><%=StringUtil.safeValue(show.getProName())%></td>
			   		<td><%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())%></td>
			   		<td><%if("0".equals(StringUtil.safeValue(show.getHostEnv()))){
			   		          out.print("测试环境");
			   		      }else if("1".equals(StringUtil.safeValue(show.getHostEnv()))){
			   		          out.print("生产环境");
			   		      }else if("2".equals(StringUtil.safeValue(show.getHostEnv()))){
			   		          out.print("开发环境");
			   		      }%></td>
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
			   		<td><%=StringUtil.safeValue(show.getItemName())%></td>
			   		<td><%=StringUtil.safeValue(show.getItemDesc())%></td>
			   		<td><% if(show.getIsOwn()==0){
			   				   out.print("自建");
			   			   }else{
			   			   	   out.print(show.getLoginNo()+"共享");
			   			   } %>
			   		</td>
			   		<td>
						<% if(show.getIsOwn()==0){ %>
							<input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('<%=StringUtil.safeValue(show.getItemId())%>')"/>
			   		    	<input type="button" class="butDel" name="del" style="display:none" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'<%=StringUtil.safeValue(show.getItemId())%>\',\'<%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())+"-"+StringUtil.safeValue(show.getHostIp())%>\',\'<%=StringUtil.safeValue(show.getItemName())%>\')');"/>  
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
function editRow(itemId){
	var qryPara="itemId="+itemId+"&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode=<%=provinceCode%>&tellType=<%=tellType%>";
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateProgInfoConf.do?"+qryPara,"修改进程信息配置","800","400");
	parent.refreshByClose();
}
//删除行
function delRow(itemId,hostName,itemName){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delProgInfoConf.do");
	packet.data.add("itemId" ,itemId);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=provinceCode%>');
	packet.data.add("tellType" ,'<%=tellType%>');
	packet.data.add("hostName" ,hostName);
	packet.data.add("itemName" ,itemName);
	core.ajax.sendPacket(packet,doDelRow);
	packet =null;
}
function doDelRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("进程信息配置删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("进程信息配置删除失败！",0);
  	}
}

</script>
</html>
