<%@ page language="java" import="java.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.sitech.rom.common.dto.RomSysLogin" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>权限管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="popedomForm">
			<div class="input">
				<table>
					<tr>
						<th style="width:10%"><input type="checkbox" id="chkAll" name="chkAll" onclick="checkAllcheckbox()"/></th>
						<th style="width:30%">功能名称</th>
						<th style="width:60%">操作</th>
					</tr>
					<tbody id="tb" style="display:none">
					<c:if test="${popedomBoList!=null}"> 
						<c:forEach items="${popedomBoList}" var="item">
							<tr>
								<td><input type="checkbox" id="chkfunc" name="chkfunc" parent="${item.parentCode}" value="${item.functionCode}" onclick="checkfunc(this,'${item.functionCode}','${item.parentCode}')"/></td>
								<td>${item.functionName}</td>
								<td>
									<c:if test="${item.operArr!=null}">
									    <c:forTokens items="${item.operArr}" delims=";" var="tech">
											${fn:split(tech, "_")[1]}<input type="checkbox" name="chkoper" id="chkoper" parent="${item.functionCode}" value="${item.functionCode}_${fn:split(tech, "_")[0]}" onclick="checkoper(this,'${item.functionCode}')"/>
										</c:forTokens>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
			</div>
			<div id="operation_button">
			    <input type="button" name="su" id="su" onclick="popeSetSubmit('${roleId}')" class="b_foot" value="确定" />
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
	sortTable('0',0);
	$("#tb").html(rtn);
	$("#tb").css('display','');
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
    var chkValues="${popedomForChk}".split(";");
	for(var i=0; i<chkValues.length; i++){
	    if(chkValues[i]!=''){
	        $("input[name='chkfunc'][value='"+chkValues[i]+"']").attr("checked", true);
	        $("input[name='chkoper'][value='"+chkValues[i]+"']").attr("checked", true);
	    }
	}
}

//功能按钮点击
function checkfunc(obj,valueId,parentId){
    if(obj.checked==false){
	    //功能列子节点取消勾选
	    $("input[name='chkfunc'][parent='"+valueId+"']").each(function(){
	        if($(this).attr("checked")==true){
	            $(this).click();
	        }
	    })
        //操作列按钮均取消勾选
        $("input[name='chkoper'][parent='"+valueId+"']").each(function(){
	        $(this).attr("checked",false);
	    })
    }else{
        //功能列子节点取消勾选
	    $("input[name='chkfunc'][parent='"+valueId+"']").each(function(){
	        if($(this).attr("checked")==false){
	            $(this).click();
	        }
	    })
	    //操作列按钮均取消勾选
        $("input[name='chkoper'][parent='"+valueId+"']").each(function(){
	        $(this).attr("checked",true);
	    })
	    
    	//父没选中则选中，但不能click(子全选)
    	if($("input[name='chkfunc'][value='"+parentId+"']").attr("checked")==false){
            fillParent(parentId);
        }
    }
}

//循环勾选父节点
function fillParent(parentId){
	if($("input[name='chkfunc'][value='"+parentId+"']").get(0)){
		$("input[name='chkfunc'][value='"+parentId+"']").attr("checked",true);
		fillParent($("input[name='chkfunc'][value='"+parentId+"']").attr("parent"));
	}
}

//操作按钮点击
function checkoper(obj,parentId){
    if(obj.checked==true && $("input[name='chkfunc'][value="+parentId+"]").attr("checked")==false){
        fillParent(parentId);
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
function popeSetSubmit(roleId){
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
	    
	var packet = new AJAXPacket("<%=request.getContextPath()%>/setPopedom.do");
	packet.data.add("roleId" ,roleId);
	packet.data.add("chkfunc" ,chkfunc);
	packet.data.add("chkoper" ,chkoper);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("roleName" ,"<%=request.getParameter("roleName")%>");
	
	core.ajax.sendPacketHtml(packet,doPopeSet);
	packet =null;
	
}

function doPopeSet(data){
	if(data=='0'){
	    $('#operInfo').html('权限设置成功！');
	}else if(data=='1'){
	    $('#operInfo').html('权限设置异常！');
	}else if(data=='noright'){
		$('#operInfo').html('您没有权限进行此操作！');
	}
	
}
</script>
</body>
</html>