<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%
String opCode  = request.getParameter("opCode");
String proId   = request.getParameter("proId"); 
%>
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
<link href="<%=request.getContextPath()%>/njs/jqueryui/jquery-ui.css" rel="stylesheet" type="text/css">

<link href="xpage/style/page_style.css" rel="stylesheet" type="text/css">


</head>
<body>
	<form name="srchFrm" target="ifm" method=post>
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
	</form>

<table style="border:0px; width:100%"><tr><td valign="top" style="width:40%">
	<table class="myoptable" >
	
	<tr><th>参数类型:</th><td> <select id="typeselector"><option value=" "/>
      <c:forEach items="${typelist }" var="item">
	   <option value="${item.typeid }">${item.name }(${item.datatype})-${item.remarks}</option>
	  </c:forEach>
	</select> 
	<input id="typesearch" placeholder="searching..." size="6"/>
	</td></tr>
	
	<tr><th>选择工号:</th><td> <select id="loginselector"><option value=""/>
      <c:forEach items="${userlist }" var="item">
	   <option value="${item}">${item}</option>
	  </c:forEach>
	</select> 
	<input id="usersearch" placeholder="searching..." size="6"/>
	</td></tr>
		<tr>
			<td colspan="2" style="text-align:center; align:left">
				<input type="button" class="b_foot" id="editparamuser" value="编 辑 " />
		  </td>
		</tr>
		
		<tr>
			<td colspan="2"> <br/> <b>添加多个工号批量设定关联， 工号原有与本参数的关联数据将被忽略！ </b><br/><br/>
			<label >输入查找：</label> <input id="usersearch1" placeholder="searching..." size="12"/>
<div id="morelogins" style="padding: 5px 5px 10px 10px">
</div>
			</td>
		</tr>
	</table>
	<input type="hidden" id="typeid" />
	<span id="showmessage" style="color:red;display:none"></span>
</td><td valign="top" align="left">
<input type="button" class="b_foot" id="selectall" value="全选"> &nbsp;&nbsp; 
<input type="button" class="b_foot" id="selectnone" value="全取消"> &nbsp;&nbsp; 
<input type="button" class="b_foot" id="saveparamuser"  value="保存"/>
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
<script  type="text/javascript">

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
	
    
	$('#saveparamuser').click(function(){
		var newsel = "";
		var tree = $("#tree").fancytree("getTree");
		var n0 = tree.getNodeByKey('t_0');
		n0.visit(function(n){
			if(n.isSelected()) newsel += n.key.substring(2) + ",";
		});
		var morelogins = '';
		$.each($(".morelogin"), function(idx, o){
 			s = $(o).text();
 			morelogins += s.substring(0, s.indexOf('-')) + ",";
 		});
		$.ajax({
			url:'setparamuser.do',
			method:'post',
			cache:false,
			data: {opCode: opCode, proId: proId, typeid:$('#typeid').val(), loginno:login_no, oldsel:oldsel, newsel:newsel, morelogins:morelogins},
			dataType: "json",
	        success: function (data){
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
			//console.log("parent not found:"+d.parentid);
		}
	});
	
	$("#tree").fancytree("getRootNode").visit(function(node){
        node.setExpanded(true);
    });
}


$("#typesearch").autocomplete({
    source: availableType,
    select: function(event, ui){
 	   var s = ui.item.value;
 	   var typeid = s.substring(0, s.indexOf('-'));
 	   $('#typeselector').val(typeid);
 	   //$("#typesearch").val('');
    }
  });
$("#usersearch").autocomplete({
    source: availableUser,
    select: function(event, ui){
 	   var s = ui.item.value;
 	   //var login = s.substring(0, s.indexOf('-'));
 	   $('#loginselector').val(s);
 	  //$("#usersearch").val('');
    }
  });

$("#usersearch1").autocomplete({
    source: availableUser,
    select: function(event, ui){
 	   var s = ui.item.value;
 	   var found = false;
 	   $.each($(".morelogin"), function(idx, o){
 			if($(o).text() == s)
 				found = true;
 		});
 	   if(found){
 		   showmsg("already exists!");
 		   return;
 	   }
 	   $('#morelogins').append('<div style="border: 0px solid #777777; padding: 5px"><span class="morelogin">'+s+'</span> <input style="align: right" type="button" class="butDel" onclick="removelogin(this);"/></div>');
    }
  });

function removelogin(o){
	$(o).parent().remove();
}

</script>

</body>

</html>