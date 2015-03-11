<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>角色管理</title>
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
	<form name="srchFrm" target="ifm" method=post>
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<input type=hidden name="pageNum" id="pageNum" value="1">
<div id="operation" class="bb_right_cont1">
      <div height="12"><table><tr height="12"></tr></table> </div>
      				<table width="100%" border="0" cellspacing="2" cellpadding="0"  bgcolor="#FFFFFF">
					<tr>
          				<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">产品：</td>
						<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:10px;">
						    <input type="text" name="productNameShow" id="productNameShow" v_maxlength="64" v_minlength="0" class="anc"/>
						    <input type="hidden" name="proCode" id="proCode" v_maxlength="64" v_minlength="0" class="anc">（请模糊匹配输入）
						</td>
					</tr> 
      				<tr height="12"></tr>
 					<tr>
						<td height="32" align="center" class="blue" colspan="2">
				            <input name="" type="button" class="bb_right_sub1" value="查  询" onclick="doSrchSubmit()"/>&nbsp;&nbsp;&nbsp;
				            <input name="" type="button" class="bb_right_sub1" value="重  置" onclick="doReset()"/>&nbsp;&nbsp;&nbsp;
							<input name="" type="button" class="bb_right_sub1" id="add" value="新  增" onclick="addM()"/>
					  </td>
					</tr>
				</table>

			<iframe name="ifm" src="" style="width:100%;height:400px;" frameborder="0"></iframe>
		</div>
	</form>
					
</body>
<!-- 自动补全引入js -->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/myactb.js"></script>
<script src="<%=request.getContextPath()%>/npage/rpt/task/task.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>
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
    if($.trim($('#productNameShow').val())==''){
    	$('#proCode').val('');
    }
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/roleList.do"+param;
    document.forms['srchFrm'].submit();
}
//增加关联模块，打开弹出窗口
function addM(){
	openDivWin("<%=request.getContextPath()%>/gotoAddRole.do?proId=<%=proId%>&opCode=<%=opCode%>","新增角色","800","300");
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

/***********产品自动补全 begin***************/
function Product(sName,sNo){	  
	this.productName = sName;		
	this.productCode=sNo;
	this.label=this.productName+" "+this.productCode;
}

var products=new Array();

<c:forEach var="item" items="${productList}">
	products.push(
	new Product("<c:out value="${item.proName}"/>","<c:out value="${item.proCode}"/>"));		
</c:forEach>

	var searchArr=[];
for(var i=0;products&&i<products.length;i++){
	searchArr.push(products[i].label);
}

function doReset(){
	$('#productNameShow').val('');
}

var obj = new actb(document.getElementById('productNameShow'),searchArr,handerProduct);
//obj.actb_startcheck=2; //用户输入2个字符才开始提示(根据输入模糊查询并显示产品)
//obj.actb_fSize = '14px';
function handerProduct(text){
	var foundProduct=null;
	for(var i=0;products&&i<products.length;i++){
		if(products[i] && text==products[i].label){
			foundProduct=products[i];
				break;
		}
	}

	if(foundProduct){
		document.getElementById('proCode').value = foundProduct.productCode;
		document.getElementById('productNameShow').value = foundProduct.label;		
	}else{
		document.getElementById('proCode').value = "";
	}
	
}
/***********产品自动补全 end***************/
</script>
</html>