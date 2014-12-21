<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
 
<html>
<head>
<title>新增网元接口</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="netCellForm">&nbsp; 
		 
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
			
			<div class="input">
				<div id="formTab">
				</div>
				<div id="table_0">
					<table>
						<tr>
							<th>省份运营商：</th>
							<td>
								<select name="provinceTell" id="provinceTell">
								<c:if test="${provinceTellcorpList!=null}"> 
								<c:forEach items="${provinceTellcorpList}" var="item">
									<option value="${item.provinceCode}_${item.tellcorpCode}" >${item.provinceName}${item.tellcorpName}</option>
								</c:forEach>
								</c:if>
								</select>
							</td>
							<th>网元名称：</th>
							<td>
								<input type="text" name="cellName" id="cellName" v_minlength="1" v_maxlength="32" class="byteSize" />
							</td>
						</tr>
						<tr>							
							<th>网元类型：</th>
							<td>
								<select name="cellType" id="cellType" onchange="cellTypeChange()">
								<input type=hidden name="paramCellType" id="paramCellType">
								</select>
							</td>
						</tr>
						<tr>
							<th><font color="red">*网元编码：</font></th>
							<td>
								<input type="text" name="cellCode" id="cellCode"  readonly="true" v_minlength="1" v_maxlength="8" class="required numOrLetter isCharLengthOf" />
							</td>
							<th><font color="red">*网元编号：</font></th>
							<td>
								<input type="text" name="hlrCode" id="hlrCode" v_minlength="1" v_maxlength="8" class="required numOrLetter isCharLengthOf" />
							</td>
						</tr>
						<tr>
							<th><font color="red">*IP地址：</font></th>
							<td>
								<input type="text" name="ipAddr" id="ipAddr" class="required ipAddress" />
							</td>
							<th><font color="red">*监听端口：</font></th>
							<td>
								<input type="text" name="port" id="port" v_minlength="1" v_maxlength="6" class="required isCharLengthOf nonNegInt" />
							</td>
						</tr>
						<tr>
							<th>是否有效：</th>
							<td>
								<select name="useFlag" id="useFlag">
									<option value="y">有效</option>
									<option value="n">无效</option>
								</select>
							</td>
						</tr>	
						<tr>	
							<th>备注：</th>
							<td colspan="3">
								<input type="text" name="remark" id="remark" size="64" v_minlength="1" v_maxlength="64" class="byteSize"/>
							</td>
						</tr>										
					</table>
					<div id="operation_button">
						<input type="button" name="su" onClick="addNetCellSubmit()" class="b_foot" value="确定" />
						<input type="reset" name="re" onClick="javascript:document.forms('netCellForm').reset();" class="b_foot" value="重置" />
						<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
					</div>
				</div>
				<div id="table_1" style="display:none;">
					<iframe name="ifm" id="ifm" src="" style="width:100%;height:320px" frameborder="0"></iframe>
				</div>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>

$(document).ready(function () {
	//关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSrchSubmit();
	    }catch(e){}
	});	
	
	$("#provinceTell option").each(function(){
    	if($(this).val()!=$('#provinceCode').val()+'_'+$('#tellType').val()){
    		$(this).remove();
    	}
    });    
    
    //特殊处理
    var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);	
	if(tellType == "3"){//广电
		$("#cellType option:last").remove();
		$("#cellType option:last").remove();    
		$("#cellType").append("<option value='Y'>CA网元</option>");
		$("#cellType").append("<option value='N'>非CA网元</option>");   
		document.getElementById('paramCellType').value = "";
			
		document.getElementById("hlrCode").readOnly = false;
		document.getElementById("cellCode").readOnly  = false;			
	}else{
		$("#cellType option:last").remove();
		$("#cellType option:last").remove(); 
		$("#cellType").append("<option value='Y'>HLR网元</option>");
		$("#cellType").append("<option value='N'>非HLR网元</option>");
		document.getElementById('paramCellType').value = "hlr";
	}
	document.getElementById("cellCode").value = document.getElementById('paramCellType').value;		
    
});


/**********************************************************************************/
//提交
function addNetCellSubmit(){
    if(!checksubmit(netCellForm)){
		return false;
	}	

	//异步操作方式
	var packet = new AJAXPacket("<%=request.getContextPath()%>/nc001Add.do");
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=request.getParameter("provinceCode")%>');
	packet.data.add("tellType" ,'<%=request.getParameter("tellType")%>');
	
	packet.data.add("cellCode" ,$("#cellCode").val());
	packet.data.add("hlrCode" ,$("#hlrCode").val());
	packet.data.add("ipAddr" ,$("#ipAddr").val());
	packet.data.add("port" ,$("#port").val());
	packet.data.add("cellName" ,$("#cellName").val());
	packet.data.add("useFlag" ,$("#useFlag").val());
	packet.data.add("remark" ,$("#remark").val());

	core.ajax.sendPacket(packet,doAddNetCellSubmit);
	packet =null;		
}
function doAddNetCellSubmit(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    parent.parent.showDialog("新增网元成功！",2);
  	    
  	    parent.doSrchSubmit();
  	    parent.removeDivWin('divWin');
  	}else if(retCode=='noright'){
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  	}else{
  	    parent.parent.showDialog("新增网元失败！",0);
  	}
}

//网元类型选择变更
function cellTypeChange(){
	var cellType = document.getElementById("cellType").value;
	var provinceTell=document.getElementById('provinceTell').value;	
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	
	if(tellType == "3"){//广电,网元编号和网元编码始终允许输入,且都没有默认值
		document.getElementById("hlrCode").readOnly = false;
		document.getElementById("cellCode").readOnly  = false;
	}else{	
		if(cellType == "Y"){
			document.getElementById("hlrCode").value = "";
			document.getElementById("cellCode").value = document.getElementById('paramCellType').value;			
			
			document.getElementById("hlrCode").readOnly  = false;
			document.getElementById("cellCode").readOnly  = true;	
					
		}else if(cellType = "N"){
			document.getElementById("hlrCode").value = "only";
			document.getElementById("cellCode").value = "";
			
			document.getElementById("hlrCode").readOnly  = true;
			document.getElementById("cellCode").readOnly  = false;			
		}	
	}	
}


</script>
</body>
</html>