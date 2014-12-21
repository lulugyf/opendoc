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
<tr><td style="width:300px" valign="top">
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

<table width="100%" class="myoptable">
<tr><th>报表名称：    </th><td> <input type="hidden" id="docid" value="0">
					<input type="text" id="docname"></td></tr>
<tr><th>URL： </th><td> <input type="text" size="60" id="baseurl"> </td></tr>
<tr><th>备 注：</th><td> <input type="text" id="remarks"></td></tr>
<tr><th>功能代码：</th><td> <span id="function_code" title="自动生成" ></span></td></tr>
<tr><td colspan="2"> 
	<input type="button" class="b_foot" id="addrpt" value="添加">
	<input type="button" class="b_foot" id="modrpt" value="修改">
	<input type="button" class="b_foot" id="delrpt" value="删除">
</td></tr>
<tr><td colspan="2"><span id="showmessage" style="color:red;display:none"></span></td></tr>
</table>


</td></tr></table>
		

<script>
var opCode="<%=opCode%>";
var proId="<%=proId%>";
function showmsg(msg){
	$("#showmessage").text(msg);
	$("#showmessage").fadeIn().delay(5000).fadeOut();
}

var group_op = "";

function editgroupname(){
	var gname = $('#groupname').val();
	console.log("==input:"+gname);
	
	if(group_op == 'add'){
		var newData = {key:'t_'+gname, title: gname, folder:true, data:{type:"group"}};
	    var newnode = $("#tree").fancytree("getRootNode").addChildren(newData);
	    newnode.setActive(true);
	}else if(group_op == "mod"){
		var node = $("#tree").fancytree("getActiveNode");
	    node.setTitle( gname );
	}
	
	$('#groupname').val('');
	$('#gname').fadeOut('slow');
}
$(function(){
	$('#tree').fancytree({
		checkbox: false,
		activate: function(event, data) {
			var n = data.node;
			console.log('activate:'+n.title);
			if(n.data.type == 'doc'){
				$('#docname').val(n.title);
				$('#baseurl').val(n.data.baseurl);
				$('#function_code').text(n.data.function_code);
				$('#remarks').val(n.data.remarks);
			}
		},
		deactivate: function(event, data) {
		},
		focus: function(event, data) {
		},
		blur: function(event, data) {
		}
	});
	
	$.ajax({ //获取报表树
		url:'getrpttree.do',
		method:'post',
		cache:false,
		data: {opCode: opCode, proId: proId},
		dataType: "json",
        success: function (data){
        	//console.log(JSON.stringify(data));
        	var root = $("#tree").fancytree("getRootNode")
        	if(data.ret == 0){
        		$.each(data.data, function(index, grp){
        			var newData = {key:grp.group_func, title: grp.group_name, folder:true, data:{type:"group"}};
        			var node = root.addChildren(newData);
        			if(!grp.children)
        				return;
        			$.each(grp.children, function(index, doc){
        				var newData = {key:doc.docid, title: doc.docname, folder:false, data:{type:"doc",
        					function_code:doc.function_code,
        					group_func:doc.group_func,
        					baseurl:doc.baseurl,
        					remarks:doc.remarks}};
        				node.addChildren(newData);
        			});
        			node.setExpanded(true);
        		});
        	}
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            showmsg("failed:"+errorThrown);
        }
	});
	
	$("#addGroup").click(function(){
		$('#gname').fadeIn("fast", function(){
			group_op = "add";
			$('#groupname').focus();
		});
	});
	$("#modGroup").click(function(){
		var tree = $("#tree").fancytree("getTree");
	    var node = tree.getActiveNode();
	    if(!node || node.data.type != 'group'){
	    	showmsg("请先选择分组!");
	    	return;
	    }
		$('#gname').fadeIn("fast", function(){
			group_op = "mod";
			$('#groupname').val(node.title).focus();
		});
	});
	
	$('#groupname').on("keypress", function(e){
		if(e.keyCode == 13){
			editgroupname();
		}
	});
	
	$('#delGroup').click(function(){
		var tree = $("#tree").fancytree("getTree");
	    var node = tree.getActiveNode();
	    if(!node || node.data.type != 'group'){
	    	showmsg("请先选择分组!");
	    	return;
	    }
	    if(node.countChildren() >0){
	    	showmsg("分组下数据，不能删除本分组!");
	    	return;
	    }
	    console.log('remove:'+node.title);
	    node.remove();
	});
	
	
	///////////////////// doc operation
	$('#addrpt').click(function(){
		var node = $("#tree").fancytree("getActiveNode");
		var docname = $('#docname').val();
		var newData = {key:'t_'+docname, title: docname, folder:false, data:{type:"doc"}};
		if(node.data.type == 'doc')
			node = node.getParent();
		node.addChildren(newData).setActive(true);
		//$('#docname').val('');
	});
	
	$('#delrpt').click(function(){
		var node = $("#tree").fancytree("getActiveNode");
		if(!node || node.data.type != 'doc'){
			showmsg('请选择报表节点！');
			return;
		}
		node.remove();
		$('#docname').val('');
	});
	
	$('#modrpt').click(function(){
		var node = $("#tree").fancytree("getActiveNode");
		if(!node || node.data.type != 'doc'){
			showmsg('请选择报表节点！');
			return;
		}
		node.setTitle($('#docname').val());
		$('#docname').val('');
	});
});

</script>
</body>


</html>