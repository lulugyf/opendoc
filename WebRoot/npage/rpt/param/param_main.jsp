<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>报表参数管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
	
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
<div id="operation">
		<%@ include file="/npage/include/header.jsp"%>
</div>	 


<script type="text/javascript" src="<%=request.getContextPath()%>/nresources/table/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/common.js"></script>

<!--  for fancytree -->
<script src="<%=request.getContextPath()%>/njs/fancytree/jquery-ui.custom.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/fancytree/jquery.fancytree.js" type="text/javascript"></script>
<link href="<%=request.getContextPath()%>/njs/fancytree/skin-win7/ui.fancytree.css" rel="stylesheet" type="text/css">

<link href="<%=request.getContextPath()%>/njs/jqueryui/jquery-ui.css" rel="stylesheet" type="text/css">


<script type="text/javascript">
var opCode="<%=opCode%>";
var proId="<%=proId%>";

</script>

<div id='xx'>
	<label for="typeselector">参数类型:</label> <select id="typeselector"><option value=" "/>
      <c:forEach items="${typelist }" var="item">
	   <option value="${item.typeid }">${item.name }(${item.datatype})-${item.remarks}</option>
	  </c:forEach>
	</select> 
	<a href="#" id="deltype">删除类型</a>
	<a href="#" id="modtype">修改类型</a>
	<a href="#" id="addtype">新增类型</a>
	
	&nbsp;&nbsp;&nbsp;
	<label >搜索：</label> <input id="typesearch">
</div>
<hr />
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
<tr><td style="width:400px" valign="top">
<div id="tree" style="width:400px">
		<ul>
			<li id="t_0">Root</li>
		</ul>
</div>
	
</td><td valign="top">

		
<table width="100%" class="myoptable">
<tr><th>参数值：    </th><td> <input type="hidden" id="paramid" value="0">
					<input type="text" id="paramValue" value=""> <button onclick="$('#paramName').val($('#paramValue').val())">v</button></td></tr>
<tr><th>参数名称： </th><td> <input type="text" id="paramName" value=""> <button onclick="$('#paramValue').val($('#paramName').val())">^</button></td></tr>
<tr><th>备 注：</th><td> <input type="text" id="remarks2" value=""></td></tr>
<tr><td colspan="2"> 
	<input type="button" class="b_foot" id="addchild" value="添加下级">
	<input type="button" class="b_foot" id="addsibling" value="添加同级">
	<input type="button" class="b_foot" id="moddata" value="修改">
	<input type="button" class="b_foot" id="deldata" value="删除">
</td></tr>
<tr><td colspan="2"><span id="showmessage" style="color:red;display:none"></span></td></tr>
</table>


</td></tr></table>

	<!-- <div>Active node: <span id="echoActive">-</span></div>
	<div>Focused node: <span id="echoFocused">-</span></div>	  -->			

<script type="text/javascript">

