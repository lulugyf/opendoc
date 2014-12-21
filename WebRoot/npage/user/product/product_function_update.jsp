<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>产品功能管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="popedomForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<div class="input">					
				产品信息：${romProCode.proCode} ${romProCode.proName} ${romProCode.proVersion}
				<table>				
					<tr>
						<th style="width:10%"><input type="checkbox" id="chkAll" name="chkAll" onclick="checkAllcheckbox()"/></th>
						<th >功能名称</th>
					</tr>
					<tbody id="tb" style="display:none">
					<c:if test="${functionList!=null}"> 
						<c:forEach items="${functionList}" var="item">
							<tr>
								<td><input type="checkbox" id="chkfunc" name="chkfunc" parent="${item.parentCode}" value="${item.functionCode}" onclick="checkfunc(this,'${item.functionCode}','${item.parentCode}')"/></td>
								<td>${item.functionName}</td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>
			</div>
			<div id="operation_button">
			    <input type="button" name="su" id="su" onclick="functionSetSubmit('${romProCode.proCode}')" class="b_foot" value="确定" />
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
    var chkValues="${proFunctionForChk}".split(";");
	for(var i=0; i<chkValues.length; i++){
	    if(chkValues[i]!=''){
	        $("input[name='chkfunc'][value='"+chkValues[i]+"']").attr("checked", true);
	    }
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


//功能按钮点击
function checkfunc(obj,valueId,parentId){
    if(obj.checked==false){
	    //功能列子节点取消勾选
	    $("input[name='chkfunc'][parent='"+valueId+"']").each(function(){
	        if($(this).attr("checked")==true){
	            $(this).click();
	        }
	    })
    }else{
        //功能列子节点取消勾选
	    $("input[name='chkfunc'][parent='"+valueId+"']").each(function(){
	        if($(this).attr("checked")==false){
	            $(this).click();
	        }
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


//功能设置
function functionSetSubmit(productCode){
    if(!checksubmit(popedomForm)){
		return false;
	}
	document.popedomForm.action='<%=request.getContextPath()%>/setProductFunction.do?productCode='+productCode;
	document.popedomForm.submit();
}
</script>
</body>
</html>