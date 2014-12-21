<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.sitech.rom.common.dto.RomSysLogin" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>设置条目与脚本关系</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="popedomForm">
			<div class="input">
				${romMaintainItems.itemName} ${romMaintainItems.itemDesc}
				<table>
					<tr>
						<th style="width:10%"><input type="checkbox" id="chkAll" name="chkAll" onclick="checkAllcheckbox()"/></th>
						<th style="width:30%">功能名称</th>
						<th style="width:60%">操作</th>
					</tr>
					<tbody id="tb" >
					<c:if test="${scriptList!=null}"> 
						<c:forEach items="${scriptList}" var="item">
							<tr>
								<td><input type="checkbox" id="chkfunc" name="chkfunc" value="${item.scriptsId}" onclick="checkfunc(this,'${item.scriptsId}')"/></td>
								<td>${item.scriptsDir}${item.scriptsName}</td>
								<td>
									<c:if test="${actionList!=null}">
										<c:forEach items="${actionList}" var="actionitem">
											${actionitem.actionName}<input type="checkbox" id="chkoper" name="chkoper" parent="${item.scriptsId}" value="${item.scriptsId}_${actionitem.actionId}" onclick="checkoper(this,'${item.scriptsId}')">
										</c:forEach>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
			</div>
			<div id="operation_button">
			    <input type="button" name="su" id="su" onclick="popeSetSubmit('${romMaintainItems.itemId}')" class="b_foot" value="确定" />
				<input type="button" name="re" id="re" onclick="chkInit()" class="b_foot" value="重置" />
				<input type="button" name="close" id="close" onclick="parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
			</div>
			<div align="center">
			    <font color="red"><span id="operInfo">${operInfo}</span></font>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>
$(document).ready(function () {
	/**
	sortTable('0',0);
	$("#tb").html(rtn);
	$("#tb").css('display','');
	**/
	chkInit();
});

//表格排序&补空格
var rtn="";
function sortTable(initId,deep){
    $("input[name='chkfunc']").each(function(){
        if($(this).attr("parent")==initId){
            for(var i=0; i<=deep; i++){
		        $(this).parent().prepend("&nbsp;&nbsp;&nbsp;");
		    }
            rtn = rtn + "<tr>"+ $(this).parent().parent().html() +"</tr>";
            sortTable($(this).val(),deep+1);
        }
    });
}

//初始勾选
function chkInit(){
    $(":checkbox").each(function(){
        $(this).attr("checked",false);
    });
    var chkValues="${itemScriptActionForChk}".split(";");
	for(var i=0; i<chkValues.length; i++){
	    if(chkValues[i]!=''){
	    	//由于itemScriptActionForChk包括所有chkfunc、chkoper的值，因此，不进行区分，都需要执行。
	        $("input[name='chkfunc'][value='"+chkValues[i]+"']").attr("checked", true);
	        $("input[name='chkoper'][value='"+chkValues[i]+"']").attr("checked", true);
	    }
	}
}

//功能按钮点击
function checkfunc(obj,valueId,parentId){
    if(obj.checked==false){
        //操作列按钮均取消勾选
        $("input[name='chkoper'][parent='"+valueId+"']").each(function(){
	        $(this).attr("checked",false);
	    })
    }else{
		//不处理
    }
}

//操作按钮点击
function checkoper(obj,parentId){
    if(obj.checked==true && $("input[name='chkfunc'][value="+parentId+"]").attr("checked")==false){
        $("input[name='chkfunc'][value="+parentId+"]").click();
    }
}

//全选
function checkAllcheckbox() {
    try {
        var b = $(":checkbox");
        for (var a = 0; a < b.length; a++) {
            if ($("input[id='chkAll']")[0].checked) {
                b[a].checked = true
            } else {
                b[a].checked = false
            }
        }
    } catch(c) {}
}


//权限设置
function popeSetSubmit(itemId){
    if(!checksubmit(popedomForm)){
		return false;
	}
	var chkfunc='';
	var chkoper='';
	//功能列子节点
	$("input[name='chkfunc']").each(function(){
        if($(this).attr("checked")==true){
        	chkfunc=chkfunc+$(this).val()+',';
        }
    })
    //操作列按钮
    $("input[name='chkoper']").each(function(){
        if($(this).attr("checked")==true){
            chkoper=chkoper+$(this).val()+',';
        }
    })
	    
	var packet = new AJAXPacket("<%=request.getContextPath()%>/setProcItemScript.do");
	packet.data.add("itemId" ,itemId);
	packet.data.add("chkfunc" ,chkfunc);
	packet.data.add("chkoper" ,chkoper);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=request.getParameter("provinceCode")%>');
	packet.data.add("tellType" ,'<%=request.getParameter("tellType")%>');
	core.ajax.sendPacketHtml(packet,doPopeSet);
	packet =null;
	
}

function doPopeSet(data){
	if(data=='0'){
	    $('#operInfo').html('条目设置成功！');
	}else if(data=='1'){
	    $('#operInfo').html('条目设置异常！');
	}else if(data=='noright'){
		$('#operInfo').html('您没有权限进行此操作！');
	}
	
}
</script>
</body>
</html>
