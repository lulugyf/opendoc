<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>工号树</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" method=post>
	    <div id="operation_table">			
			<div class="input">	
				<table>
					<tr>
						<td>
							<div id="mzTree"></div>
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="showCheckId('sel')" class="b_foot" value="确定" />
				<input type="button" name="can" onClick="parent.removeDivWin('divWin');" class="b_foot" value="取消" />
			</div>
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>						
</body>

<script language="javascript" src="<%=request.getContextPath()%>/njs/plugins/MzTreeView12.js"></script>	
<script language="javascript" type="text/javascript">
window.onload=function(){
	
	tree = new MzTreeView("tree");
	tree.setIconPath("<%=request.getContextPath()%>/nresources/UI/images/mztree/");//设置图片路径
	var treeExists=',<%=request.getParameter("treeExists")%>,';
	var flag=0;
	with(tree){
		N["0_01"]="T:可选工号树;ctrl:sel;";
		<c:forEach var="item" items="${loginList}">
			if(treeExists.indexOf(',${item.loginNo},')>-1){
				N["01_${item.loginNo}（${item.loginName}）"]="T:${item.loginNo}（${item.loginName}）;ctrl:sel;checked:1;";	
				flag=1;
			}else{
				N["01_${item.loginNo}（${item.loginName}）"]="T:${item.loginNo}（${item.loginName}）;ctrl:sel;";	
			}
		</c:forEach>
		if(flag==1){
			N["0_01"]="T:可选工号树;ctrl:sel;checked:1;";
		}
	}
	tree.expandAll();
	//tree插入相应层
	document.getElementById("mzTree").innerHTML = tree.toString();
}

function showCheckId(id){
    var es=document.getElementsByName(id);
    var out="";
    for(var i=0;i<es.length;i++){
        if (es[i].checked) out+=es[i].value+",";
    }
    parent.setLogins(out);
    parent.removeDivWin('divWin');
}

</script>
</html>