<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>数据连接管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<form name="srchFrm" target="ifm" method="post">
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
<div id="operation">
		<%@ include file="/npage/include/header.jsp"%>
</div>	 
				<table class="myoptable">
					<tr>
						<th>数据库IP</th>
						<td>
							<input type="text" name="serv_ip" id="serv_ip"/>
						</td>
						<th>主机名</th>
						<td>
							<input type="text" name="serv_name" id="serv_name"/>							
						</td>
					</tr>
					<tr>
						<th>主机用户名</th>
						<td>
							<input type="text" name="serv_user" id="serv_user"/>
						</td>
						<th>源数据库类型</th>
						<td>
							<select name="db_type" id="db_type">
						    <option value=""></option>
						    <c:forEach items="${typelist }" var="item">
			   			<option value="${item.dbtype }">${item.dbtype }</option>
			   			</c:forEach>
						    </select>							
						</td>
					</tr>
					<tr>
						<th>数据库名</th>
						<td>
						    <input type="text" name="db_name" id="db_name"/>
						</td>
						<th>数据库端口</th>
						<td><input type="text" name="db_port" id="db_port" onkeyup="value=value.replace(/[^\d]/g,'')"/></td>
					</tr> 
					<tr>
						<th>数据库用户名</th>
						<td><input type="text" name="db_user" id="db_user"/></td>
						</td>
						<th>&nbsp;</th>
						<td>&nbsp;</td>
					</tr>  
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="doSrchReset()"/>&nbsp;&nbsp;
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
//重置查询条件
function doSrchReset(){
	$('#serv_ip').val('');
	$('#serv_name').val('');
	$('#serv_user').val('');
	$('#db_type').val('');
	$('#db_name').val('');
	$('#db_port').val('');
	$('#db_user').val('');
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