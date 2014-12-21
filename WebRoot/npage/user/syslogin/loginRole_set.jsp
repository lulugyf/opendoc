<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">角色列表</div></div>  
<div class="list">
	<form action="" method="post" name="popedomForm">
	<table id="mTable">
		<tr>
			<th style="width:10%"><input type="checkbox" id="chkAll" name="chkAll" onclick="checkAllcheckbox()"/></th>
			<th>角色名称</th>			
			<th>角色类别</th>		
			<th>所属产品</th>	
			<th>省份</th>
			<th>运营商类型</th>

		</tr>
					<tbody id="tb" >
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
	</table>
</div>
			<div id="operation_button">
			    <input type="button" name="su" id="su" onclick="functionSetSubmit('${romProCode.proCode}')" class="b_foot" value="确定" />
				<input type="button" name="close" id="close" onclick="parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
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
