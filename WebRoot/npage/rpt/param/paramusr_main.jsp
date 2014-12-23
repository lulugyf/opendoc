<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>参数与用户关联</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="<%=request.getContextPath()%>/nresources/table/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/nresources/table/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/nresources/table/js/jquery.dataTables.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/common.js"></script>


<script src="<%=request.getContextPath()%>/njs/fancytree/jquery-ui.custom.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/fancytree/jquery.fancytree.js" type="text/javascript"></script>
<link href="<%=request.getContextPath()%>/njs/fancytree/skin-win7/ui.fancytree.css" rel="stylesheet" type="text/css">

</head>
<body>
	<form name="srchFrm" target="ifm" method=post>
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
	</form>
<div id="operation">
		<%@ include file="/npage/include/header.jsp"%>
</div>

<table style="border:0px; width:100%"><tr><td valign="top" style="width:30%">
	<table class="myoptable" >
	
	<tr><th>选择工号:</th><td> <select id="loginselector"><option value=""/>
      <c:forEach items="${userlist }" var="item">
	   <option value="${item}">${item}</option>
	  </c:forEach>
	</select> </td></tr>
	<tr><th>参数类型:</th><td> <select id="typeselector"><option value=" "/>
      <c:forEach items="${typelist }" var="item">
	   <option value="${item.typeid }">${item.name }(${item.datatype})-${item.remarks}</option>
	  </c:forEach>
	</select> </td></tr>
		<tr>
			<td colspan="2" style="text-align:center; align:left">
				<input type="button" class="b_foot" id="editparamuser" value="编 辑 " /> &nbsp;&nbsp; 
				<input type="button" class="b_foot" id="setparamuser"  value="确 定"/>
		  </td>
		</tr>
	</table>
	<input type="hidden" id="typeid" />
	<span id="showmessage" style="color:red;display:none"></span>
</td><td valign="top" align="left">
<a href="#" id="selectall">全选</a> &nbsp;&nbsp; <a href="#" id="selectnone">全取消</a>
<div id="tree">
		<ul>
			<li id="t_0">Root</li>
		</ul>
</div>
</td></tr></table>

<table id="datatable" class="display" width="100%" cellspacing="0">
    <thead>
        <tr>
        <th>工号</th>
            <th>用户名</th>
            <th>参数类型</th>
            <th>参数值</th>
            <th>参数名称</th>
        </tr>
    </thead>
</table>

<%//@ include file="/npage/include/footer.jsp" %>
		

<script type="text/javascript">
var opCode="<%=opCode%>";
var proId="<%=proId%>";

function showmsg(msg){
	$("#showmessage").text(msg);
	$("#showmessage").fadeIn().delay(5000).fadeOut();
}

$(function(){
	$("#tree").fancytree({
		checkbox: true,
		activate: function(event, data) {
		},
		deactivate: function(event, data) {
		},
		focus: function(event, data) {
		},
		blur: function(event, data) {
		}
	});
	
	$('#editparamuser').click(function(){
		var typeid = $('#typeselector').val();
		$('#typeid').val(typeid);
		var loginno = $('#loginselector').val();
		login_no = loginno.substring(0, loginno.indexOf('-'));
		if(typeid == '' || login_no  == ''){
			showmsg('请先选择工号和参数类型!')
		}
		$.ajax({
			url:'getparamtree.do',
			method:'post',
			cache:false,
			data: {opCode: opCode, proId: proId, typeid:typeid, login_no:login_no},
			dataType: "json",
	        success: function (data){
	        	console.log("out:"+JSON.stringify(data));
	        	if(data.ret == 0){
	        		initTree(data);
	        	}else{
	        		showmsg("get data failed:"+data.ret + ":"+data.msg);
	        	}
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	            showmsg("failed:"+errorThrown);
	        }
		})
	});
	
    
	$('#setparamuser').click(function(){
		var newsel = "";
		var tree = $("#tree").fancytree("getTree");
		var n0 = tree.getNodeByKey('t_0');
		n0.visit(function(n){
			if(n.isSelected()) newsel += n.key.substring(2) + ",";
		});
		$.ajax({
			url:'setparamuser.do',
			method:'post',
			cache:false,
			data: {opCode: opCode, proId: proId, typeid:$('#typeid').val(), loginno:login_no, oldsel:oldsel, newsel:newsel},
			dataType: "json",
	        success: function (data){
	        	console.log("out:"+JSON.stringify(data));
	        	if(data.ret == 0){
	        		showmsg("数据修改成功! 增删数量:"+data.affected);
	        		if(data.affected > 0){
	        			//var table = $('#datatable').dataTable();
	        			//table.ajax.reload();
	        		}
	        	}else{
	        		showmsg("set data failed:"+data.ret + ":"+data.msg);
	        	}
	        },
	        error: function (XMLHttpRequest, textStatus, errorThrown) {
	            showmsg("failed:"+errorThrown);
	        }
		})
	});
	
	$('#selectall').click(function(){
		var tree = $("#tree").fancytree("getTree");
		var n0 = tree.getNodeByKey('t_0');
		n0.visit(function(n){
			n.setSelected(true);
		});
	});
	$('#selectnone').click(function(){
		var tree = $("#tree").fancytree("getTree");
		var n0 = tree.getNodeByKey('t_0');
		n0.visit(function(n){
			n.setSelected(false);
		});
	});
});

var oldsel = "";
var login_no = "";
function initTree(data){
	// 从服务器拉取的数据， 初始化到tree上， 需要先删除已有的数据
	var tree = $("#tree").fancytree("getTree");
	tree.getNodeByKey('t_0').removeChildren();
	oldsel = "";
	$.each(data.data, function(i, d){
		var newData = {key:'t_'+d.paramid, title: d.paramName, data:{pvalue: d.paramValue, remarks:d.remarks}};
		var p = tree.getNodeByKey('t_'+d.parentid);
		if(p != undefined){
			var n = p.addChildren(newData);
			if(d.loginno){
				n.setSelected(true);
				oldsel += d.paramid + ',';
			}
		}else{
			console.log("parent not found:"+d.parentid);
		}
	});
	
	$("#tree").fancytree("getRootNode").visit(function(node){
        node.setExpanded(true);
    });
}

$(document).ready(function() {
	btnHover();//主按钮鼠标经过样式
    var table = $('#datatable').dataTable( {
        "processing": true,
        "serverSide": true,
        "bSort": false,
        "language": {
			 "paginate": {
			      "first": "第一页",
			      "last":"最后一页",
			      "next":"下一页",
			      "previous":"上一页"
			 },
			 "info": "记录从  _START_ 到  _END_ ",
			 "search":"搜 索",
			 "lengthMenu": '每页显示记录数   <select>'+
			             '<option value="10">10</option>'+
			             '<option value="20">20</option>'+
			             '</select>'
        },
        "columns": [
                    { "data": "loginno" },
                    { "data": "loginname" },
                    { "data": "typename" },
                    { "data": "paramValue" },
                    { "data": "paramName" }
                  ],
        "ajax": {
            "url": "getparamusr.do",
            "type": "POST",
            "data":{"opCode": "<%=opCode%>", "proId":"<%=proId%>"}
        }
    } );
    
    $('#datatable tbody').on( 'click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
            table.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    } );
 
    $('#button').click( function () {
        table.row('.selected').remove().draw( false );
    } );

} );
</script>
					
</body>

</html>