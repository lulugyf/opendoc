<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>参数与用户关联</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="<%=request.getContextPath()%>/nresources/table/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/nresources/table/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/nresources/table/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/common.js"></script>


<script src="<%=request.getContextPath()%>/njs/fancytree/jquery-ui.custom.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/fancytree/jquery.fancytree.js" type="text/javascript"></script>
<link href="<%=request.getContextPath()%>/njs/fancytree/skin-win7/ui.fancytree.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/njs/jqueryui/jquery-ui.css" rel="stylesheet" type="text/css">

</head>
<body>
	<form name="srchFrm" target="ifm" method=post>
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
	</form>
<div id="operation">
		<%@ include file="/npage/include/header.jsp"%>
</div>

<table style="border:0px; width:100%"><tr><td valign="top" style="width:40%">
	<table class="myoptable" >
	
	<tr><th>参数类型:</th><td> <select id="typeselector"><option value=" "/>
      <c:forEach items="${typelist }" var="item">
	   <option value="${item.typeid }">${item.name }(${item.datatype})-${item.remarks}</option>
	  </c:forEach>
	</select> 
	<input id="typesearch" placeholder="searching..." size="6"/>
	</td></tr>
	
	<tr><th>选择工号:</th><td> <select id="loginselector"><option value=""/>
      <c:forEach items="${userlist }" var="item">
	   <option value="${item}">${item}</option>
	  </c:forEach>
	</select> 
	<input id="usersearch" placeholder="searching..." size="6"/>
	</td></tr>
		<tr>
			<td colspan="2" style="text-align:center; align:left">
				<input type="button" class="b_foot" id="editparamuser" value="编 辑 " />
		  </td>
		</tr>
		
		<tr>
			<td colspan="2"> <br/> <b>添加多个工号批量设定关联， 工号原有与本参数的关联数据将被忽略！ </b><br/><br/>
			<label >输入查找：</label> <input id="usersearch1" placeholder="searching..." size="12"/>
<div id="morelogins" style="padding: 5px 5px 10px 10px">
</div>
			</td>
		</tr>
	</table>
	<input type="hidden" id="typeid" />
	<span id="showmessage" style="color:red;display:none"></span>
</td><td valign="top" align="left">
<input type="button" class="b_foot" id="selectall" value="全选"> &nbsp;&nbsp; 
<input type="button" class="b_foot" id="selectnone" value="全取消"> &nbsp;&nbsp; 
<input type="button" class="b_foot" id="saveparamuser"  value="保存"/>
<div id="tree">
		<ul>
			<li id="t_0">Root</li>
		</ul>
</div>
</td></tr></table>



<script type="text/javascript">
var opCode="<%=opCode%>";
var proId="<%=proId%>";



var availableType = [
<c:forEach items="${typelist }" var="item">
	"${item.typeid }-${item.name}",
</c:forEach>
          ''];

var availableUser = [
<c:forEach items="${userlist }" var="item">
	"${item}",
</c:forEach>
          ''];

</script>
<script src="<%=request.getContextPath()%>/npage/rpt/param/paramusr_main.js" type="text/javascript"></script>

</body>

</html>