$(function(){
	btnHover();//主按钮鼠标经过样式

	$("#addtype").click(function(){
		if($('#addtypediv:visible').length > 0){
			$('#addtypediv').hide('slow');
		}else{
			$('#typeid1').val('0');
			$('#addtypediv').show('slow', function(){
				$('#name1').focus();
			});
		}
	});
	
	// 修改， 从option中取出参数还原到form表单里
	$("#modtype").click(function(){
		if($('#addtypediv:visible').length > 0){
			$('#addtypediv').hide('slow');
		}else{
			var opt = $("#typeselector option:selected");
			if(opt.val() == " "){
				alert("select a option first!");
				return
			}
			$('#typeid1').val(opt.val());
			var txt = opt.text();
			var p1 = txt.indexOf('('), p2 = txt.indexOf(')');
			$('#name1').val(txt.substring(0,p1));
			$('#datatype1').val(txt.substring(p1+1, p2));
			$('#remarks1').val(txt.substring(p2+2));
			$('#addtypediv').show('slow', function(){
				$('#name1').focus();
			});
		}
	});
	
	$('#deltype').click(function(){
		//$("#typeselector option:selected").remove();
		var typeid = $("#typeselector option:selected").val();
		$.ajax({
			url:'addparamtype.do',
			method:'post',
			cache:false,
			data: {opCode: opCode, proId: proId, optype:"delete", typeid:typeid},
			dataType: "json",
	        success: function (data){
	        	//console.log(JSON.stringify(data));
	        	if(data.ret == 0){
	        		if(data.typeid > 0){
	        			if(data.optype == 'delete'){
	        				$("#typeselector option[value='"+data.typeid+"']").remove();
	        			}
	        		}
	        	}
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	            showmsg("failed:"+errorThrown);
	        }
		});
	});
	
	
	
	$('#subtype1').click(function(e){
		var flds = ['typeid', 'name', 'datatype', 'remarks'];
		var d = {opCode: opCode, proId: proId};
		flds.forEach(function(n){ d[n]=$('#'+n+'1').val(); });
		//console.log("post=="+JSON.stringify(d));
		$.ajax({
			url:'addparamtype.do',
			method:'post',
			cache:false,
			data: d,
			dataType: "json",
	        success: function (data){
	        	//console.log(JSON.stringify(data));
	        	if(data.ret == 0){
	        		if(data.typeid > 0){
	        			if(data.optype == 'update'){
	        				var txt = data.name+"("+data.datatype+")-"+data.remarks;
	        				//console.log("---"+txt);
	        				$("#typeselector option[value='"+data.typeid+"']").text(txt);
	        			}else if(data.optype == 'delete'){
	        				$("#typeselector option[value='"+data.typeid+"']").remove();
	        			}else{
	        				$('#typeselector').append('<option value="'+data.typeid+'">'+data.name+'('+data.datatype+')-'+data.remarks+'</option>')
	        			}
	        		}
	        	}
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	            showmsg("failed:"+errorThrown);
	        }
		});
		$.each(flds, function(i,n){$('#'+n+'1').val('');}); 
		$('#addtypediv').hide('fast');
		return false;
	});
	
	$('#typeselector').change(function(e){
		//console.log("type changed:"+$(this).val());
		var val = $(this).val();
		if(parseInt(val) <= 0)
			return;
		getParamData(val);
	});
	
});

function getParamData(typeid){
	$.ajax({
		url:'getparamdata.do',
		method:'post',
		cache:false,
		data: {opCode: opCode, proId: proId, typeid:typeid},
		dataType: "json",
        success: function (data){
        	//console.log("out:"+JSON.stringify(data));
        	if(data.ret == 0){
        		initTree(data);
        	}
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            showmsg("failed:"+errorThrown);
        }
	})
}

var id_seed = 1;
$(function(){
	// Initialize the tree inside the <div>element.
	// The tree structure is read from the contained <ul> tag.
	$("#tree").fancytree({
		checkbox: false,
		activate: function(event, data) {
			var n = data.node;
			$('#paramid').val(n.key);
			$('#paramName').val(n.title);
			$('#paramValue').val(n.data.pvalue);
			$('#remarks2').val(n.data.remarks);
			
			//if( data.node.url )
			//	window.open(data.node.url, data.node.target);
		},
		deactivate: function(event, data) {
			//$("#echoSelected").text("-");
		},
		focus: function(event, data) {
			//$("#echoFocused").text(data.node.title);
		},
		blur: function(event, data) {
			//$("#echoFocused").text("-");
		},
		lazyLoad: function(event, data){
			// Simulate a slow ajax request
			/*var dfd = new $.Deferred()
			data.result = dfd;
			window.setTimeout(function(){
				dfd.resolve([
					{ title: 'Lazy node 1', lazy: true },
					{ title: 'Simple node 2', select: true }
				]);
			}, 1500); */
		}
	});
	
	$('#addchild').click(function(){
		addNode(false);
	});

	$('#addsibling').click(function(){
		addNode(true);
	});
	
	$('#moddata').click(function(){
		if($('#paramid').val() == 't_0'){
			showmsg("这个节点不能修改！");
			return;
		}
		if($('#paramid').val().indexOf('t_')!=0){
			showmsg("请先选择一个节点！");
			//console.log("not a valid paramid:"+$('#paramid').val());
			return;
		}
		
		var data = {optype:"update", paramid:0,paramName:$('#paramName').val(), paramValue:$('#paramValue').val(),
	    		remarks:$('#remarks2').val(), paramid:$('#paramid').val().substring(2)};
		modifyData(data, function(dd){
			var tree = $("#tree").fancytree("getTree");
			//var node = tree.getActiveNode();
			var node = tree.getNodeByKey('t_'+dd.paramid);
			node.setTitle($('#paramName').val());
			node.data.pvalue = $('#paramValue').val();
			node.data.remarks = $('#remarks2').val();			
		});

	});

	$('#deldata').click(function(){
		if($('#paramid').val() == 't_0'){
			showmsg("这个节点不能删除！");
			return;
		}
		if($('#paramid').val().indexOf('t_')!=0){
			showmsg("select a node first!!");
			//console.log("not a valid paramid:"+$('#paramid').val());
			return;
		}
		var tree = $("#tree").fancytree("getTree");
		if(tree.getActiveNode().countChildren(false) > 0){
			showmsg("还有子节点， 不能删除！");
			return;
		}
		modifyData({optype:"delete", paramid:$('#paramid').val().substring(2) }, function(dd){
			var node = tree.getNodeByKey('t_'+dd.paramid);
			if(node) 
				node.remove();			
		});

	});
});

