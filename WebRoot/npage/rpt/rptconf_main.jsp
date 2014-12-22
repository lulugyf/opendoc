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
<tr><th>URL： </th><td> <input type="text" size="60" id="baseurl"> </td></tr>
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
<tr><th>参数名称：    </th><td> <input type="hidden" id="docid" />
	<input type="hidden" id="param_orig" />
					<input type="text" id="param"></td></tr>
<tr><th width="15%">参数默认值： </th><td> <input type="text" id="default_value" /> </td></tr>
<tr><th>参数类型： </th><td><select name="typeid" id="typeid">
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
			<td>参数名称</td><td>参数默认值</td><td>参数类型</td><td>是否过滤</td>
			<td>是否可改</td><td><input type="button" class="b_foot" onclick="$('#docparam').show()" value="添加参数" /></td></tr>
		</table>
		
</td></tr>
<tr><td colspan="2"><span id="showmessage" style="color:red;display:none"></span></td></tr>
</table>
		

<script>
function showmsg(msg){
	$("#showmessage").text(msg);
	$("#showmessage").fadeIn().delay(5000).fadeOut();
}

var group_op = "";

function editgroupname(){
	var gname = $('#groupname').val();
	if(gname == ''){
		showmsg("组名称不能为空!");
		return;
	}
	
	if(group_op == 'add'){
		var node = $("#tree").fancytree("getActiveNode");
		if(node.data.type == 'doc')
			node = node.getParent();
		$.ajax({
			url:'addrptgroup.do',
			method:'post',
			cache:false,
			data: {opCode: opCode, proId: proId, group_name: gname, parent_group:node.key},
			dataType: "json",
	        success: function (data){
	        	console.log(JSON.stringify(data));
	        	if(data.ret == 0){
	        		 var newData = {key:data.group_func, title: gname, folder:true, data:{type:"group"}};
		      		 var newnode = node.addChildren(newData);
		      		 node.setExpanded(true);
		      	     //newnode.setActive(true);
	        	}
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	            showmsg("failed:"+errorThrown);
	        }
		});
	}else if(group_op == "mod"){
		var node = $("#tree").fancytree("getActiveNode");
		//alert(node.key);
		$.ajax({
			url:'modrptgroup.do',
			method:'post',
			cache:false,
			data: {opCode: opCode, proId: proId, group_name: gname, group_func:node.key},
			dataType: "json",
	        success: function (data){
	        	console.log(JSON.stringify(data));
	        	if(data.ret == 0){
	        		 node.setTitle(gname);
	        	}
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	            showmsg("failed:"+errorThrown);
	        }
		});
	}
	
	$('#groupname').val('');
	$('#gname').fadeOut('slow');
}

