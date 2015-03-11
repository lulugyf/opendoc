<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<script src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" type="text/javascript"></script>

</head>
<body>

<script language="Javascript">
$(document).ready(function(){
<c:choose>
<c:when test="${isLoginSucc == true}">
	document.location = 'xpage/main.jsp';//'npage/login/main1.jsp';'xpage/main.jsp'
</c:when>
<c:otherwise>
	alert("对不起，您输入的工号不存在或工号密码不匹配！");
	document.location = 'npage/login/login.htm'; 
</c:otherwise>
</c:choose>

});
</script> 

</body>
</html>
