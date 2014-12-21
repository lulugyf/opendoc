<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>数据连接管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<form name="srchFrm" target="ifm" method=post>
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
<div id="operation">
		<%@ include file="/npage/include/header.jsp"%>
</div>	 
				<table class="myoptable">
					<tr>
						<th>数据库标签</th>
						<td>
							<input type="text" name="label" id="label"/>
						</td>
						<th>主机</th>
						<td>
							<input type="text" name="host" id="host"/>							
						</td>
					</tr>
					<tr>
						<th>连接用户</th>
						<td>
						    <input type="text" name="user" id="user"/>
						</td>
						<th>数据库名称</th>
						<td><input type="text" name="db" id="db"/></td>
					</tr> 
					<tr>
						<th>类型</th>
						<td>
						    <select name="dbtype" id="dbtype">
						    <option value=""></option>
						    <c:forEach items="${typelist }" var="item">
			   			<option value="${item.dbtype }">${item.dbtype }</option>
			   			</c:forEach>
						    </select>
						</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
					</tr>  
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="javascript:document.forms('srchFrm').reset();"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" id="add" style="display:none" value="新增" onclick="addM()"/>
					  </td>
					</tr>
				</table>

			<iframe name="ifm" src="" style="width:100%;height:400px;" frameborder="0"></iframe>
			
			 
			 	

		<%@ include file="/npage/include/footer.jsp" %>
	</form>
						
</body>
<!-- 自动补全引入js -->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/myactb.js"></script>

<script language="javascript" type="text/javascript">
/***********显示隐藏功能权限对应按钮 begin***************/
$(document).ready(function () {
    getOpersForPage();
});

var param='?';
function getOpersForPage(){
	var opersForPage = '${opersForPage}';
    if(opersForPage!='' && opersForPage!='NULL'){
        var opers = opersForPage.split(':')[1].split(';');
        for(var i=0; i<opers.length; i++){
            if(opers[i]=='1'){
                $('#add').css('display','');
            }else if(opers[i]=='2'){
                param=param+'edit=Y&';
            }else if(opers[i]=='3'){
                param=param+'del=Y&';
            }else if(opers[i]=='4'){
                param=param+'pope=Y&';
            }
        }
    }
}
/***********显示隐藏功能权限对应按钮 end***************/

//查询表单提交
function doSrchSubmit(){
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/dbconnsList.do"+param;
    document.forms['srchFrm'].submit();
}
//增加关联模块，打开弹出窗口
function addM(){
	openDivWin("<%=request.getContextPath()%>/gotoAddDBConn.do?proId=<%=proId%>&opCode=<%=opCode%>","新增数据库配置","800","300");
	refreshByClose();
}
//list页面弹出窗口的关闭事件执行
function refreshByClose(){
    $(".window .close:last").click(function(){
		try{
		    doSrchSubmit();
	    }catch(e){}
	});
}


</script>
</html>