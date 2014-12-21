<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>工单监控结果</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/demo/charts/JSClass/FusionCharts.js"></script>
</head>
<body>

<div id="chartdiv" class="chartdiv"></div>

<%@ include file="/npage/include/footer.jsp"%>
</body>
<script>
var dataXml = decodeURIComponent("${dataXml}");
uif.generateChartsByXml('<%=request.getContextPath()%>/npage/demo/charts/Charts/ScrollLine2D.swf',dataXml,'chartdiv',790,450);
</script>
</html>