function initRptTree(nodep, chld){
	$.each(chld, function(index, grp){
		if(grp.group_name){
			var newData = {key:grp.group_func, title: grp.group_name, folder:true, data:{type:"group"}};
			var node = nodep.addChildren(newData);
			if(!grp.children)
				return;
			initRptTree(node, grp.children);
			node.setExpanded(true);
		}else{
			var doc = grp;
			var newData = {key:doc.docid, title: doc.docname, folder:false, data:{type:"doc",
				function_code:doc.function_code,
				group_func:doc.group_func,
				baseurl:doc.baseurl,
				remarks:doc.remarks}};
			nodep.addChildren(newData);
		}
		
	});	
}
$(function(){
	$('#tree').fancytree({
		checkbox: false,
		activate: function(event, data) {
			var n = data.node;
			console.log('activate:'+n.title);
			if(n.data.type == 'doc'){
				$('#docid').val(n.key);
				$('#docname').val(n.title);
				$('#baseurl').val(n.data.baseurl);
				$('#function_code').text(n.data.function_code);
				$('#remarks').val(n.data.remarks);
				//document.getElementById ("docparam").style.display='block';
				initdocparamlist(n.key);
			}else{
				document.getElementById ("docparam").style.display='none';
			}
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
        		var d1 = data.data;
        		var newData = { key: d1.group_func, title: d1.group_name, folder:true, data:{type:"group"}};
        		var node = root.addChildren(newData);
    			if(!d1.children)
    				return;
    			initRptTree(node, d1.children);
    			node.setExpanded(true);
        	}
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            showmsg("failed:"+errorThrown);
        }
	});
	
	//异步加载报表参数列表
	function initdocparamlist(docid){
		var datatable = document.getElementById("datatable");
		var rownum = datatable.rows.length;
		for(i=1;i<rownum;i++){
				datatable.deleteRow(i);
				rownum=rownum-1;
		        i=i-1;
		}
		$.ajax({
			url:'getrptparam.do',
			method:'post',
			cache:false,
			data: {opCode: opCode, proId: proId, docid: docid},
			dataType: "json",
	        success: function (data){
	        	console.log(JSON.stringify(data));
	        	if(data.ret == 0){
	        		//var thHTML = "";
	        		//$("#datatable").append(thHTML);//在table最后面添加一行
	        		var list = data.data;
	        		for(var docparam in list){
	        			var trHTML = "<tr><td>"+list[docparam].param+"</td><td>"+list[docparam].default_value+"</td><td>"+list[docparam].typename+"</td><td>";
	        			if(list[docparam].filterflag == 0){
	        				trHTML = trHTML + "no" + "</td><td>" ;
	        			}else{
	        				trHTML = trHTML + "yes" + "</td><td>";
	        			}
	        			if(list[docparam].allowchange == 0){
	        				trHTML = trHTML + "no" + "</td><td>" ;
	        			}else{
	        				trHTML = trHTML + "yes" + "</td><td>";
	        			}
	        			trHTML = trHTML + "<a href='javascript:;' onclick=editdocparam(this,'"+list[docparam].typeid+"','"+list[docparam].filterflag+"','"+list[docparam].remarks+"')  id='edit' >修改</a>";
	        			trHTML = trHTML + "&nbsp;";
	        			trHTML = trHTML + "<a href='javascript:;' onclick=deldocparam(this)  id='del' >删除</a>";
	        			trHTML = trHTML + "</td></tr>";
		        		$("#datatable").append(trHTML);//在table最后面添加一行
	        		}
	        	}
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	            showmsg("failed:"+errorThrown);
	        }
		});
		
	}
	
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
	    $.ajax({
			url:'delrptgroup.do',
			method:'post',
			cache:false,
			data: {opCode: opCode, proId: proId, group_func:node.key},
			dataType: "json",
	        success: function (data){
	        	console.log(JSON.stringify(data));
	        	if(data.ret == 0){
	        		node.remove();
	        	}
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	            showmsg("failed:"+errorThrown);
	        }
		});
	    
	});
	
	
	///////////////////// doc operation
	$('#addrpt').click(function(){
		var node = $("#tree").fancytree("getActiveNode");
		if(node.data.type == 'doc'){
			group_func =  node.data.group_func;
		}else{
			group_func = node.key;
		}
		
		var docname = $('#docname').val();
		var baseurl = $('#baseurl').val();
		var remarks = $('#remarks').val();
		 $.ajax({
				url:'addrptdoc.do',
				method:'post',
				cache:false,
				data: {opCode: opCode, proId: proId, docname:docname, baseurl:baseurl, remarks:remarks, group_func:group_func},
				dataType: "json",
		        success: function (data){
		        	console.log("addrptdoc.do:"+JSON.stringify(data));
		        	if(data.ret == 0){
		        		var newData = {key:data.docid, title: docname, folder:false, data:{type:"doc", 
		        			function_code:data.function_code, baseurl:baseurl, remarks:remarks}};
		        		if(node.data.type == 'doc')
		        			node = node.getParent();
		        		node.addChildren(newData);//.setActive(true);
		        		//$('#docid').attr("value",data.docid);
		        		$('#docid').val(data.docid);
		        		//document.getElementById ("function_code").innerHTML = data.function_code;
		        		$('#function_code').text(data.function_code);
		        	}
		        },
		        error: function (XMLHttpRequest, textStatus, errorThrown) {
		            showmsg("failed:"+errorThrown);
		        }
			});
	});
	
	$('#delrpt').click(function(){
		var node = $("#tree").fancytree("getActiveNode");
		if(!node || node.data.type != 'doc'){
			showmsg('请选择报表节点！');
			return;
		}
		
		var docid = $('#docid').val();
		 $.ajax({
				url:'delrptdoc.do',
				method:'post',
				cache:false,
				data: {opCode: opCode, proId: proId, docid:docid},
				dataType: "json",
		        success: function (data){
		        	console.log(JSON.stringify(data));
		        	if(data.ret == 0){
		        		node.remove();
		        		$('#docname').val('');
		        	}
		        },
		        error: function (XMLHttpRequest, textStatus, errorThrown) {
		            showmsg("failed:"+errorThrown);
		        }
			});
	});
	
	$('#modrpt').click(function(){
		var node = $("#tree").fancytree("getActiveNode");
		if(!node || node.data.type != 'doc'){
			showmsg('请选择报表节点！');
			return;
		}
		
		var docid = $('#docid').val();
		var docname = $('#docname').val();
		var baseurl = $('#baseurl').val();
		var remarks = $('#remarks').val();
		 $.ajax({
				url:'modrptdoc.do',
				method:'post',
				cache:false,
				data: {opCode: opCode, proId: proId, docid:docid, docname:docname, baseurl:baseurl, remarks:remarks},
				dataType: "json",
		        success: function (data){
		        	console.log(JSON.stringify(data));
		        	if(data.ret == 0){
		        		node.setTitle($('#docname').val());
		        		node.data.baseurl = baseurl;
		        		node.data.remarks = remarks;
		        		$('#docname').val('');
		        	}
		        },
		        error: function (XMLHttpRequest, textStatus, errorThrown) {
		            showmsg("failed:"+errorThrown);
		        }
			});
	});
	
