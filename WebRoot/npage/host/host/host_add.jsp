<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
 
<html>
<head>
<title>新增主机信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm">
		
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
			
			<div class="input">
				<div id="formTab">
					<ul>
						<li class="current" id="title_0" onclick="HoverLit(0,2)"><a href="#this">新增主机</a></li>
						<li class="normaltab" id="title_1" onclick="HoverLit(1,2)"><a href="#this">关联已有主机</a></li>
					</ul>
				</div>
				<div id="table_0">
					<table>
						<tr>
							<th><font color="red">*省份运营商：</font></th>
							<td>
								<select name="provinceTell" id="provinceTell">
								<c:if test="${provinceTellcorpList!=null}"> 
								<c:forEach items="${provinceTellcorpList}" var="item">
									<option value="${item.provinceCode}_${item.tellcorpCode}" >${item.provinceName}${item.tellcorpName}</option>
								</c:forEach>
								</c:if>
								</select>
							</td>
						<th></th>
						<td></td>
						</tr>				
						<tr>
							<th><font color="red">*主机环境：</font></th>
							<td>
								<select name="hostEnv" id="hostEnv" class="required">
									<option value="" ></option>
									<option value="0">测试环境</option>
									<option value="1">生产环境</option>
									<option value="2">开发环境</option>							
								</select>						
							</td>
							<th><font color="red">*主机操作系统：</font></th>
							<td>
								<select name="hostOs" id="hostOs" class="required">
									<option value="" ></option>
									<option value="0">aix</option>
									<option value="1">hp</option>
									<option value="2">sun</option>
									<option value="3">linux</option>
									<option value="4">其他</option>							
								</select>						
							</td>
						</tr>
						<tr>
							<th><font color="red">*主机IP：</font></th>
							<td>
								<input type="text" name="hostIp" id="hostIp"   class="required ipAddress isCharLengthOf" v_maxlength="32" v_minlength="0"/>
							</td>
							<th><font color="red">*主机名称：</font></th>
							<td>
								<input type="text" name="hostName" id="hostName"   class="required isCharLengthOf" v_maxlength="32" v_minlength="0"/>
							</td>				
						</tr>
						<tr>
							<th>备注：</th>
							<td colspan="3">
								<input type="text" name="remark" id="remark" class="isCharLengthOf" v_maxlength="128" v_minlength="0" size="100"/>
							</td> 				
						</tr>										
					</table>
					<div id="operation_button">
						<input type="button" name="su" onClick="addHostSubmit()" class="b_foot" value="确定" />
						<input type="reset" name="re" onClick="javascript:document.forms('hostForm').reset();" class="b_foot" value="重置" />
						<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
					</div>
					<div align="center">
					    <font color="red"><span id="succInfo">${operInfo}</span></font>
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
    
    var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var qryPara="proId=<%=proId%>&opCode=<%=opCode%>&provinceCode="+provinceCode+'&tellType='+tellType;
    $('#ifm').attr('src','<%=request.getContextPath()%>/gotoQryRelateHost.do?'+qryPara);
});

function addHostSubmit(){
    if(!checksubmit(hostForm)){
		return false;
	}
	
	document.hostForm.action='<%=request.getContextPath()%>/addHost.do';
	document.hostForm.submit();
}

function g(o){
	return document.getElementById(o);
}	
//tab页调用的方法，控制整个页面输出内容	 
function HoverLit(n,t){	
	for(var i=0;i<t;i++){
		g('title_'+i).className='normaltab';
		g('table_'+i).style.display='none';  	  	
	}
	g('title_'+n).className='current';
	g('table_'+n).style.display='block';
}
</script>
</body>
</html>