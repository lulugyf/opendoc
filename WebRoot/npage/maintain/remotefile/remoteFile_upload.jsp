<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%

%>
<html>
<head>
<title>文件上传</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm" enctype="multipart/form-data">
		
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
 						<th><font color="red">*FTP脚本：</font></th>
						<td>
							<input type="text" name="siteInfo" id="siteInfo" class="" readonly="readonly" />
							<input type=hidden name="scriptId" id="scriptId" >
							<input type=hidden name="siteId" id="siteId" >
							<input type=hidden name="remotePath" id="remotePath" >
							
							<input type="button" name="choiceButton" onClick="choiceFtpScriptInfo();" class="b_foot_long" value="选择FTP脚本" />
						</td>					
 					</tr>
 					<tr>
	 					<td colspan="4">					        
				            <input type="button" name="btnAddFile" class="b_foot_long" value="添加上传文件" onclick="addFile()"/>					         					
				            <div id="content">
				            </div>				        
	 					</td>					
 					</tr>
 				
 					
 					</table>
 
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="uploadFile()" class="b_foot" value="确定" />
				<input type="reset" name="re" onClick="javascript:document.forms('hostForm').reset();" class="b_foot" value="重置" />
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
	
	//关闭弹出页面后，刷新主页面数据--begin
    $('#close').click(function(){
		try{
		    parent.doSrchSubmit();
	    }catch(e){}
	});
});

function uploadFile(){
    if(!checksubmit(hostForm)){
		return false;
	}
	if($("#scriptId").val()==""){
		alert("请选择FTP脚本！");
		return false;
	}
	
	var flag=0;
    $("input[name='uploadFiles']").each(function(){
    	if($(this).val()!=""){
    		flag=1;//有文件
	        var id=$(this).attr("id");
	        var dirValue=$("#"+"d_"+id).val();
	        if(dirValue==""){
	        	alert("请选择上传文件对应的上传目录！");
	        	flag=2;
	        }     	
    	}   
    })
	
	if(flag==0){alert("请选择上传文件！");return false;}
	if(flag==2){return false;}
	
 	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var qryPara='?provinceCode='+provinceCode+'&tellType='+tellType;
	
	document.hostForm.action='<%=request.getContextPath()%>/remoteFileUpload.do'+qryPara;
	document.hostForm.submit();
 		
}
 
function choiceFtpScriptInfo(){
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var qryPara='proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;
	openDivWin("<%=request.getContextPath()%>/gotoQryFtpScriptInfo.do?"+qryPara,"查询Ftp脚本信息","700","300");
}

function setFtpScript(scriptId,siteId,hostIp,remotePath,siteName){
	$("#scriptId").val(scriptId);
	$("#siteId").val(siteId);
	$("#siteInfo").val(hostIp+" "+siteName);
 	$("#remotePath").val(remotePath);		
}

function addFile(){ 
	   //参考:http://q.cnblogs.com/q/10557/
      var id=Math.round(Math.random()*100000);
      var html="<p id='p_" +id +"'>";
      	html=html+"<span style='cursor:pointer;color:red;' pid='p_"+id+"' onclick='deleteFile(this)'>刪除</span>";
      	html=html+"<input type=file name='uploadFiles' size=60 id='"+id+"' onchange='uploadDirsChg(\""+id+"\",this.value)'/>"      	
      	html=html+"<input type='text' name='uploadDirs' readonly='readonly' id='d_"+id+"'/>";
      	html=html+"<input type='hidden' name='uploadFileNames' readonly='readonly' id='fn_"+id+"'/>";
      	html=html+"<input type='button' name='choiceButton' onClick='getRemoteDir(\"d_"+id+"\");' class='b_foot_long' value='获得远程目录' />";
  		html=html+"</p>";
  	  //alert(html);
      $("#content").append(html); 
}  
    
function deleteFile(obj)
{
  var id=$(obj).attr("pid");
  $("#"+id).remove();
}

function getRemoteDir(did){
	if($("#scriptId").val()==""){
		alert("请选择FTP脚本！");
		return false;
	}
	var scriptId=$("#scriptId").val();
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var qryPara='proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType;
	
	qryPara=qryPara+"&scriptId="+scriptId+"&remotePath="+$("#remotePath").val()+"&did="+did;
	openDivWin("<%=request.getContextPath()%>/npage/maintain/remotefile/getRemoteDirFile.jsp?"+qryPara,"获得上传远程目录","700","500");
}

function setDir(did,dir){
	//alert(did+dir);
	$("#"+did).val(dir)
}

function uploadDirsChg(id,value){
	//alert(value);
	$("#fn_"+id).val(value);
}	
</script>
</body>
</html>