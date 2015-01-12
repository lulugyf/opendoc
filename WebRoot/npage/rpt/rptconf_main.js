var dialogex = null;
$(function(){
	dialogex = $( "#dialog-form" ).dialog({
    autoOpen: false,
    height: 450,
    width: 400,
    modal: true,
    buttons: {
      "确定选择": function(){
    	  var docid = $('#docid').val();
    	  var login_no = $('#login_no').val();
    	  var typeid = $('#param_typeid').val();
    	  var incl = "";
    	  var excl = "";
    	  var tree = $("#paramtree").fancytree("getRootNode").visit(function(node){
    		  if(node.data.loginno && !node.isSelected())
    			  excl += node.data.paramid + ",";
    		  if(!node.data.loginno && node.isSelected())
    			  incl += node.data.paramid + ",";
    	  });
    	  $.ajax({
  			url:'setparamuserex.do',
  			method:'post',
  			cache:false,
  			data: {opCode: opCode, proId: proId, typeid:typeid, login_no: login_no, docid:docid, incl:incl, excl:excl},
  			dataType: "json",
  	        success: function (data){
  	        	console.log("out:"+JSON.stringify(data));
  	        },
  	        error: function (XMLHttpRequest, textStatus, errorThrown) {
  	            showmsg("failed:"+errorThrown);
  	        }
  		})
    	  dialogex.dialog( "close" );
      },
      "取消": function() {
    	  dialogex.dialog( "close" );
      }
    },
    close: function() {
    }
  });
	
   $("#login_no_name").autocomplete({
       source: availableLogin,
       select: function(event, ui){
    	   var s = ui.item.value;
    	   var docid = $('#docid').val();
    	   var typeid = $('#param_typeid').val();
    	   var login_no = s.substring(0, s.indexOf('-'));
    	   $('#login_no').val(login_no);
    	   $.ajax({
    			url:'getparamtree.do',
    			method:'post',
    			cache:false,
    			data: {opCode: opCode, proId: proId, typeid:typeid, login_no: login_no, docid:docid},
    			dataType: "json",
    	        success: function (data){
    	        	//console.log("out:"+JSON.stringify(data));
    	        	if(data.ret == 0){
    	        		initParamTree(data, filterflag);
    	        	}else{
    	        		showmsg("get data failed:"+data.ret + ":"+data.msg);
    	        	}
    	        },
    	        error: function (XMLHttpRequest, textStatus, errorThrown) {
    	            showmsg("failed:"+errorThrown);
    	        }
    		})
       }
     });
   
	$('#paramtree').fancytree({
		lines:true,
		checkbox:true,
		selectMode:2,
		beforeSelect: function(event, data) {
			//console.log("===:"+data.node.data.loginno);
			return data.node.data.enabled;
		}
	});
});

function initParamTree(data){
	// 参数对应 工号 报表的树状树
	var tree = $("#paramtree").fancytree("getTree");
	tree.getRootNode().removeChildren();
	$.each(data.data, function(i, d){
		var newData = {key:'t_'+d.paramid, title: d.paramName, data:{pvalue: d.paramValue, loginno:d.loginno, paramid:d.paramid}};
		var p = tree.getNodeByKey('t_'+d.parentid);
		if(p != undefined){
			var n = p.addChildren(newData);
		}else{
			var n = tree.getRootNode().addChildren(newData);
		}
		if(n.data.loginno)
			n.setSelected(true);
	});
	
	tree.getRootNode().visit(function(node){
        node.setExpanded(true);
        $.each(data.data1, function(i, d){
        	if(d.paramid == node.data.paramid){
        		node.setSelected(d.ex_flag=='1');	
        	}
        });
    });
}


