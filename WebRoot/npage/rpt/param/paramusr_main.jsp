<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>参数与用户关联</title>
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
<link href="nresources/table/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="nresources/table/js/jquery.js"></script>
<script type="text/javascript" src="nresources/table/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="njs/plugins/common.js"></script>

<link href="xpage/style/page_style.css" rel="stylesheet" type="text/css">


<script src="njs/fancytree/jquery-ui.custom.js" type="text/javascript"></script>
<script src="njs/fancytree/jquery.fancytree.js" type="text/javascript"></script>
<script src="njs/fancytree/jquery.fancytree.wide.js" type="text/javascript"></script>
<link href="njs/fancytree/skin-win7/ui.fancytree.css" rel="stylesheet" type="text/css">
<link href="njs/jqueryui/jquery-ui.css" rel="stylesheet" type="text/css">

</head>
<body>
	<form name="srchFrm" target="ifm" method=post>
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
	</form>
<div style="height:10px"></div>
<table width="100%" border="0" cellspacing="2" cellpadding="0"  bgcolor="#FFFFFF">
	<tr><td valign="top" style="width:40%">
	<table class="myoptable" >
	
	<tr>
	  <td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">参数类型：</td>
	  <td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
		<select id="typeselector" style="width:186px;height:24px">
			<option value=" "/>
		    <c:forEach items="${typelist }" var="item">
			 <option value="${item.typeid }">${item.name }(${item.datatype})-${item.remarks}</option>
			</c:forEach>
		</select> 
		<input id="typesearch" placeholder="searching..." size="6" style="height:18px"/>
	</td></tr>
	
	<tr>
		<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">选择工号：</td>
		<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;"> 
			<select id="loginselector" style="width:186px;height:24px">
				<option value=""/>
      			<c:forEach items="${userlist }" var="item">
	   			<option value="${item}">${item}</option>
	  			</c:forEach>
			</select> 
			<input id="usersearch" placeholder="searching..." size="6" style="height:18px"/>
		</td>
	</tr>
		<tr>
			<td colspan="2" style="text-align:center; align:left">
				<input type="button" class="bb_right_sub1" id="editparamuser" value="编 辑 " />
		  </td>
		</tr>
		
		<tr>
			<td colspan="2"> <br/> <b><font color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;温馨提示（批量工号操作）：<br/>&nbsp;&nbsp;&nbsp;&nbsp;
			1.&nbsp;添加多个工号批量设定关联， 工号原有与本参数的关联数据将被清除<br/>&nbsp;&nbsp;&nbsp;&nbsp;
			2.&nbsp;请从下面输入框中输入工号（模糊匹配），当出现目标工号提示时选中<br/>&nbsp;&nbsp;&nbsp;&nbsp;
			3.&nbsp;选中后的工号将以列表形式出现在输入框下方<br/>&nbsp;&nbsp;&nbsp;&nbsp;
			4.&nbsp;所列出的工号的操作与上方选择的工号的操作一模一样<br/>&nbsp;&nbsp;&nbsp;&nbsp;
			</font> </b><br/><br/>
		</tr>
		<tr>
			<td width="10%" height="32" bgcolor="#f6f6f6" align="right" style="text-indent:10px;">请输入查找：</td> 
			<td width="22%" height="32" bgcolor="#f6f6f6" align="left" style="text-indent:0px;">
				<input id="usersearch1" placeholder="searching..." style="width:186px;height:24px"/>
			</td>
		</tr>
		<tr><td colspan="2">
			<div id="morelogins" style="padding: 5px 5px 10px 10px">
			</div>
			</td>
		</tr>
	</table>
	<input type="hidden" id="typeid" />
	<span id="showmessage" style="color:red;display:none"></span>
</td><td valign="top" align="left">
<input type="button" class="bb_right_sub1" id="selectall" value="全选"> &nbsp;&nbsp; 
<input type="button" class="bb_right_sub1" id="selectnone" value="取消"> &nbsp;&nbsp; 
<input type="button" class="bb_right_sub1" id="saveparamuser"  value="保存"/>
<div style="height:10px"></div>
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
<script src="npage/rpt/param/paramusr_main.js" type="text/javascript"></script>

</body>

</html>