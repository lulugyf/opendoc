<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ page import="com.sitech.rom.common.dto.RomNetCell" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">网元接口列表</div></div>  
<div class="list">
	<table id="mTable" style="table-layout:fixed;word-wrap:break-word;">
		<tr>
			<th style="width:7%">省份运营商</th>
			<th style="width:10%">网元名称</th>
			<th style="width:10%" >网元编码</th>
			<th style="width:10%" >网元编号</th>
			<th style="width:10%">IP地址</th>
			<th style="width:5%" >监听端口</th>
			<th style="width:5%">是否有效</th>
			<th style="width:20%">备注</th>
			<th style="width:12%">操作</th>
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
		    		    
			RomNetCell romNetCell = new RomNetCell();
		    if(provinceCode!=null && !"".equals(provinceCode))romNetCell.setProvinceCode(provinceCode);
		    if(tellType!=null && !"".equals(tellType))romNetCell.setTellType(tellType);
		    if(cellName!=null && !"".equals(cellName))romNetCell.setCellName(cellName);		    
		    		    		     		
		%>
		<si:pagelist name="netCelllist" id="RomNetCell.selectNetCellInfoList" param="<%=romNetCell%>" scope="end" url="nc001_list.jsp">
			 <logic:iterate id="show" name="netCelllist" indexId="i" type="com.sitech.rom.common.dto.RomNetCell">    
		   		<tr>
		   			<td><%=StringUtil.safeValue(show.getProvinceName())%><%=StringUtil.safeValue(show.getTellcorpName())%></td>			   		
					<td><%=StringUtil.safeValue(show.getCellName())%></td>
			   		<td><%=StringUtil.safeValue(show.getCellCode())%></td>
			   		<td><%=StringUtil.safeValue(show.getHlrCode())%></td>
			   		<td><%=StringUtil.safeValue(show.getIpAddr())%></td>
			   		<td><%=StringUtil.safeValue(show.getPort())%></td>
			   		<td><%if("y".equals(StringUtil.safeValue(show.getUseFlag()))){
			   		          out.print("有效");
			   		      }else if("n".equals(StringUtil.safeValue(show.getUseFlag()))){
			   		          out.print("无效");
			   		      }else {
			   		          out.print("空值");
			   		      }%></td>	    
			   		<td><%=StringUtil.safeValue(show.getRemark())%></td>		
			   										   		      
			   		<td>			   			
			   		    <input type="button" class="butCha" name="edit" style="display:none" title="编辑" onclick="editRow('<%=StringUtil.safeValue(show.getCellId())%>')"/>			   		    			   		         
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
        $("input[name='set']").each(function(){ 
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
function editRow(cellId){
	var qryPara="provinceCode="+'<%=provinceCode%>'
	+"&tellType="+'<%=tellType%>'
	+"&cellId="+cellId
	+"&proId=<%=proId%>&opCode=<%=opCode%>";	
	
	parent.openDivWin("<%=request.getContextPath()%>/gotoNc002Update.do?"+qryPara,"网元扩展属性配置","800","300");
	parent.refreshByClose();
}


</script>
</html>
