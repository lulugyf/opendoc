<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>定时任务执行结果展示</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
#tree_tree_1 a:visited {
	color:#000
}
</style>
</head>
<body>
<div id="operation">
	<form name="srchFrm" method=post>
		
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="funcCode" id="funcCode" value="<%=request.getParameter("dataFuncCode")%>">		
		
	    <div id="operation_table">	
			<table id="operPanel">
				<tr>
				  <td style="width:20%" valign="top">
				  		<div id="mzTree" style="border:1px solid #c0d4db;padding:3px;"></div>
				  </td>
				  <td valign="top">
				  <%@ include file="/npage/include/header.jsp"%>
				  		<div class="input">
				  			<input type=hidden name="hostId" id="hostId" >
							<table style="margin-left:10px;width:99%">
								<tr>
									<th>*开始时间：</th>
									<td><input id="createDateStart" name="createDateStart" type="text" class="required"
												onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true,maxDate:'#F{$dp.$D(\'createDateEnd\')}'})"/></td>
									<th>*结束时间：</th>
									<td><input id="createDateEnd" name="createDateEnd" type="text" class="required"
												onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',autoPickDate:true,minDate:'#F{$dp.$D(\'createDateStart\')}'})"/></td>
								</tr>
								<tr>
									<td colspan="4" style="text-align:center">
										<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
										<input type="button" class="b_foot" value="重置" onclick="document.forms('srchFrm').reset();"/>
								  </td>
								</tr>
							</table>
						</div>
						
						<div id="formTab" style="margin:10px 0 0 10px">
							<ul>
								<li class="current" id="title_0" onclick="HoverLit(0,3)"><a href="#this">内存信息</a></li>
								<li class="normaltab" id="title_1" onclick="HoverLit(1,3)"><a href="#this">CPU信息</a></li>
								<li class="normaltab" id="title_2" onclick="HoverLit(2,3)"><a href="#this">文件系统信息</a></li>
							</ul>
						</div>
						<div id="table_0">
							<iframe name="ifmmemo" id="ifmmemo" src="" style="margin-left:10px;width:99%" frameborder="0"></iframe>
						</div>
						<div id="table_1" style="display:none;">
							<iframe name="ifmcpu" id="ifmcpu" src="" style="margin-left:10px;width:99%" frameborder="0"></iframe>
						</div>
						<div id="table_2" style="display:none;">
							<iframe name="ifmfile" id="ifmfile" src="" style="margin-left:10px;width:99%" frameborder="0"></iframe>
						</div>
						
				  </td>
				</tr>
			</table>
			
			
			 	
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>						
</body>

<script language="javascript" src="<%=request.getContextPath()%>/njs/plugins/MzTreeView12.js"></script>	
<script language="javascript" type="text/javascript">
window.onload=function(){
	tree = new MzTreeView("tree");
	tree.setIconPath("<%=request.getContextPath()%>/nresources/UI/images/mztree/");//设置图片路径
	
	with(tree){
		N["0_01"]="T:主机树";
		
		<c:forEach var="item" items="${hostList}">
			N["01_${item.hostId}"]="T:${item.hostIp};C:setValue('${item.hostId}')";	
		</c:forEach>
		
	}
	//tree插入相应层
	document.getElementById("mzTree").innerHTML = tree.toString();
	
	tree.colors.highLight='#eee';
	
	setHeight();
}

function setValue(hostId){
	$('#hostId').val(hostId);
	closeDivWin();
}

//查询表单提交
function doSrchSubmit(){
	if(!checksubmit(srchFrm)){
		return false;
	}
	
	if($.trim($('#hostId').val())==''){
		parent.showDialog("请选择主机！",0);
		return;
	}
	
	document.forms['srchFrm'].target="ifmmemo";
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/maintain/hostcheck_data/hostcheckdata_memolist.jsp";
    document.forms['srchFrm'].submit();
    
	document.forms['srchFrm'].target="ifmcpu";
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/maintain/hostcheck_data/hostcheckdata_cpulist.jsp";
    document.forms['srchFrm'].submit();
    
	document.forms['srchFrm'].target="ifmfile";
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/maintain/hostcheck_data/hostcheckdata_filelist.jsp";
    document.forms['srchFrm'].submit();
    
}

function choiceHostInfo(){
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var qryPara="proId=<%=proId%>&opCode=<%=opCode%>&provinceCode="+provinceCode+'&tellType='+tellType;
	openDivWin("<%=request.getContextPath()%>/gotoChkHostInfo.do?"+qryPara,"查询主机信息","700","300");
}

function setHost(hostId,hostInfo){
	$("#hostName").val(hostInfo);
	$("#hostId").val(hostId);
}

function setHeight(){
	$('#mzTree').height(document.documentElement.clientHeight-30);
}

//iframe自适应
function reinitIframeMemo(){
	var iframe = document.getElementById("ifmmemo");
	try{
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = bHeight;
		iframe.height =  height+20;
	}catch (ex){}
}

function reinitIframeCpu(){
	var iframe1 = document.getElementById("ifmcpu");
	try{
		bHeight = iframe1.contentWindow.document.body.scrollHeight;
		//dHeight = iframe1.contentWindow.document.documentElement.scrollHeight;
		height = bHeight;//Math.max(bHeight, dHeight)
		iframe1.height =  height+20;
	}catch (ex){}
}

function reinitIframeFile(){
	var iframe1 = document.getElementById("ifmfile");
	try{
		bHeight = iframe1.contentWindow.document.body.scrollHeight;
		//dHeight = iframe1.contentWindow.document.documentElement.scrollHeight;
		height = bHeight;//Math.max(bHeight, dHeight)
		iframe1.height =  height+20;
	}catch (ex){}
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
	
	reinitIframeMemo();
	reinitIframeCpu();
	reinitIframeFile();
}
</script>
</html>