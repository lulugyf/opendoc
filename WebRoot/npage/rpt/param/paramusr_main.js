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
