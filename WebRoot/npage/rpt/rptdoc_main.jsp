<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>报表展示</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <link href="<%=request.getContextPath()%>/njs/jqueryui/jquery-ui.css" rel="stylesheet" type="text/css">
</head>
<body style="border:0px solid #ff0000" onresize="resizebody()">
	<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
	<input type=hidden name="proId" id="proId" value="<%=proId%>">
 


<script type="text/javascript" src="<%=request.getContextPath()%>/nresources/table/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/common.js"></script>


<!--  for fancytree -->
<script src="<%=request.getContextPath()%>/njs/fancytree/jquery-ui.custom.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/fancytree/jquery.fancytree.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/fancytree/jquery.fancytree.filter.js" type="text/javascript"></script>
<link href="<%=request.getContextPath()%>/njs/fancytree/skin-win7/ui.fancytree.css" rel="stylesheet" type="text/css">


<script type="text/javascript">
var opCode="<%=opCode%>";
var proId="<%=proId%>";
var loginno="${login_no}";
var paramcount = "${paramCount}";

</script>


<input type="hidden" id="opCode" value="${opCode }" />
<input type="hidden" id="typeid1" value='0' />

<input type="hidden" id="docid" value="${doc.docid}" />


<script type="text/javascript" src="<%=request.getContextPath()%>/njs/jspanel/jquery.jspanel.js"></script>
<link href="<%=request.getContextPath()%>/njs/jspanel/jquery.jspanel.css" rel="stylesheet" type="text/css">


<div class=".panel-body"></div>

<div  class="content" style="display:none">

	
<span id="showmessage" style="color:red;display:none"></span>

<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
  
<div class="list11">
	<table id="mTable1">
		<tr>
			<th>参数</th>
			<th>类型</th>
			<th>默认值</th>
			<th>设定值</th>
		</tr>
		<c:forEach items="${paramlist }" var="p">
		<tr <c:if test="${p.allowchange == 0 }">style="display:none"</c:if>>
			<td>${p.pnametype }${p.param }</td><td>${p.typename }</td><td>${p.default_value }</td>
			<td><input type="text" class="param" id="P_${p.pnametype }${p.param }" value="${p.default_value }" <c:if test="${p.typeid > 0 }">readonly</c:if> />
			  <button onclick="selParam('${p.pnametype }${p.param }', ${p.typeid}, ${p.filterflag })" class="b_foot">...</button></td>
		</tr>
		</c:forEach>
	</table>
</div>
</div>
</div>

<form method="post" id="formdoc" action="${doc.baseurl }" target="rptbody">
<div style="display:none">
<textarea type="hidden" name="serSes">${serSession }</textarea>
</div>
<c:forEach items="${paramlist }" var="p">
	<input type="hidden" name="${p.pnametype }${p.param }" id="${p.pnametype }${p.param }" />
</c:forEach>
<table style="border:false; width:100%"><tr><td align="center">
<input type="submit" class="b_foot" value="确定">
</td></tr></table>
</form>
</div>

<div class="b" style="position: absolute;left:0px;top:0px;z-index:-1">
  <iframe align="left" name="rptbody" id="rptbody" src="npage/public/blank_block.html" frameborder="0" scrolling="yes" style="width:100%;height:100%;overflow:scrolling">
		</iframe>  
</div>

<style>
.ui-dialog {
	z-index: 1000;
}
</style>
<div id="dialog-form" title="参数值选择">
  <label>过滤:</label>
    <input name="search" placeholder="Filter...">
    <button id="btnResetSearch">&times;</button>

  <div id="tree"><ul></ul></div>
</div>

<script src="<%=request.getContextPath()%>/npage/rpt/rptdoc_main.js" type="text/javascript"></script>


</body>
</html>