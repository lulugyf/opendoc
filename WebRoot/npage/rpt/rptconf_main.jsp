<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>报表参数管理</title>
<link rel="stylesheet" type="text/css" href="style/page_style.css"/>
<link rel="stylesheet" type="text/css" href="style/Font_style.css"/>
<link rel="stylesheet" type="text/css" href="style/frame_style.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css"> 
body {
font-size: 12px;
color: #333;
font-family: "微软雅黑", Arial, Helvetica, sans-serif;
}
</style> 	

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
<div style="height:10px"></div>
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

<input type="button" class="bb_right_sub1" id="addGroup" value="添加分组">
<input type="button" class="bb_right_sub1" id="modGroup" value="修改分组">
<input type="button" class="bb_right_sub1" id="delGroup" value="删除分组">
<br/>
<br/>
<div id="gname" style="display:none" > <label for="groupname">分组名称:</label><input type="text" id="groupname" />
<input type="button" onclick="editgroupname()" value="ok"/> </div>
</div>

</td><td valign="top">

<table width="95%" border="0" cellspacing="2" cellpadding="0"  bgcolor="#FFFFFF">
<tr>
	<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">报表名称：    </td>
	<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
		<input type="hidden" id="docid" value="0">
		<input type="text" id="docname" style="width:300px;height:24px">
	</td>
</tr>
<tr style="display:none"><th>URL： </th><td> <input type="text" size="60" id="baseurl"> </td></tr>
<tr>
	<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">文档ID： </td>
	<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
		<input type="text" size="60" id="opendocid" style="width:300px;height:24px"> 
	</td>
</tr>
<tr>
	<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">BO服务器： </td>
	<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
		<select id="boid" style="width:305px;height:28px">
		<c:forEach items="${bolist }" var="item">
		  	<option value="${item.boid }">${item.boname }</option>
		</c:forEach>
		</select> 
	</td>
</tr>
<tr>
	<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">备 注：</td>
	<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
		<input type="text" id="remarks" style="width:300px;height:24px">
	</td>
</tr>
<tr>
	<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">功能代码：</td>
	<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
		<span id="function_code" title="自动生成" >
		</span>
	</td>
</tr>
<tr><td colspan="2"  height="32" align="center" class="blue"> 
	<input type="button" class="bb_right_sub1" id="addrpt" value="添加">&nbsp;&nbsp;&nbsp;
	<input type="button" class="bb_right_sub1" id="modrpt" value="修改">&nbsp;&nbsp;&nbsp;
	<input type="button" class="bb_right_sub1" id="delrpt" value="删除">
</td></tr>

</table>


</td></tr>
<tr><td valign="top" >
<div style="display:none" id="docparam">
<table width="95%" border="0" cellspacing="2" cellpadding="0"  bgcolor="#FFFFFF">
<input type="hidden" id="paramid" />
<input type="hidden" id="docid" />
<tr>
	<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">参数名称类型： </td>
	<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
		<select id="pnametype" style="width:305px;height:24px">
			<option value="lsS">单值</option>
			<option value="lsM">多值</option>
			<option value="lsR">范围</option>
		</select> 
	</td>
</tr>
<tr>
	<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">参数名称：</td>
	<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
		<input type="text" id="param" style="width:300px;height:24px"/>
	</td>
</tr>
<tr>
	<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">参数默认值： </td>
	<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
		<input type="text" id="default_value" style="width:300px;height:24px"/> 
	</td>
</tr>
<tr>
	<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">参数类型： </td>
	<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
		<select name="typeid" id="typeid" style="width:305px;height:24px">
			<option value="0">[手工输入]</option>
				<c:forEach items="${paramtypelist }" var="item">
					<option value="${item.typeid }">${item.name }</option>
				</c:forEach>
		</select> 
	</td>
</tr>
<tr>
	<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">是否过滤： </td>
	<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
		<select id="filterflag" style="width:305px;height:24px">
			<option value="1">是</option>
			<option value="0">否</option>
		</select> 
	</td>
</tr>
<tr>
	<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">是否允许修改： </td>
	<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
		<select id="allowchange" style="width:305px;height:24px">
			<option value="1">是</option>
			<option value="0">否</option>
		</select> 
	</td>
</tr>
<tr>
	<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">备 注：</td>
	<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
		<input type="text" id="paramremarks" style="width:300px;height:24px"/>
	</td>
</tr>
<tr>
	<td height="32" align="center" class="blue" colspan="2"> 
		<input type="button" class="bb_right_sub1" id="adddocparam" value="添加">&nbsp;&nbsp;&nbsp;
		<input type="button" class="bb_right_sub1" id="moddocparam" value="修改">&nbsp;&nbsp;&nbsp;
		<input type="button" class="bb_right_sub1" value="隐藏" onclick="$('#docparam').hide()">
		<!--<a href="#" onclick="$('#docparam').hide()">隐藏</a>  -->
	</td>
</tr>
<tr><td valign="top" colspan="2">

</td></tr>
</table>
</div>

<input type="hidden" id="rownum" value=""/>
		<table id="datatable" width="95%" border="0" cellSpacing="2" cellpadding="0" bgcolor="#FFFFFF">
		<tr class="f14 white">
          <td width="15%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">参数名称类型</td>
          <td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">参数名称</td>
          <td width="15%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">参数默认值</td>
          <td width="15%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">参数类型</td>
          <td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">是否过滤</td>
          <td width="10%" height="32" align="left" bgcolor="#5772a4" style="text-indent:10px;">是否可改</td>
          <td>
          	<input type="button" class="bb_right_sub1" onclick="$('#docparam').show()" value="添加参数" />
          </td>
         </tr>
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