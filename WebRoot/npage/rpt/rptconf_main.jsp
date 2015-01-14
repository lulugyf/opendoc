<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>报表参数管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	

<script type="text/javascript" src="<%=request.getContextPath()%>/nresources/table/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/common.js"></script>

<script src="<%=request.getContextPath()%>/njs/fancytree/jquery-ui.custom.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/fancytree/jquery.fancytree.js" type="text/javascript"></script>
<link href="<%=request.getContextPath()%>/njs/fancytree/skin-win7/ui.fancytree.css" rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/nresources/table/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
  <link href="<%=request.getContextPath()%>/njs/jqueryui/jquery-ui.css" rel="stylesheet" type="text/css">
  

</head>
<body>
	
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
<div id="operation">
		<%@ include file="/npage/include/header.jsp"%>
</div>	 



<script type="text/javascript">
var opCode="<%=opCode%>";
var proId="<%=proId%>";


var availableLogin = [
<c:forEach items="${loginlist }" var="item">
	"${item }",
</c:forEach>
          ''];

$(function(){
	btnHover();//主按钮鼠标经过样式

	
});

</script>

<div id="addtypediv" style="display:none; border:1px dotted gray">
<input type="hidden" id="opCode" value="${opCode }" />
<input type="hidden" id="typeid1" value='0' />

<div class="optable">
<table width="100%">
<tr><th>类型名称：</th><td> <input type="text" id="name1"></td></tr>
<tr><th>数据类型： </th><td> <select id="datatype1">${datatypelist }</select> </td></tr>
<tr><th>备 注：</th><td> <input type="text" id="remarks1"></td></tr>
<tr><td colspan="2" align="center"> <input type="button" class="b_foot" id="subtype1" value="确定"></td></tr>
</table>
</div>
</div>

<table style="border:0px; width:100%">
<tr><td style="width:300px" valign="top" rowspan='3'>
<div id="tree">
	<ul></ul>	
</div>
<div style="width:300px" align="right">

<input type="button" class="b_foot" id="addGroup" value="添加分组">
<input type="button" class="b_foot" id="modGroup" value="修改分组">
<input type="button" class="b_foot" id="delGroup" value="删除分组">
<br/>
<br/>
<div id="gname" style="display:none" > <label for="groupname">分组名称:</label><input type="text" id="groupname" />
<input type="button" onclick="editgroupname()" value="ok"/> </div>
</div>

</td><td valign="top">

<table width="100%" height="100%" class="myoptable">
<tr><th>报表名称：    </th><td> <input type="hidden" id="docid" value="0">
					<input type="text" id="docname"></td></tr>
<tr style="display:none"><th>URL： </th><td> <input type="text" size="60" id="baseurl"> </td></tr>
<tr><th>文档ID： </th><td> <input type="text" size="60" id="opendocid"> </td></tr>
<tr><th>BO服务器： </th><td> <select id="boid">
<c:forEach items="${bolist }" var="item">
  	<option value="${item.boid }">${item.boname }</option>
</c:forEach>
</select> </td></tr>
<tr><th>备 注：</th><td> <input type="text" id="remarks"></td></tr>
<tr><th>功能代码：</th><td> <span id="function_code" title="自动生成" ></span></td></tr>
<tr><td colspan="2"> 
	<input type="button" class="b_foot" id="addrpt" value="添加">
	<input type="button" class="b_foot" id="modrpt" value="修改">
	<input type="button" class="b_foot" id="delrpt" value="删除">
</td></tr>

</table>


</td></tr>
<tr><td valign="top" >
<div style="display:none" id="docparam">
<table style="width:100%" class="myoptable" >
<input type="hidden" id="paramid" />
<input type="hidden" id="docid" />
<tr><th>参数名称类型： </th><td> <select id="pnametype">
			   			<option value="lsS">单值</option>
			   			<option value="lsM">多值</option>
			   			<option value="lsR">范围</option>
						</select> 
					</td></tr>
<tr><th>参数名称：    </th><td> <input type="text" id="param"></td></tr>
<tr><th width="15%">参数默认值： </th><td> <input type="text" id="default_value" /> </td></tr>
<tr><th>参数类型： </th><td><select name="typeid" id="typeid">
					<option value="0">[手工输入]</option>
						    <c:forEach items="${paramtypelist }" var="item">
			   			<option value="${item.typeid }">${item.name }</option>
			   				</c:forEach>
						</select> 
			   		</td></tr>
<tr><th>是否过滤： </th><td> <select id="filterflag">
			   			<option value="1">yes</option>
			   			<option value="0">no</option>
						</select> 
					</td></tr>
<tr><th>是否允许修改： </th><td> <select id="allowchange">
			   			<option value="1">yes</option>
			   			<option value="0">no</option>
						</select> 
					</td></tr>
<tr><th>备 注：</th><td> <input type="text" id="paramremarks" /></td></tr>
<tr><td colspan="2"> 
	<input type="button" class="b_foot" id="adddocparam" value="添加">
	<input type="button" class="b_foot" id="moddocparam" value="修改">
	<a href="#" onclick="$('#docparam').hide()">hide</a>
</td></tr>
<tr><td valign="top" colspan="2">

</td></tr>
</table>
</div>

<input type="hidden" id="rownum" value=""/>
		<table id="datatable" class="myoptable" width="90%" cellspacing="0">
		<tr>
			<td>参数名称类型</td><td>参数名称</td><td>参数默认值</td><td>参数类型</td><td>是否过滤</td>
			<td>是否可改</td><td><input type="button" class="b_foot" onclick="$('#docparam').show()" value="添加参数" /></td></tr>
		</table>
		
</td></tr>
<tr><td colspan="2"><span id="showmessage" style="color:red;display:none"></span></td></tr>
</table>
		
<div id="dialog-form" title="参数与工号关联例外设置">
<label for="login_no_name">工号：</label> <input id="login_no_name"> 输入工号部分字符模糊匹配<br/>
<input type="hidden" id="login_no" />
<input type="hidden" id="param_typeid" />
  <div id="paramtree"><ul></ul></div>
</div>

<script src="<%=request.getContextPath()%>/npage/rpt/rptconf_main.js" type="text/javascript"></script>
</body>


</html>