///////////////////// docparam operation
	$('#adddocparam').click(function(){
		var docid = $('#docid').val();
		var param = $('#param').val();
		var default_value = $('#default_value').val();
		var typeid = $('#typeid').val();
		var filterflag = $('#filterflag').val();
		var allowchange = $('#allowchange').val();
		var remarks = $('#paramremarks').val();
		
		 $.ajax({
				url:'adddocparam.do',
				method:'post',
				cache:false,
				data: {opCode: opCode, proId: proId, docid:docid, param:param, default_value:default_value,typeid:typeid, filterflag:filterflag, allowchange:allowchange,remarks:remarks},
				dataType: "json",
		        success: function (data){
		        	console.log(JSON.stringify(data));
		        	if(data.ret == 0){
		        		var selectIndex = document.getElementById("typeid").selectedIndex;//获得是第几个被选中了
		        		var selectText = document.getElementById("typeid").options[selectIndex].text; //获得被选中的项目的文本
		        		var trHTML = "<tr><td>"+$('#param').val()+"</td><td>"+$('#default_value').val()+"</td><td>"+selectText+"</td><td>";
	        			if(filterflag == 0){
	        				trHTML = trHTML + "no" + "</td><td>" ;
	        			}else{
	        				trHTML = trHTML + "yes" + "</td><td>";
	        			}
	        			if(allowchange == 0){
	        				trHTML = trHTML + "no" + "</td><td>" ;
	        			}else{
	        				trHTML = trHTML + "yes" + "</td><td>";
	        			}
	        			trHTML = trHTML + "<a href='javascript:;' onclick=editdocparam(this,'"+typeid+"','"+filterflag+"','"+allowchange+"','"+$('#paramremarks').val()+"') id='edit' >修改</a>";
	        			trHTML = trHTML + "&nbsp;";
	        			trHTML = trHTML + "<a href='javascript:;' onclick=deldocparam(this)  id='del' >删除</a>";
	        			trHTML = trHTML + "</td></tr>";
		        		$("#datatable").append(trHTML);//在table最后面添加一行
		        	}
		        	$('#docparam').hide();
		        },
		        error: function (XMLHttpRequest, textStatus, errorThrown) {
		            showmsg("failed:"+errorThrown);
		        }
			});
	});
	
	
	$('#moddocparam').click(function(){
		
		var docid = $('#docid').val();
		var param = $('#param').val();
		if(param != $('#param_orig').val()){
			showmsg("不允许修改参数名称，如果确实要修改，请删除后添加！");
			return;
		}
		var default_value = $('#default_value').val();
		var typeid = $('#typeid').val();
		var filterflag = $('#filterflag').val();
		var allowchange = $('#allowchange').val();
		var remarks = $('#paramremarks').val();
		 $.ajax({
				url:'moddocparam.do',
				method:'post',
				cache:false,
				data: {opCode: opCode, proId: proId, docid:docid, param:param, default_value:default_value,typeid:typeid, filterflag:filterflag, allowchange:allowchange, remarks:remarks},
				dataType: "json",
		        success: function (data){
		        	console.log("moddocparam:"+JSON.stringify(data));
		        	if(data.ret == 0){
		        		var rownum = $('#rownum').val();
		        		var docid = $('#docid').val();
		        		var param = $('#param').val();
		        		var default_value = $('#default_value').val();
		        		var typeid = $('#typeid').val();
		        		var filterflag = $('#filterflag').val();
		        		var selectIndex = document.getElementById("typeid").selectedIndex;//获得是第几个被选中了
		        		var selectText = document.getElementById("typeid").options[selectIndex].text; //获得被选中的项目的文本
		        		
		        		var datatable = document.getElementById('datatable');
		        		var row = datatable.rows[rownum];
		        		row.cells[0].innerHTML = param;
		        		row.cells[1].innerHTML = default_value;
		        		row.cells[2].innerHTML = selectText;
		        		row.cells[3].innerHTML = filterflag;
		        		
		        		if(filterflag == 0){
		        			row.cells[3].innerHTML = "no" ;
	        			}else{
	        				row.cells[3].innerHTML = "yes" ;
	        			}
		        		var trHTML ="<a href='javascript:;' onclick=editdocparam(this,'"+typeid+"','"+filterflag+"','"+allowflag+"','"+$('#paramremarks').val()+"') id='edit' >修改</a>";
	        			trHTML = trHTML + "&nbsp;";
	        			trHTML = trHTML + "<a href='javascript:;' onclick=deldocparam(this)  id='del' >删除</a>";
		        		
		        		row.cells[4].innerHTML = trHTML;
		        		
		        		
		        	}
		        	$('#docparam').hide();
		        },
		        error: function (XMLHttpRequest, textStatus, errorThrown) {
		            showmsg("failed:"+errorThrown);
		        }
			});
	});
	
});

