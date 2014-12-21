<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>系统功能树</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="mzTree"></div>
<%@ include file="/npage/include/footer.jsp" %>		
</body>
<script src="<%=request.getContextPath()%>/njs/plugins/MzTreeView12.js" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
$(document).ready(function () {
	tree = new MzTreeView("tree");
	tree.setIconPath("<%=request.getContextPath()%>/nresources/<%=themePath%>/images/mztree/");//设置图片路径
	
	with(tree){
		<c:forEach var="item" items="${functionList}">
			N["${item.parentCode}_${item.functionCode}"]="T:${item.functionName};C:parent.setValue('${item.functionCode}')";	
		</c:forEach>
	}
	
	//tree插入相应层
	$('#mzTree').html(tree.toString());
	
});

</script>
</html>