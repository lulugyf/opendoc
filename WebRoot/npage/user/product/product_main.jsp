<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>产品功能管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" target="ifm" method=post>
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<%@ include file="/npage/include/header.jsp"%>
	
				<table class="myoptable">
					<tr>
						<th>产品代码：</th>
						<td>
							<input type="text" name="proCode" id="proCode" >
						</td>
						<th>产品名称：</th>
						<td>
							<input type="text" name="proName" id="proName" >
						</td>			
					</tr>
 
					<tr>
						<td colspan="4" style="text-align:center">
							<input type="button" class="b_foot" value="查询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" value="重置" onclick="reset()"/>&nbsp;&nbsp;
							<input type="button" class="b_foot" id="add" style="display:none" value="新增" onclick="addM()"/>							
 					  </td>
					</tr>
				</table>				
			
			
			<iframe name="ifm" src="" style="width:100%;height:400px;" frameborder="0"></iframe>
			 	
		
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>						
</body>

<!-- 自动补全引入js -->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/myactb.js"></script>
<!--autocomplete.js不支持参数是自定义函数的处理方式.
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/autocomplete.js"></script>
-->
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
            }
        }
    }
}
/***********显示隐藏功能权限对应按钮 end***************/
 
//查询表单提交
function doSrchSubmit(){
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/productList.do"+param;
    document.forms['srchFrm'].submit();
}
 
//增加关联模块，打开弹出窗口
function addM(){
	openDivWin("<%=request.getContextPath()%>/gotoAddProduct.do?proId=<%=proId%>&opCode=<%=opCode%>","新增产品","800","200");
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

function reset(){
	$('#productNameShow').val();
	$('#productCode').val();
	
}
</script>
</html>