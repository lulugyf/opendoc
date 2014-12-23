<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>报表参数管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


  
  <link href="<%=request.getContextPath()%>/njs/jqueryui/jquery-ui.css" rel="stylesheet" type="text/css">
</head>
<body>
	<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
	<input type=hidden name="proId" id="proId" value="<%=proId%>">
 


<script type="text/javascript" src="<%=request.getContextPath()%>/nresources/table/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/common.js"></script>


<!--  for fancytree -->
<script src="<%=request.getContextPath()%>/njs/fancytree/jquery-ui.custom.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/fancytree/jquery.fancytree.js" type="text/javascript"></script>
<link href="<%=request.getContextPath()%>/njs/fancytree/skin-win7/ui.fancytree.css" rel="stylesheet" type="text/css">


<script type="text/javascript">
var opCode="<%=opCode%>";
var proId="<%=proId%>";
var loginno="${login_no}";

</script>


<input type="hidden" id="opCode" value="${opCode }" />
<input type="hidden" id="typeid1" value='0' />

<input type="hidden" id="docid" value="${doc.docid}" />


<script type="text/javascript" src="<%=request.getContextPath()%>/njs/jspanel/jquery.jspanel.min.js"></script>
<link href="<%=request.getContextPath()%>/njs/jspanel/jquery.jspanel.min.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
var panel_sm1;
$(function() {
	panel_sm1 = $.jsPanel({
		selector: ".panel-body",
		title: "报表参数 设置",
		size: { width:500, height:400 },
		theme: "light",
        //position: { top:50, left:200 },
		position: "center",
		id: 'panel_i1',
		//controls:      { buttons: 'none' },
		content: function(){
			var body = $('.content').html();
			//console.log(body);
			$('.content').html('');
			return body;
		}

	});
});
</script>

<div id="operation" class="pagetitle">
		<%@ include file="/npage/include/header.jsp"%>
</div>

<div class=".panel-body"></div>

<div  class="content" style="display:none">

	
<span id="showmessage" style="color:red;display:none"></span>

<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> 
	<div class="text">报表参数列表</div>
</div>  
<div class="list11">
	<table id="mTable1">
		<tr>
			<th>参数</th>
			<th>类型</th>
			<th>默认值</th>
			<th>设定值</th>
		</tr>
		<c:forEach items="${paramlist }" var="p">
		<tr>
			<td>${p.param }</td><td>${p.typename }</td><td>${p.default_value }</td>
			<td><input type="text" class="param" id="P_${p.param }" value="${p.default_value }" <c:if test="${p.typeid > 0 }">readonly</c:if> />
			  <button onclick="selParam('${p.param }', ${p.typeid}, ${p.filterflag })">...</button></td>
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
	<input type="hidden" name="${p.param }" id="${p.param }" />
</c:forEach>
<table style="border:false; width:100%"><tr><td align="center">
<input type="submit" class="b_foot" value="查看">
</td></tr></table>
</form>
</div>

<div class="b">
 <iframe align="left" name="rptbody" id="rptbody" src="npage/portal/work/portal.jsp" frameborder="0" scrolling="yes" style="width:100%;height:100%;overflow:scrolling">
		</iframe>
</div>

<style>
.ui-dialog {
	z-index: 1000;
}
</style>
<div id="dialog-form" title="参数值选择">

  <div id="tree"><ul></ul></div>
</div>

<script>

$(function(){
	var d = $(document);
	$('#rptbody').width(d.width()-12).height(d.height()-$('.pagetitle').height()-12);
	
});
function showmsg(msg){
	$("#showmessage").text(msg);
	$("#showmessage").fadeIn().delay(5000).fadeOut();
}

var dialog = null;

function initTree(data, filterflag){
	// 从服务器拉取的数据， 初始化到tree上， 需要先删除已有的数据
	var tree = $("#tree").fancytree("getTree");
	tree.getRootNode().removeChildren();
	$.each(data.data, function(i, d){
		var newData = {key:'t_'+d.paramid, title: d.paramName, data:{pvalue: d.paramValue, enabled:false, loginno:d.loginno,paramid:d.paramid}};
		var p = tree.getNodeByKey('t_'+d.parentid);
		if(p != undefined){
			var n = p.addChildren(newData);
		}else{
			var n = tree.getRootNode().addChildren(newData);
		}
		if(d.loginno || filterflag != 1)
			n.data.enabled = true;
		else
			n.setStatus('error');
	});
	
	$("#tree").fancytree("getRootNode").visit(function(node){
        node.setExpanded(true);
        $.each(data.data1, function(index, d){
        	if(d.paramid == node.data.paramid){
        		node.data.enabled = (d.ex_flag == '1');
        	}
        });
    });
	$("#tree").fancytree("getRootNode").visit(function(node){
        if(node.data.enabled){
        	node.visit(function(n){
        		n.setStatus('ok');
        		n.data.enabled = true;
        	}, true);
        	return 'skip';
        }
    });
}

var g_pname = "";
function selParam(param, typeid, filterflag){
	g_pname = param;
	//console.log('selParam:'+param + " ---"+typeid + " " + filterflag);
	$.ajax({
		url:'getparamtree.do',
		method:'post',
		cache:false,
		data: {opCode: opCode, proId: proId, typeid:typeid, login_no: loginno, docid:$('#docid').val()},
		dataType: "json",
        success: function (data){
        	//console.log("out:"+JSON.stringify(data));
        	if(data.ret == 0){
        		initTree(data, filterflag);
        	}else{
        		showmsg("get data failed:"+data.ret + ":"+data.msg);
        	}
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            showmsg("failed:"+errorThrown);
        }
	})
	dialog.dialog( "open" );
}
$(function(){
	$('#tree').fancytree({
		lines:true,
		checkbox:true,
		selectMode:1,
		beforeSelect: function(event, data) {
			//console.log("===:"+data.node.data.loginno);
			return data.node.data.enabled;
		}
	});
	dialog = $( "#dialog-form" ).dialog({
	    autoOpen: false,
	    height: 450,
	    width: 400,
	    modal: false,
	    buttons: {
	      "确定选择": function(){
	    	  sel = $("#tree").fancytree("getTree").getSelectedNodes();
	    	  if(sel.length > 0){
	    		  $("#P_"+g_pname).val(sel[0].data.pvalue);
	    	  }
	    	  dialog.dialog( "close" );
	  	    //console.log("=====:"+sel.length);
	      },
	      "取消": function() {
	        dialog.dialog( "close" );
	      }
	    },
	    close: function() {
	    }
	  });
	
	$('#formdoc').submit(function(e){
		$.each($('.param'), function(index, p){
			pname = p.id.substring(2);
			$('#'+pname).val(p.value);
			//console.log(pname + "---" + p.value);
		})
		//panel_sm1.smallify();
		panel_sm1.minimize();
	});

});


</script>
</body>
</html>