function setparamuser(typeid){
	if(parseInt(typeid) <= 0)
		return;
	$('#param_typeid').val(typeid);
	$('#login_no_name').val('');
	$("#paramtree").fancytree("getRootNode").removeChildren();
	dialogex.dialog("open");
}




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
				boid:doc.boid,
				opendocid:doc.opendocid,
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
				$('#boid').val(n.data.boid);
				$('#opendocid').val(n.data.opendocid);
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
	        			var trHTML = "<tr><td>";
	        			if(list[docparam].pnametype == 'lsS'){
	        				trHTML = trHTML + "单值" + "</td><td>" ;
	        			}else if(list[docparam].pnametype == 'lsM'){
	        				trHTML = trHTML + "多值" + "</td><td>";
	        			}else if(list[docparam].pnametype == 'lsR'){
	        				trHTML = trHTML + "范围" + "</td><td>" ;
	        			}else{
	        				trHTML = trHTML + "&nbsp;" + "</td><td>" ;
	        			}
	        			trHTML = trHTML+list[docparam].param+"</td><td>"+list[docparam].default_value+"</td><td>"+list[docparam].typename+"</td><td>";
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
	        			trHTML = trHTML + "<a href='javascript:;' onclick=editdocparam(this,'"+list[docparam].paramid+"','"+list[docparam].pnametype+"','"+list[docparam].typeid+"','"+list[docparam].filterflag+"','"+list[docparam].allowchange+"','"+list[docparam].remarks+"')  id='edit' >修改</a>";
	        			trHTML = trHTML + "&nbsp;";
	        			trHTML = trHTML + "<a href='javascript:;' onclick=deldocparam(this,'"+list[docparam].paramid+"')  id='del' >删除</a>&nbsp; ";
	        			trHTML = trHTML + "<a href='javascript:;' onclick=setparamuser('"+list[docparam].typeid+"') >设置工号关联</a>";
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
		var boid = $('#boid').val();
		var opendocid = $('#opendocid').val();
		var remarks = $('#remarks').val();
		if(docname == '' || baseurl == ''){
			showmsg("报表名称和URL都不能为空!");
			return;
		}
		 $.ajax({
				url:'addrptdoc.do',
				method:'post',
				cache:false,
				data: {opCode: opCode, proId: proId, docname:docname, baseurl:baseurl, remarks:remarks, group_func:group_func, boid:boid, opendocid:opendocid},
				dataType: "json",
		        success: function (data){
		        	console.log("addrptdoc.do:"+JSON.stringify(data));
		        	if(data.ret == 0){
		        		var newData = {key:data.docid, title: docname, folder:false, data:{type:"doc", 
		        			function_code:data.function_code, baseurl:baseurl, boid:boid, opendocid:opendocid, remarks:remarks}};
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
		if(docid == ''){
			showmsg('请先选择报表节点');
			return;
		}
		var docname = $('#docname').val();
		var baseurl = $('#baseurl').val();
		var boid = $('#boid').val();
		var opendocid = $('#opendocid').val();
		var remarks = $('#remarks').val();
		 $.ajax({
				url:'modrptdoc.do',
				method:'post',
				cache:false,
				data: {opCode: opCode, proId: proId, docid:docid, docname:docname, baseurl:baseurl, remarks:remarks, boid:boid, opendocid:opendocid},
				dataType: "json",
		        success: function (data){
		        	console.log(JSON.stringify(data));
		        	if(data.ret == 0){
		        		node.setTitle($('#docname').val());
		        		node.data.baseurl = baseurl;
		        		node.data.remarks = remarks;
		        		node.data.boid = boid;
		        		node.data.opendocid = opendocid;
		        		clearDocFields();
		        		//$('#docname').val('');
		        		//$('#docid').val('');
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
		var pnametype = $('#pnametype').val();
		var default_value = $('#default_value').val();
		var typeid = $('#typeid').val();
		var filterflag = $('#filterflag').val();
		var allowchange = $('#allowchange').val();
		var remarks = $('#paramremarks').val();
		
		 $.ajax({
				url:'adddocparam.do',
				method:'post',
				cache:false,
				data: {opCode: opCode, proId: proId, docid:docid,pnametype:pnametype, param:param, default_value:default_value,typeid:typeid, filterflag:filterflag, allowchange:allowchange,remarks:remarks},
				dataType: "json",
		        success: function (data){
		        	if(data.ret == 0){
		        		initdocparamlist(docid);
		        	}
		        	$('#docparam').hide();
		        },
		        error: function (XMLHttpRequest, textStatus, errorThrown) {
		            showmsg("failed:"+errorThrown);
		        }
			});
	});
	
	
	$('#moddocparam').click(function(){
		
		var paramid = $('#paramid').val();
		var docid = $('#docid').val();
		var pnametype = $('#pnametype').val();
		var param = $('#param').val();
		var default_value = $('#default_value').val();
		var typeid = $('#typeid').val();
		var filterflag = $('#filterflag').val();
		var allowchange = $('#allowchange').val();
		var remarks = $('#paramremarks').val();
		 $.ajax({
				url:'moddocparam.do',
				method:'post',
				cache:false,
				data: {opCode: opCode, proId: proId, paramid:paramid, docid:docid, pnametype:pnametype, param:param, default_value:default_value,typeid:typeid, filterflag:filterflag, allowchange:allowchange, remarks:remarks},
				dataType: "json",
		        success: function (data){
		        	console.log("moddocparam:"+JSON.stringify(data));
		        	if(data.ret == 0){
		        		initdocparamlist(docid);
		        	}
		        	$('#docparam').hide();
		        },
		        error: function (XMLHttpRequest, textStatus, errorThrown) {
		            showmsg("failed:"+errorThrown);
		        }
			});
	});
	
});

function clearDocFields(){
	$.each(['docid', 'baseurl', 'remarks', 'opendocid', 'docname'], function(idx, v){
		$('#'+v).val('');
	});
}

var tb=document.getElementById('datatable');//获得表格

function editdocparam(label,paramid,pnametype,typeid,filterflag,allowchange, paramremark){
	var rowIndex = label.parentNode.parentNode.rowIndex; //获得表格行的索引号
	
    var row = tb.rows[rowIndex]; //获得行
    $("#rownum").attr("value",rowIndex);
    var param = row.cells[1].innerHTML;
    var default_value = row.cells[2].innerHTML;
    
    document.getElementById('paramid').value = paramid;
    document.getElementById('pnametype').value = pnametype;
    document.getElementById('param').value = param;
    document.getElementById('default_value').value = default_value;
    document.getElementById('typeid').value = typeid;
    document.getElementById('filterflag').value = filterflag;
    document.getElementById('allowchange').value = allowchange;
    document.getElementById('paramremarks').value = paramremark;
    
    $('#docparam').show();
}

function deldocparam(label,paramid){
	var docid = $('#docid').val();
	var rowIndex = label.parentNode.parentNode.rowIndex; //获得表格行的索引号
    var row = tb.rows[rowIndex]; //获得行
    var param = row.cells[1].innerHTML;
	$.ajax({
		url:'deldocparam.do',
		method:'post',
		cache:false,
		data: {opCode: opCode, proId: proId,paramid:paramid, docid:docid, param:param},
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
