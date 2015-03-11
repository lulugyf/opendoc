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

 


<script type="text/javascript" src="${pageContext.request.contextPath}/nresources/table/js/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/njs/plugins/common.js"></script>

<!--  for fancytree -->
<script src="${pageContext.request.contextPath}/njs/fancytree/jquery-ui.custom.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/njs/fancytree/jquery.fancytree.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/njs/fancytree/jquery.fancytree.wide.js" type="text/javascript"></script>
<link href="${pageContext.request.contextPath}/njs/fancytree/skin-win7/ui.fancytree.css" rel="stylesheet" type="text/css">

<link href="${pageContext.request.contextPath}/njs/jqueryui/jquery-ui.css" rel="stylesheet" type="text/css">



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
	

	<li class="input"> <input type="text" id="typesearch"/></li>
	</ul>
</div>
<hr />
<div id="addtypediv" style="display:none; border:1px dotted gray">
<input type="hidden" id="opCode" value="${opCode }" />
<input type="hidden" id="typeid1" value='0' />

<div class="cs_form_div">
<table width="75%" align="right">
<tr><td class="blue" align="right">类型名称：</td><td> <input type="text" id="name1"></td></tr>
<tr><td class="blue" align="right">数据类型： </td><td> <select id="datatype1">${datatypelist }</select> </td></tr>
<tr><td class="blue" align="right">备 注：</td> <td> <input type="text" id="remarks1"></td></tr>
<tr><td></td><td> <input type="button" class="bb_right_sub1" id="subtype1" value="确定"></td></tr>
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
<tr><td width="33%" height="36" align="right" class="blue">参数值：    </td>
<td width="67%" height="36" align="left"> <input type="hidden" id="paramid" value="0">
	<input type="text" id="paramValue" style="width:80%;"> 
	
</td></tr>
<tr><td height="36" align="right" class="blue">名称： </td>
<td height="36" align="left"> 
  <input type="text" id="paramName" style="width:80%;"> 
 
</td></tr>
<tr><td height="36" align="right" valign="top" class="blue">备 注：</td>
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




function delNode(){
	var nid = $('#paramid').val();
	if(nid == 't_0'){
		showmsg("这个节点不能删除！");
		return;
	}
	if(nid.indexOf('t_')!=0){
		showmsg("select a node first!!");
		return;
	}
	var tree = $("#tree").fancytree("getTree");
	if(tree.getNodeByKey(nid).countChildren(false) > 0){
		showmsg("还有子节点， 不能删除！");
		return;
	}
	modifyData({optype:"delete", paramid:nid.substring(2) }, function(dd){
		var node = tree.getNodeByKey('t_'+dd.paramid);
		if(node) 
			node.remove();			
	});

}

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




function myclick(){
	if($(this).text() == '添加下级'){
		$('#sel_op_type').val('addc');
	}else if($(this).text() == '添加同级'){
		$('#sel_op_type').val('adds');
	}else if($(this).text() == '删 除'){
		$('#sel_op_type').val('del');
	}
	
	// 选中的节点依赖 tree 上的 activate 事件
	//window.console.log('!!=='+$(this).text() + " --  " + $('#sel_key_id').val());
	return true;
}

$(function(){

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
	
	$("#tree").fancytree({
		extensions: ["wide"],
		checkbox: false,
		click: function(event, data) {
			var n = data.node;
			var optype = $('#sel_op_type').val();
			$('#sel_op_type').val('');
			
			$('#paramid').val(n.key);
			
			$('#sel_real_op_type').val('');
			//window.console.log("==optype:[["+optype+"]]")
			if(optype == ''){ //没有点击节点功能按钮
				$('#paramName').val(n.title);
				$('#paramValue').val(n.data.pvalue);
				$('#remarks2').val(n.data.remarks);
				$('#sel_real_op_type').val('mod');
			}else if(optype == 'addc' || optype == 'adds'){
				$('#paramName').val('');
				$('#paramValue').val('');
				$('#remarks2').val('');
				
				if(n.key == 't_0' && optype == 'adds'){
					showmsg("不能在根节点上添加同级数据")
					return;
				}
				
				$('#paramValue').focus();
				$('#sel_real_op_type').val(optype);
			}else if(optype == 'del'){
				delNode();
			}
			
			//if( data.node.url )
			//	window.open(data.node.url, data.node.target);
		},
		renderNode: function(event, data) {
			var node = data.node;
	
			$span1 = $(node.span).find(".fancytree-title");
			if($span1.find('>div').length > 0)
				return;
			window.console.log("--renderNode:"+$span1.text());
			$btn1 = $('<div class="btn1"/>').html('<a>添加下级</a>'), $btn1.find('>a').click(myclick);
			$btn2 = $('<div class="btn2"/>').html('<a>添加同级</a>'), $btn2.find('>a').click(myclick);
			$btn3 = $('<div class="btn3"/>').html('<a>删 除</a>'), $btn3.find('>a').click(myclick);
			
			window.console.log("find btn1---"+$btn1.find('>a').length);
			
			$('<div class="ico"/>').append($btn1).append($btn2).append($btn3)
				.appendTo($span1);
			
			$span1.hover(function(){
				$(this).find('>div').show();
			}, function(){
				$(this).find('>div').hide();
			});
		}
		
	});
	
	$('#save_mod').click(function(){
		var optype = $('#sel_real_op_type').val();
		$('#sel_real_op_type').val('');
		//window.console.log("===save ["+optype+"]");
		if(optype == 'addc'){
			addNode(false);
		}else if(optype == 'adds'){
			addNode(true);
		}else if(optype == 'mod'){
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
			
		}
	});

})


var header_height = 50;
$(document).ready(function() {
    //模块尺寸  
	$('#tree').css('height', $(window).height() - header_height); 
	$('.cs_cont_wiap').css('height', $(window).height() - header_height); 
})
//改变窗体大小时适应浏览器高度
$(window).resize(function() {
    //模块尺寸
	$('#tree').css('height', $(window).height() - header_height);
	$('.cs_cont_wiap').css('height', $(window).height() - header_height);
});

</script>

<!-- <script src="npage/rpt/param/param_main.js" type="text/javascript"></script> -->


</body>


</html>