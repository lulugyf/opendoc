<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.bo.HostBo" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">主机列表</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>操作</th>
			<th>省份运营商</th>
			<th>主机环境</th>
			<th>主机IP</th>
			<th>主机操作系统</th>
			<th>备注</th>
		</tr>
		<% 
			
		    String provinceTell = request.getParameter("provinceTell").trim();
		    String[] arr=provinceTell.split("_");
		    String provinceCode = arr[0];
		    String tellType = arr[1];	    
		    String hostEnv = request.getParameter("hostEnv").trim();
		    String hostOs = request.getParameter("hostOs").trim();
		    String hostIp = request.getParameter("hostIp").trim();
		    
		    HostBo hostBo = new HostBo();
		    if(proId!=null && !"".equals(proId))hostBo.setProCode(proId);
		    if(provinceCode!=null && !"".equals(provinceCode))hostBo.setProvinceCode(provinceCode);
		    if(tellType!=null && !"".equals(tellType))hostBo.setTellType(tellType);
		    if(hostEnv!=null && !"".equals(hostEnv))hostBo.setHostEnv(hostEnv);
		    if(hostOs!=null && !"".equals(hostOs))hostBo.setHostOs(hostOs);
		    if(hostIp!=null && !"".equals(hostIp))hostBo.setHostIp(hostIp);

		    String loginNo=session.getAttribute("loginNo").toString();
		    hostBo.setLoginNo(loginNo); 
		%>
		<si:pagelist name="hostlist" id="shost.qryRomHostRelate" param="<%=hostBo %>" scope="end" url="hostInfoList.jsp">
			 <logic:iterate id="show" name="hostlist" indexId="i" type="com.sitech.rom.common.bo.HostBo">    
		   		<tr>
		   			<td><input type="button" class="b_foot" value="选择此主机" 
			   		    onclick="choice('<%=StringUtil.safeValue(show.getHostId())%>',
			   		    '<%=StringUtil.safeValue(show.getProvinceName())+StringUtil.safeValue(show.getTellName())+"-"+StringUtil.safeValue(show.getHostIp())%>',
			   		    '<%=StringUtil.safeValue(show.getHostIp()) %>')"/>
 		   			</td>
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
			   		<td><%=StringUtil.safeValue(show.getRemark())%></td>
			   		    
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
 
//选择当前行内容
function choice(hostId,hostInfo,hostIp){
	//alert("1111 "+hostId+":"+hostInfo);
	parent.setHost(hostId,hostInfo,hostIp);	
}
 

</script>
</html>
