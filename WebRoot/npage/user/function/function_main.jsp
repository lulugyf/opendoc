<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>系统功能管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" target="ifm" method=post>
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
		<%@ include file="/npage/include/header.jsp"%>
	    
				<input type="hidden" name="functionCode" id="functionCode" />
				<table class="myoptable">
					<tr>
						<td style="width:30%" valign="top">
							<iframe name="ifmTree" id="ifmTree" src="" style="width:100%;height:400px;" frameborder="0"></iframe>
						</td>
						<td valign="top">
							
							<div>
							    <input type="radio" name="switchOper" onclick="changeView(this)" value="view" checked="true"/>查看
								<input type="radio" name="switchOper" style="display:none" onclick="changeView(this)" value="update" /><span id="spanUpdate" style="display:none">修改</span>
								<input type="radio" name="switchOper" style="display:none" onclick="changeView(this)" value="add" /><span id="spanAdd" style="display:none">新增</span>
							</div>
							
					    	<div id="operContent">
					    		<iframe name="ifm" id="ifm" src="" style="width:100%;height:400px;" frameborder="0"></iframe>
					    	</div>
							
					 	</td>
					</tr>
			  </table>
				
			
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>				
</body>
<script src="<%=request.getContextPath()%>/njs/plugins/MzTreeView12.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
$(document).ready(function () {
	getFunctionTree();
});

function getFunctionTree(){
    $('#ifmTree').attr('src','<%=request.getContextPath()%>/getFuncTree.do?proId=<%=proId%>&opCode=<%=opCode%>');
}

//单选按钮切换
function changeView(obj){
    if($(obj).val()=='add'){
        getFuncAdd();
    }
    if($(obj).val()=='view'){
        if($('#functionCode').val()==''){
            $('#ifm').attr('src','');
        }else{
            getFuncView($('#functionCode').val());
        }
    }if($(obj).val()=='update'){
        if($('#functionCode').val()==''){
            $('#ifm').attr('src','');
        }else{
            getFuncUpdate($('#functionCode').val());
        }
    }
}

//点击菜单节点触发事件
function setValue(functionCode){
		var op='';
    $("input[name='switchOper']").each(function(){
        if($(this).attr("checked")==true){
            op=$(this).val();
        }
    });
    
    $('#functionCode').val(functionCode);
    
    if(op=='view'){
        getFuncView(functionCode);
    }
    if(op=='update'){
        getFuncUpdate(functionCode);
    }
}

function resetValue(){
		$('#functionCode').val('');
		$('#ifm').attr('src','');
}

function getFuncView(functionCode){
	$('#ifm').attr('src','<%=request.getContextPath()%>/getFuncDetail.do?proId=<%=proId%>&opCode=<%=opCode%>&functionCode='+functionCode+param);
}
function getFuncAdd(){
	$('#ifm').attr('src','<%=request.getContextPath()%>/gotoFuncAdd.do?proId=<%=proId%>&opCode=<%=opCode%>');
}
function getFuncUpdate(functionCode){
	$('#ifm').attr('src','<%=request.getContextPath()%>/gotoFuncUpdate.do?proId=<%=proId%>&opCode=<%=opCode%>&functionCode='+functionCode);
}


/***********显示隐藏功能权限对应按钮 begin***************/
$(document).ready(function () {
    getOpersForPage(); 
});
var param='';
function getOpersForPage(){
	var opersForPage = '${opersForPage}';
    if(opersForPage!='' && opersForPage!='NULL'){
        	var opers = opersForPage.split(':')[1].split(';');
        	for(var i=0; i<opers.length; i++){
            if(opers[i]=='1'){
                $("input[name='switchOper'][value='add']").eq(0).css('display','');
                $('#spanAdd').css('display','');
            }else if(opers[i]=='2'){
                $("input[name='switchOper'][value='update']").eq(0).css('display','');
                $('#spanUpdate').css('display','');
            }else if(opers[i]=='3'){
            		param='&del=Y';
            }
          }
        
    }
}
/***********显示隐藏功能权限对应按钮 end***************/

</script>
</html>