function addNode(isSibling){
	if($('#paramid').val() == 't_0' && isSibling){
		showmsg("在根节点上不能添加同级节点！");
		return;
	}
	var pvalue = $('#paramValue').val(),
	pname = $('#paramName').val();
	if(pvalue == '' || pname == ''){
		showmsg("参数值和参数名称不能为空！");
		return;
	}
	var tree = $("#tree").fancytree("getTree");
    var node = tree.getActiveNode();
    //console.log('====='+node);
    if(!node) {
    	showmsg("请先选择一个节点！");
    	return;
    }
    //"paramid", "paramName", "paramValue", "remarks", "parentid", "typeid"
    var data = {optype:"add", paramid:0,paramName:$('#paramName').val(), paramValue:$('#paramValue').val(),
    		remarks:$('#remarks2').val(), typeid:$('#typeselector').val()}
    if(isSibling){
    	data.parentid = node.getParent().key.substring(2);
    }else{
    	data.parentid = node.key.substring(2);
    }
    modifyData(data, function(dd){
    	var nodeparent = tree.getNodeByKey('t_'+dd.parentid);
        var newData = {key:'t_'+dd.paramid, title: pname, data:{pvalue:pvalue, remarks:$('#remarks2').val()}};
    	/*if(isSibling)
    		var newnode = node.appendSibling(newData);
    	else
    		var newnode = node.addChildren(newData); */
    	var newnode = nodeparent.addChildren(newData);
    	newnode.setActive();
    })
    
}

function modifyData(data, callback){
	data.opCode = opCode;
	data.proId = proId;
	//console.log("postdata:"+JSON.stringify(data));
	$.ajax({
		url: "addparamdata.do",
		data: data,
		method: "post",
		dataType: "json",
		success: function (dd){
        	//console.log("out:"+JSON.stringify(dd));
        	if(dd.ret == 0){
        		callback(dd); //只有成功的时候调用回调函数
        	}else{
        		showmsg("操作失败："+dd.msg);
        	}
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            showmsg("服务器返回失败:"+errorThrown);
        }
	});
}

function showmsg(msg){
	$("#showmessage").text(msg);
	$("#showmessage").fadeIn().delay(5000).fadeOut();
}

function initTree(data){
	// 从服务器拉取的数据， 初始化到tree上， 需要先删除已有的数据
	//var rootNode = $("#tree").fancytree("getRootNode");
	//rootNode.removeChildren();
	var tree = $("#tree").fancytree("getTree");
	tree.getNodeByKey('t_0').removeChildren();
	$.each(data.data, function(i, d){
		var newData = {key:'t_'+d.paramid, title: d.paramName, data:{pvalue: d.paramValue, remarks:d.remarks}};
		var p = tree.getNodeByKey('t_'+d.parentid);
		if(p != undefined){
			p.addChildren(newData);
		}else{
			//console.log("parent not found:"+d.parentid);
		}
	});
	
	$("#tree").fancytree("getRootNode").visit(function(node){
        node.setExpanded(true);
    });
}

var availableType = [
<c:forEach items="${typelist }" var="item">
	"${item.typeid }-${item.name}",
</c:forEach>
          ''];

$("#typesearch").autocomplete({
    source: availableType,
    select: function(event, ui){
 	   var s = ui.item.value;
 	   var typeid = s.substring(0, s.indexOf('-'));
 	   //var typename = s.substring(s.indexOf('-')+1);
 	   $('#typeselector').val(typeid);
 	  getParamData(typeid);
    }
  });
</script>

<%//@ include file="/npage/include/footer.jsp" %>
</body>


</html>