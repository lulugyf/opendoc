<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<head>
<title>设置工号角色关系</title>
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
	<div class="input">
	<table id="mTable" width="100%" border="0" cellSpacing="2" cellpadding="0" bgcolor="#FFFFFF">
		<tr class="f14 white">
			<td width="2%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;"><input type="checkbox" id="chkAll" name="chkAll" onclick="checkAllcheckbox()"/></td>
			<td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">角色名称</td>
			<td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">角色类别</td>
			<td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">所属产品</td>
			<td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">省份</td>
			<td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">备注</td>

		</tr>
					<tbody id="tb" height="32" align="left" bgcolor="#f6f6f6" style="text-indent:10px;">
					<c:if test="${roleList!=null}"> 
						<c:forEach items="${roleList}" var="item">
							<tr>
								<td><input type="checkbox" id="chkrole" name="chkrole" value="${item.roleId}" /></td>
								<td>${item.roleName}</td>
								<td>
									<c:choose>
								       <c:when test="${item.roleType=='1'}">							
								             普通管理员								
								       </c:when>
								       <c:otherwise>								
								              超级管理员								
								       </c:otherwise>       									
									</c:choose>									
								</td>
								<td>${item.proName}</td>
								<td>${item.provinceName}</td>
								<td>${item.tellcorpName}</td>
								
							</tr>
						</c:forEach>
					</c:if>
					</tbody> 
      				<tr height="12"></tr>
					<tr>
			          <td height="32" align="center" class="blue" colspan="6">
			            <input name="su" type="button" class="bb_right_sub1" value="确  定" onclick="functionSetSubmit('${romProCode.proCode}')"/>&nbsp;&nbsp;&nbsp;
						<input name="close" type="button" class="bb_right_sub1" value="关  闭" onclick="parent.removeDivWin('divWin');""/>
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
 </body>
 
<script language="javascript" type="text/javascript">
$(document).ready(function () {
 chkInit();
});
 

//初始勾选
function chkInit(){
    $(":checkbox").each(function(){
        $(this).attr("checked",false);
    });
    var chkValues="${loginRoleForChk}".split(";");
	for(var i=0; i<chkValues.length; i++){
	    if(chkValues[i]!=''){
	        $("input[name='chkrole'][value='"+chkValues[i]+"']").attr("checked", true);
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


//功能设置
function functionSetSubmit(productCode){
    if(!checksubmit(popedomForm)){
		return false;
	}
	document.popedomForm.action='<%=request.getContextPath()%>/setLoginRole.do?proId=<%=proId%>&opCode=<%=opCode%>&loginNo='+"${loginNo}";
	document.popedomForm.submit();
}
</script>
</html>
