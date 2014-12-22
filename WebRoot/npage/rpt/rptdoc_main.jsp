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
<div id="operation">
		<%@ include file="/npage/include/header.jsp"%>
</div>	 


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
		
<table style="align:center;width:80%" class="myoptable">
<tr><th>报表名称：    </th><td> ${doc.docname } </td></tr>
<tr><th>报表URL： </th><td> ${doc.baseurl } </td></tr>
<tr><th>备 注：</th><td> ${doc.remarks }</td></tr>

<tr><td colspan="2"> 
   <!--  <input type="button" class="b_foot" id="go" value="查看"> -->


<form method="post" id="formdoc" action="${doc.baseurl }">
<div style="display:none">
<textarea type="hidden" name="serSes">${serSession }</textarea>
</div>
<c:forEach items="${paramlist }" var="p">
	<input type="hidden" name="${p.param }" id="${p.param }" />
</c:forEach>
<input type="submit" class="b_foot" value="查看">
</form>

</td></tr>
<tr><td colspan="2"><span id="showmessage" style="color:red;display:none"></span></td></tr>
</table>

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

<div id="dialog-form" title="参数值选择">

  <div id="tree"><ul></ul></div>
</div>

<script>
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
        		console.log("get data failed:"+data.ret + ":"+data.msg);
        	}
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log("failed:"+errorThrown);
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
	    modal: true,
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
		
	});

});


</script>
</body>
</html>