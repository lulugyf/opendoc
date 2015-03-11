<%@ page contentType="text/html;charset=UTF-8" %>
<%
String opCode  = request.getParameter("opCode");
String proId   = request.getParameter("proId"); 
%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>报表参数管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>

 


<script type="text/javascript" src="nresources/table/js/jquery.js"></script>
<script type="text/javascript" src="njs/plugins/common.js"></script>

<!--  for fancytree -->
<script src="njs/fancytree/jquery-ui.custom.js" type="text/javascript"></script>
<script src="njs/fancytree/jquery.fancytree.js" type="text/javascript"></script>
<script src="njs/fancytree/jquery.fancytree.wide.js" type="text/javascript"></script>
<link href="njs/fancytree/skin-win7/ui.fancytree.css" rel="stylesheet" type="text/css">

<link href="njs/jqueryui/jquery-ui.css" rel="stylesheet" type="text/css">



<script type="text/javascript">
var opCode="<%=opCode%>";
var proId="<%=proId%>";

var availableType = [
<c:forEach items="${typelist }" var="item">
	"${item.typeid }-${item.name}",
</c:forEach>
          ''];

</script>

<div class="pz_ser" id='xx'>
<ul>
	<li class="text">参数类型: </li>
	<li class="input">  <select id="typeselector"><option value=" "/>
      <c:forEach items="${typelist }" var="item">
	   <option value="${item.typeid }">${item.name }(${item.datatype})-${item.remarks}</option>
	  </c:forEach>
	</select> </li>
	<li class="sub"><input type="button" id="deltype" value="删除类型"/></li>
	<li class="sub"><input type="button" id="modtype" value="修改类型"/> </li>
	<li class="sub"><input type="button" id="addtype" value="新增类型"/> </li>
	</ul>
</div>
<hr />
<div id="addtypediv" style="display:none; border:1px dotted gray">
<input type="hidden" id="opCode" value="${opCode }" />
<input type="hidden" id="typeid1" value='0' />

<div class="cs_form_div">
<table width="80%" border="0" cellspacing="2" cellpadding="0">
<tr class="f14 white">
    <td width="8%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;" class="blue">类型名称：</td>
    <td width="8%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"><input type="text" id="name1" style="height:24px;"></td>
    <td width="8%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;" class="blue">数据类型：</td>
    <td width="8%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"><select id="datatype1" style="width:100px;height:24px">${datatypelist }</select></td>
    <td width="8%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;" class="blue">备 注：</td>
    <td width="8%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"><input type="text" id="remarks1" style="height:24px;"></td>
    <td width="5%" height="36" align="right" class="blue"><input type="button" class="bb_right_sub1" id="subtype1" value="确定"></td>
</tr>
</table>
</div>
</div>

<div class="home_cont">


<!--左边菜单-->
<div id="tree" style="float:left;width:75%;overflow-y:scroll;overflow-x:hidden">
		<ul>
			<li id="t_0">Root</li>
		</ul>
</div>
	

 <div class="cs_cont_wiap fr">
    <div class="blankH14"></div>
    <div align="center">
		
<table style="width:90%;border:0px;cellspacing:4px; cellpadding:0px">
<tr class="f14 white"><td width="33%" height="36" align="right" class="blue">参数值：    </td>
<td width="67%" height="36" align="left"> <input type="hidden" id="paramid" value="0">
	<input type="text" id="paramValue" style="width:80%;"> 
</td>
</tr>
<tr class="f14 white"><td height="36" align="right" class="blue">名称： </td>
<td height="36" align="left"> 
  <input type="text" id="paramName" style="width:80%;"> 
 </td>
 </tr>
<tr>&nbsp;</tr>
<tr>&nbsp;</tr>
<tr>&nbsp;</tr>
<tr class="f14 white"><td height="36" align="right" valign="top" class="blue">备 注：</td>
<td height="36" align="left" valign="top"> 
	<textarea name="" cols="" rows="" style="width:80%; height:154px;" id="remarks2"></textarea>
	</td></tr>
<tr>
<td height="36" align="right">&nbsp;</td>
<td height="36" align="left"> 

	<input type="hidden" id="sel_real_op_type" />
	<input type="hidden" id="sel_op_type" /> 


	<input type="button" class="bb_right_sub1" id="save_mod" value="保 存"> <br/>


</td></tr>
<tr><td colspan="2"><span id="showmessage" style="color:red;display:none"></span></td></tr>
</table>

</div>
</div>
</div>




<link href="xpage/style/page_style.css" rel="stylesheet" type="text/css">
<link href="xpage/style/conf_style.css" rel="stylesheet" type="text/css">

<style type="text/css">

.fancytree-title .tool1 {
	color: red;
	position: absolute;
	top:0;
	right: 20px;
	overflow: hidden;
	display: none
}


</style>


<script src="npage/rpt/param/param_main.js" type="text/javascript"></script>


</body>


</html>