<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>bus总线</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" target="ifm" method=post>
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="opCode" id="opCode" value="">
		<input type=hidden name="dataFuncCode" id="dataFuncCode" value="<%=opCode%>">
		
		<%@ include file="/npage/include/header.jsp"%>
	    <div id="operation_table">			
			<div class="input">	
				<table>
					<tr>
						<th>省份运营商：</th>
						<td>
							<select name="provinceTell" id="provinceTell" onchange="provinceTellChange();clr()">
							<c:if test="${provinceTellcorpList!=null}"> 
							<c:forEach items="${provinceTellcorpList}" var="item">
								<option value="${item.provinceCode}_${item.tellcorpCode}" >${item.provinceName}${item.tellcorpName}</option>
							</c:forEach>
							</c:if>
							</select>
						</td>
						<th>主机IP：</th>
						<td>
							<input type="text" name="hostIp" id="hostIp"/>
						</td>						
					</tr> 
 
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" id="btnSubmit" class="b_foot" value="查询" onclick=""/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="frmreset()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" id="add" style="display:none" value="新增" onclick=""/>
					  </td>
					</tr>
				</table>
			</div>
			
			<div id="formTab" style="margin:10px 0 0 10px">
				<ul id="formUl">
					<li class="normaltab" id="title_0" onclick="HoverLit(this);"><a href="#this">节点配置</a></li>
					<li class="normaltab" id="title_1" onclick="HoverLit(this);"><a href="#this">远程脚本配置</a></li>
					<li class="normaltab" id="title_2" onclick="HoverLit(this);"><a href="#this">启停管理</a></li>
				</ul>
			</div>
			<div id="table_0" style="display:none;">
				<iframe name="ifmconfig" id="ifmconfig" src="" style="margin-left:10px;width:99%" frameborder="0"></iframe>
			</div>
			<div id="table_1" style="display:none;">
				<iframe name="ifmscript" id="ifmscript" src="" style="margin-left:10px;width:99%" frameborder="0"></iframe>
			</div>
			<div id="table_2" style="display:none;">
				<iframe name="ifmrun" id="ifmrun" src="" style="margin-left:10px;width:99%" frameborder="0"></iframe>
			</div>
			
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>						
</body>
<script language="javascript" type="text/javascript">
/***********显示隐藏功能权限对应按钮 begin***************/
$(document).ready(function () {
    getConfig();
    getScript();
    getRun();
    
    tabShowHide();
   
    $("#formUl").children().each(function(){
        var flag=false;
        if(!$(this).attr('disabled')){
            $(this).click();
            flag=true;
        }
        if(flag==true)return false;
    });
    
});

var opCodeConfig='<%=request.getParameter("node")%>';
var opCodeScript='<%=request.getParameter("script")%>';
var opCodeRun='<%=request.getParameter("run")%>';
var data_0='';
var data_1='';
var data_2='';
function getConfig(){ //获取节点管理操作按钮权限
	var packet = new AJAXPacket("<%=request.getContextPath()%>/busConfigMain.do");
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,opCodeConfig);
	packet.data.add("provinceCode" ,'-1');
	packet.data.add("tellType" ,'-1');
	core.ajax.sendPacketHtml(packet,doConfigRow);
	packet =null;
}
function doConfigRow(data){
	if(data!='noright'){
	    data_0=data;
	}
}

function getScript(){//获取脚本管理操作按钮权限
	var packet = new AJAXPacket("<%=request.getContextPath()%>/busScriptMain.do");
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,opCodeScript);
	packet.data.add("provinceCode" ,'-1');
	packet.data.add("tellType" ,'-1');
	core.ajax.sendPacketHtml(packet,doScriptRow);
	packet =null;
}
function doScriptRow(data){
	if(data!='noright'){
	    data_1=data;
	}
}

function getRun(){//获取启停管理操作按钮权限
	var packet = new AJAXPacket("<%=request.getContextPath()%>/busRunMain.do");
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,opCodeRun);
	packet.data.add("provinceCode" ,'-1');
	packet.data.add("tellType" ,'-1');
	core.ajax.sendPacketHtml(packet,doRunRow);
	packet =null;
}
function doRunRow(data){
	if(data!='noright'){
	    data_2=data;
	}
}

function HoverLit(obj){	//标签切换
	$("#formUl").children().each(function(){
        $(this).attr('class','normaltab');
        $('#table_'+$(this).attr('id').substring($(this).attr('id').length-1)).css('display','none');
    });
    $(obj).attr('class','current');
    $('#table_'+$(obj).attr('id').substring($(obj).attr('id').length-1)).css('display','');
    
    var af=$(obj).attr('id').substring($(obj).attr('id').length-1);
    $('#btnSubmit').get(0).onclick=function(){
    	eval("doSubmit_"+af+"()");
    }
    $('#add').get(0).onclick=function(){
    	if(af!='2')
    	eval("addM_"+af+"()");
    }
    getOpersForPage(eval('data_'+af));
	provinceTellChange();
	$('#btnSubmit').click();
}
//根据按钮权限绑定省份下拉框
function getOpersForPage(opersForPage){
    if(opersForPage!='' && opersForPage!='NULL'){
        
        var attr = opersForPage.split(',');
        for(var i=0; i<attr.length-1; i++){
        	var protell=attr[i].split(':')[0];
        	var opers = attr[i].split(':')[1];
        	$("#provinceTell option[value='"+protell+"']").attr("opers",opers);
        }
    }
}
var param='?';
function provinceTellChange(){
	
    tabShowHide();
    
   	var cflag=false;
   	$("#formUl").children().each(function(){
        if(!$(this).attr('disabled') && $(this).attr('class')=='current'){
        	cflag=true;
        	$(this).click();
        }
    });
   	
   	if(cflag==false){
   		$("#formUl").children().each(function(){
	        var flag=false;
	        if(!$(this).attr('disabled')){
	            $(this).click();
	            flag=true;
	        }
	        if(flag==true)return false;
	    });
   	}
    
	var opersForPage = $("#provinceTell").find("option:selected").attr("opers");
	if(opersForPage){
		if(opersForPage.indexOf('1')>-1){
			$('#add').css('display','');
		}else{
			$('#add').css('display','none');
		}
		param='?';
		if(opersForPage.indexOf('2')>-1){
			param=param+'edit=Y&';
		}else{
			param=param+'edit=N&';
		}
		if(opersForPage.indexOf('3')>-1){
			param=param+'del=Y&';
		}else{
			param=param+'del=N&';
		}
		if(opersForPage.indexOf('5')>-1){
			param=param+'runstop=Y&';
		}else{
			param=param+'runstop=N&';
		}
	}else{
		$('#add').css('display','none');
		$('#btnSubmit').get(0).onclick=function(){}
	}
}

