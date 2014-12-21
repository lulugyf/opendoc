<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
 
<html>
<head>
<title>新增进程信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="pmFrom">&nbsp; 
		 
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="provinceCode" id="provinceCode" value="<%=request.getParameter("provinceCode")%>">
			<input type=hidden name="tellType" id="tellType" value="<%=request.getParameter("tellType")%>">
			
			<div class="input">
					<table>
						<tr>
							<th><font color="red">*业务类型：</font></th>
							<td colspan="3">
								<select name="busiIdentify" id="busiIdentify" onchange="onChangeBusiIdentify()" class="required">
									<option value="" ></option>
									<option value="100" >网元业务</option>
								</select>
							</td>														
						</tr>
						
						<tr id="tr_100" style="display:none;">
							<th><font color="red">*网元名称：</font></th>
							<td colspan="3">
								<input type="text" name="cellName" id="cellName" class="required" readonly="readonly" />
								<input type="hidden" name="cellId" id="cellId" >
								<input type="button" name="choiceBusiInfoButton" onClick="choiceBusiInfo(100);" class="b_foot" value="选择网元" />								
							</td>
						</tr>
					
						<tr>
							<th><font color="red">*进程名称：</font></th>
							<td>
								<input type="text" name="checkNodes" id="checkNodes" v_minlength="1" v_maxlength="32" class="required isCharLengthOf"/>
							</td>	
							<th><font color="red">*进程描述：</font></th>
							<td>
								<input type="text" name="childNode" id="childNode" v_minlength="1" v_maxlength="32" class="required isCharLengthOf"/>
							</td>				
	 					</tr>
						<tr>
							<th><font color="red">*是否共享：</font></th>
							<td colspan="3">
								<input type="radio" name="isGrant" value="1" checked="true" onclick="showGrantMethod(this)"/>否
	 							<input type="radio" name="isGrant" value="0" onclick="showGrantMethod(this)"/>是
							</td>
						</tr>
						<tr id="grantMethodTr" style="display:none">
							<th><font color="red">*共享方式：</font></th>
							<td colspan="3">
								<input type="radio" name="grantMethod" value="1" checked="true" onclick="showGrantLogin(this)"/>完全共享
	 							<input type="radio" name="grantMethod" value="0" onclick="showGrantLogin(this)"/>部分共享
							</td>
						</tr>
						<tr id="grantLoginTr" style="display:none">
							<th><font color="red">*选择工号：</font></th>
							<td colspan="3">
								<input type=hidden name="grantLogins" id="grantLogins" />
								<input type="text" name="grantLoginNames" id="grantLoginNames" style="width:450px" readonly="readonly"/>
								<input type="button" name="choiceButton" id="choiceButton" onClick="choiceLogins();" class="b_foot" value="选择" />
								<input type="button" name="clr" id="clr" onClick="clrLogins();" class="b_foot" value="清空" />
							</td>
						</tr>
						
					
					</table>
					<div id="operation_button">
						<input type="button" name="su" onClick="doSrchSubmit()" class="b_foot" value="确定" />
						<input type="reset" name="re" onClick="javascript:document.forms('pmFrom').reset();" class="b_foot" value="重置" />
						<input type="button" name="close" onClick="parent.doSrchSubmit();parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
					</div>
					<div align="center">
			    		<font color="red"><span id="succInfo">${operInfo}</span></font>
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
    	    
});


/**********************************************************************************/

//选择业务信息
function choiceBusiInfo(busiIdentify){
	var qryPara=
	 'provinceCode=<%=request.getParameter("provinceCode")%>'  
	+'&tellType=<%=request.getParameter("tellType")%>'
	+"&proId=<%=proId%>&opCode=<%=opCode%>"
	+"&busiIdentify=" + busiIdentify;
			
	openDivWin("/rom/gotoQryBusiInfo.do?"+qryPara,"查询业务信息","700","300");
}

//设置选择的网元
function setNetCell(cellId,cellName){
	g("cellId").value = cellId;
	g("cellName").value = cellName;
}


//业务标识发生变化
function onChangeBusiIdentify(){
	var busiIdentify = g("busiIdentify").value;	
	var size = 99+g("busiIdentify").options.length;	
	
	//全部隐藏
	for( var i=100; i < size; i++ ){
		g('tr_'+i).style.display='none';
	}
		
	//显示指定的
	if(busiIdentify != ""){				
		g('tr_' + busiIdentify).style.display='';
	}
}

//提交
function doSrchSubmit(){
	if(!checksubmit(pmFrom)){
		return false;
	}
	
	document.pmFrom.action='<%=request.getContextPath()%>/pm001Add.do';
	document.pmFrom.submit();
}

//////////////////共享方式处理////////////////////
//是否共享
function showGrantMethod(obj){
	if($(obj).val()==0){
		$('#grantMethodTr').css('display','');
		$("input[name='grantMethod']").each(function(){
	        if($(this).attr("checked")==true && $(this).val()==0){
	            $('#grantLoginTr').css('display','');
	            $('#grantLoginNames').attr('class',$('#grantLoginNames').attr('class')+' required');
	        }
	    });
	}else{
		$('#grantMethodTr').css('display','none');
		$('#grantLoginTr').css('display','none');
		
		if($('#grantLoginNames').attr('class').indexOf('required')>-1){
			$('#grantLoginNames').attr('class',$('#grantLoginNames').attr('class').substring(0,$('#grantLoginNames').attr('class').indexOf(' ')));
		}
	}
}

//共享方式
function showGrantLogin(obj){
	if($(obj).val()==0){
		$('#grantLoginTr').css('display','');
	    $('#grantLoginNames').attr('class',$('#grantLoginNames').attr('class')+' required');
	}else{
		$('#grantLoginTr').css('display','none');
		
		if($('#grantLoginNames').attr('class').indexOf('required')>-1){
			$('#grantLoginNames').attr('class',$('#grantLoginNames').attr('class').substring(0,$('#grantLoginNames').attr('class').indexOf(' ')));
		}
	}
}

//弹出工号树
function choiceLogins(){
	var qryPara="proId=<%=proId%>&opCode=<%=opCode%>&provinceCode="+$('#provinceCode').val()+'&tellType='+$('#tellType').val();
	openDivWin("<%=request.getContextPath()%>/gotoGetLoginTree.do?"+qryPara,"查询工号信息","400","340");
}

//弹出工号树返回数据
function setLogins(out){
	if($.trim(out)!=''){
		var show=out.substring(out.indexOf(',')+1);
		if(show.lastIndexOf(',')==show.length-1){
			show=show.substring(0,show.length-1);
		}
		$('#grantLoginNames').val(show);
		var chksOpts=show.split(',');
		var logins='';
		for(var i=0;i<chksOpts.length;i++){
			logins=logins+chksOpts[i].substring(0,chksOpts[i].indexOf('（'))+',';
		}
		if(logins.length>0){
			logins=logins.substring(0,logins.length-1);
		}
		$('#grantLogins').val(logins);
	}else{
		$('#grantLoginNames').val('');
		$('#grantLogins').val('');
	}
}

//清空工号集合
function clrLogins(){
	$('#grantLoginNames').val('');
	$('#grantLogins').val('');
}

/////////////////////////////////////////////////
function g(o){
	return document.getElementById(o);
}

</script>
</body>
</html>