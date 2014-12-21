<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>查询主机信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" target="ifm" method=post>
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
	
	with(tree){
		N["0_01"]="T:主机树";
		
		<c:forEach var="item" items="${hostList}">
			N["01_${item.hostId}"]="T:${item.hostIp};C:setValue('${item.hostId}','${item.hostIp}')";	
		</c:forEach>
		
		
	}
	//tree插入相应层
	document.getElementById("mzTree").innerHTML = tree.toString();
}

function setValue(hostId,hostIp){
	parent.setHost(hostId,hostIp);
	closeDivWin();
}

</script>
</html>