function clr(){
	$('#ifmconfig').attr('src','');
	$('#ifmscript').attr('src','');
	$('#ifmrun').attr('src','');
	$('#btnSubmit').click();
}

function tabShowHide(){
	if(data_0.indexOf(document.getElementById('provinceTell').value)>-1){
        $('#title_0').removeAttr('disabled');
    }else{
   	    $('#title_0').attr('disabled','disabled');
   	    $('#title_0').attr('class','normaltab');
        $('#table_0').css('display','none');
    }
    if(data_1.indexOf(document.getElementById('provinceTell').value)>-1){
        $('#title_1').removeAttr('disabled');
    }else{
    	$('#title_1').attr('disabled','disabled');
   	    $('#title_1').attr('class','normaltab');
        $('#table_1').css('display','none');
    }
    if(data_2.indexOf(document.getElementById('provinceTell').value)>-1){
        $('#title_2').removeAttr('disabled');
    }else{
    	$('#title_2').attr('disabled','disabled');
   	    $('#title_2').attr('class','normaltab');
        $('#table_2').css('display','none');
    }
}

//重置
function frmreset(){
	
	$("#provinceTell").get(0).selectedIndex=0;
	$("#hostIp").val('');
	
	tabShowHide();
   
    $("#formUl").children().each(function(){
        var flag=false;
        if(!$(this).attr('disabled')){
            $(this).click();
            flag=true;
        }
        if(flag==true)return false;
    });
}

//提交
function doSubmit_0(){
	$('#opCode').val(opCodeConfig);
	document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/node/bus/bus_config/busconfig_list.jsp"+param;
	document.forms['srchFrm'].target="ifmconfig";
    document.forms['srchFrm'].submit();
}
function doSubmit_1(){
	$('#opCode').val(opCodeScript);
	document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/node/bus/bus_script/busscript_list.jsp"+param;
	document.forms['srchFrm'].target="ifmscript";
    document.forms['srchFrm'].submit();
}
function doSubmit_2(){
	$('#opCode').val(opCodeRun);
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	param=param+"&provinceCode="+provinceCode+"&tellType="+tellType;
	document.forms['srchFrm'].action="<%=request.getContextPath()%>/qryBusScriptsInfo.do"+param;
	document.forms['srchFrm'].target="ifmrun";
    document.forms['srchFrm'].submit();
}
//新增
function addM_0(){
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var qryPara='?proId=<%=proId%>&opCode='+opCodeConfig+'&provinceCode='+provinceCode+'&tellType='+tellType+'&dataFuncCode='+$("#dataFuncCode").val();
	openDivWin("<%=request.getContextPath()%>/gotoAddBusConfig.do"+qryPara,"新增BUS总线","800","420");
	refreshByClose_0();
}
function addM_1(){
	var proId=$("#proId").val();
	var opCode=opCodeScript;
	var arr = document.getElementById('provinceTell').value.split('_');
	var provinceCode=arr[0];
	var tellType=arr[1];
	var qryPara="proId="+proId
	+"&opCode="+opCode
	+"&provinceCode="+provinceCode
	+"&tellType="+tellType
	+"&dataFuncCode="+$("#dataFuncCode").val()
	openDivWin("<%=request.getContextPath()%>/gotoAddBusScript.do?"+qryPara,"新增bus总线脚本配置","800","400");
	refreshByClose_1();
}
//弹出窗口关闭图标
function refreshByClose_0(){
    $(".window .close:last").click(function(){
		try{
		    doSubmit_0();
	    }catch(e){}
	});
}
function refreshByClose_1(){
    $(".window .close:last").click(function(){
		try{
		    doSubmit_1();
	    }catch(e){}
	});
}

//iframe自适应
function reinitIframeConfig(){
	var iframe = document.getElementById("ifmconfig");
	try{
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = bHeight;
		iframe.height =  height+20;
	}catch (ex){}
}

function reinitIframeScript(){
	var iframe1 = document.getElementById("ifmscript");
	try{
		bHeight = iframe1.contentWindow.document.body.scrollHeight;
		height = bHeight;
		iframe1.height =  height+20;
	}catch (ex){}
}

function reinitIframeRun(){
	var iframe1 = document.getElementById("ifmrun");
	try{
		bHeight = iframe1.contentWindow.document.body.scrollHeight;
		height = bHeight;
		iframe1.height =  height+20;
	}catch (ex){}
}
</script>
</html>