var tb=document.getElementById('datatable');//获得表格

function editdocparam(label,typeid,filterflag,allowchange, paramremark){
	var rowIndex = label.parentNode.parentNode.rowIndex; //获得表格行的索引号
	
    var row = tb.rows[rowIndex]; //获得行
    $("#rownum").attr("value",rowIndex);
    var param = row.cells[0].innerHTML;
    var default_value = row.cells[1].innerHTML;
    
    document.getElementById('param').value = param;
    $('#param_orig').val(param);
    document.getElementById('default_value').value = default_value;
    document.getElementById('typeid').value = typeid;
    document.getElementById('filterflag').value = filterflag;
    document.getElementById('allowchange').value = allowchange;
    document.getElementById('paramremarks').value = paramremark;
    
    $('#docparam').show();
}

function deldocparam(label){
	var docid = $('#docid').val();
	var rowIndex = label.parentNode.parentNode.rowIndex; //获得表格行的索引号
    var row = tb.rows[rowIndex]; //获得行
    var param = row.cells[0].innerHTML;
	$.ajax({
		url:'deldocparam.do',
		method:'post',
		cache:false,
		data: {opCode: opCode, proId: proId, docid:docid, param:param},
		dataType: "json",
        success: function (data){
        	console.log(JSON.stringify(data));
        	if(data.ret == 0){
        		var rowIndex=label.parentNode.parentNode.rowIndex;//获得行的索引
        		 tb.deleteRow(rowIndex);//删除行
        		//deleteRow是js内置的方法;
        	}
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            showmsg("failed:"+errorThrown);
        }
	});
}

</script>
</body>


</html>