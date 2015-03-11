<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<html>
<head>
<title>产品功能管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="style/conf_style.css"/>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/menu_min.js"></script>
<script>  
//加载时适应浏览器高度
$(document).ready(function() {
    //模块尺寸  
	$('.pz_menu').css('height', $(window).height() - 141); 
	$('.pz_cont_wiap100').css('height', $(window).height() - 10); 
})
//改变窗体大小时适应浏览器高度
$(window).resize(function() {
    //模块尺寸
	$('.pz_menu').css('height', $(window).height() - 141);
	$('.pz_cont_wiap100').css('height', $(window).height() - 250);
});
</script>
<script type="text/javascript">
$(document).ready(function (){ 
  
  $(".pz_menu_cont ul li").menu();
  
}); 
</script>
</head>
<body>
   <div id="operation" class="bb_right_cont1">
	<div id="operation_table">
		<form action="" method="post" name="popedomForm">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<div class="input">					
				&nbsp;产品信息：${romProCode.proCode} ${romProCode.proName} ${romProCode.proVersion}
				<table width="100%" border="0" cellSpacing="2" cellpadding="0" bgcolor="#FFFFFF">				
					<tr class="f14 white">
						<td width="6%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;"><input type="checkbox" id="chkAll" name="chkAll" onclick="checkAllcheckbox()"/></td>
						<td width="40%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">功能名称</td>
					</tr>
					<tbody id="tb" height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
					<c:if test="${functionList!=null}"> 
						<c:forEach items="${functionList}" var="item">
							<tr>
								<td><input type="checkbox" id="chkfunc" name="chkfunc" parent="${item.parentCode}" value="${item.functionCode}" onclick="checkfunc(this,'${item.functionCode}','${item.parentCode}')"/></td>
								<td>${item.functionName}</td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
      				<tr height="12"></tr>
					<tr>
			          <td height="32" align="center" class="blue" colspan="6">
			            <input name="su" type="button" class="bb_right_sub1" value="确  定" onclick="functionSetSubmit('${romProCode.proCode}')"/>&nbsp;&nbsp;&nbsp;
			            <input name="re" type="button" class="bb_right_sub1" value="重  置" onclick="chkInit()"/>&nbsp;&nbsp;&nbsp;
						<input name="close" type="button" class="bb_right_sub1" value="关  闭" onclick="parent.doSrchSubmit();parent.removeDivWin('divWin');"/>
						</td>
			        </tr>
				</table>
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