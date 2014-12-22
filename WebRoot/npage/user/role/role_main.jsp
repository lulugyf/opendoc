<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>角色管理</title>
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
					<!--  <tr>
						<th>省份代码</th>
						<td>
							<select name="provinceCode" id="provinceCode">
							 <option value="" ></option>
							<c:if test="${provinceList!=null}"> 
							<c:forEach items="${provinceList}" var="item">
								<option value="${item.provinceCode}" >${item.provinceName}</option>
							</c:forEach>
							</c:if>
							</select>
						</td>
						<th>运营商代码</th>
						<td>
						
							<select name="tellType" id="tellType">
							 <option value="" ></option>
							<c:if test="${tellcorpList!=null}"> 
							<c:forEach items="${tellcorpList}" var="item">
								<option value="${item.tellcorpCode}" >${item.tellcorpName}</option>
							</c:forEach>
							</c:if>
							</select>							
						</td>
					</tr>-->
					<tr>
						<th>产品</th>
						<td>
						    <input type="text" name="productNameShow" id="productNameShow"/>
						    <input type="hidden" name="proCode" id="proCode">（请模糊匹配输入）
						</td>
						<td>&nbsp;</td>
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