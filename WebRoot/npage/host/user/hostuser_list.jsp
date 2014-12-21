<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.HostUserBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">主机用户列表</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>产品名称</th>
			<th>省份运营商</th>
			<th>主机环境</th>
			<th>主机IP</th>
			<th>主机操作系统</th>
			<th>用户名</th>
			<th>HOME目录</th>
			<th>操作</th>
		</tr>
		<% 
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];	    
		    String hostEnv = request.getParameter("hostEnv").trim();
		    String hostOs = request.getParameter("hostOs").trim();
		    String hostIp = request.getParameter("hostIp").trim();
		    
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    
		    HostUserBo hostUserBo = new HostUserBo();
		    if(proId!=null && !"".equals(proId))hostUserBo.setProCode(proId);
		    if(provinceCode!=null && !"".equals(provinceCode))hostUserBo.setProvinceCode(provinceCode);
		    if(tellType!=null && !"".equals(tellType))hostUserBo.setTellType(tellType);
		    if(hostEnv!=null && !"".equals(hostEnv))hostUserBo.setHostEnv(hostEnv);
		    if(hostOs!=null && !"".equals(hostOs))hostUserBo.setHostOs(hostOs);
		    if(hostIp!=null && !"".equals(hostIp))hostUserBo.setHostIp(hostIp);
 
		    String loginNo=session.getAttribute("loginNo").toString();
		    hostUserBo.setLoginNo(loginNo);
 				     
		%>
		<si:pagelist name="hostuserlist" id="shostuser.qryRomHostUserInfo" param="<%=hostUserBo %>" scope="end" url="hostuser_list.jsp">
			 <logic:iterate id="show" name="hostuserlist" indexId="i" type="com.sitech.rom.common.bo.HostUserBo">    
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
			   		<td><%=StringUtil.safeValue(show.getUserName())%></td>
			   		<td><%=StringUtil.safeValue(show.getHomeDir())%></td>
			   		
			   		<td>
			   		    <input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('<%=StringUtil.safeValue(show.getUserId())%>')"/>
			   		    <input type="button" class="butDel" name="del" style="display:none" title="删除" onclick="showDialog('是否删除?',3,'retT=delRow(\'<%=StringUtil.safeValue(show.getUserId())%>\')');"/>  
 
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
function editRow(userId){
	var qryPara="userId="+userId+"&proId=<%=proId%>&opCode=<%=opCode%>&provinceCode=<%=provinceCode%>&tellType=<%=tellType%>";
	parent.openDivWin("<%=request.getContextPath()%>/gotoUpdateHostUser.do?"+qryPara,"修改主机用户","800","300");
	parent.refreshByClose();
}
//删除行
function delRow(userId){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/delHostUser.do");
	packet.data.add("userId" ,userId);
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
  	    parent.parent.showDialog("主机用户删除成功！",2);
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("主机用户删除失败！",0);
  	}
}

</script>
</html>
