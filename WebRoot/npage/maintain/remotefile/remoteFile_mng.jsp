<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>

<%

%>
<html>
<head>
<title>远端文件管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm">
		
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<div class="input">
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
 						<th><font color="red">*FTP站点：</font></th>
						<td>
							<input type="text" name="siteInfo" id="siteInfo" class="" readonly="readonly" />
							<input type=hidden name="siteId" id="siteId" >
							<input type="button" name="choiceButton" onClick="choiceFtpInfo();" class="b_foot" value="选择FTP" />
						</td>					
 					</tr>
 					<tr><td colspan="4">
 						<iframe name="ifm" id="ifm" src="" style="width:100%;" frameborder="0"></iframe>
 					</td></tr>
 					
				</table>
			</div>

			<div align="center">
			    <font color="red"><span id="succInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>
$(document).ready(function () {
 $('#ifm').height(document.documentElement.clientHeight-60);
 $('#ifm').width(document.documentElement.clientWidth-30);
});

function choiceFtpInfo(){
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var qryPara='proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;
	openDivWin("<%=request.getContextPath()%>/gotoQryFtpInfo.do?"+qryPara,"查询Ftp信息","800","300");
}

function setFtp(siteId,hostIp,ftpPort,remotePath,siteInfo,desStr){
	$("#siteId").val(siteId);
	$("#siteInfo").val(siteInfo);
	var surl="http://"+hostIp+":"+ftpPort+"/rpcapp/Browser.jsp?dir="+remotePath+"&desStr="+desStr;
	if(uif.pageLoadStatus(surl)=='200'){
		document.forms['hostForm'].action=surl;
    document.forms['hostForm'].target="ifm";
    document.forms['hostForm'].submit();
	}else{
		document.forms['hostForm'].action='<%=request.getContextPath()%>/npage/error/errorNotExist.jsp';
    document.forms['hostForm'].target="ifm";
    document.forms['hostForm'].submit();
	}
    
	unLoading('ajaxLoadingDiv');			
}
 
	
</script>
</body>
</html>