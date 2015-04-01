
var panel_sm1;
$(function() {
	panel_sm1 = $.jsPanel({
		selector: ".panel-body",
		title: "报表参数设置",
		size: { width:500, height:400 },
		theme: "light",
        position: { top:0, right:0 },
		//position: "center",
		id: 'panel_i1',
		controls: {
	        buttons: 'none'
	    },
		content: function(){
			var body = $('.content').html();
			//console.log(body);
			$('.content').html('');
			return body;
		}

	});
	
	//var d = $(document);
	//$('#rptbody').width(d.width()).height(d.height()-28);
	resizebody();

});

function resizebody(){
	//var w1 = $('body').width();
	//var w2 = $('#rptbody').width();
	//var d = $(document);
	var w = $(parent).width(), h = $(document).height();
	if(parent.panel_expanded){
		w -= parent.panel_width;
	}
	//console.log("===resize doc body: "+w +" "+h + " " + parent.panel_expanded);
	$('#rptbody').width(w).height(h);
}


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
	if(typeid == 0)
		return;
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
		selectMode:2,
		extensions: ["filter"],
		quicksearch: true,
		filter: {
	        mode: "hide",
	        autoApply: true
	      },
		beforeSelect: function(event, data) {
			//console.log("===:"+data.node.data.loginno);
			return data.node.data.enabled;
		}
	});
	
	var tree1 = $("#tree").fancytree("getTree");
	$("input[name=search]").keyup(function(e){
	      var n,
	        leavesOnly = false, //$("#leavesOnly").is(":checked"),
	        match = $(this).val();

	      if(e && e.which === $.ui.keyCode.ESCAPE || $.trim(match) === ""){
	        $("button#btnResetSearch").click();
	        return;
	      }

	      n = tree1.filterNodes(match, leavesOnly);
	      $("button#btnResetSearch").attr("disabled", false);
	      // console.log("(" + n + " matches)");
	    }).focus();

    $("button#btnResetSearch").click(function(e){
	      $("input[name=search]").val("");
	      //$("span#matches").text("");
	      tree1.clearFilter();
	    }).attr("disabled", true);

	dialog = $( "#dialog-form" ).dialog({
	    autoOpen: false,
	    height: 450,
	    width: 400,
	    modal: false,
	    buttons: {
	      "确定选择": function(){
	    	  sel = $("#tree").fancytree("getTree").getSelectedNodes();
	    	  if(sel.length > 0){
	    		  v = '';
	    		  for(var i=0;i<sel.length; i++){
	    			  if(v != '')
	    				  v += ',';
	    			  v += sel[i].data.pvalue;
	    		  }
	    		  $("#P_"+g_pname).val(v);
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
			alert(pname);
			$('#'+pname).val(p.value);
			alert($('#'+pname).val());
			//console.log(pname + "---" + p.value);
		})
		//panel_sm1.smallify();
		//panel_sm1.minimize();
		closePanel();
		setTimeout(refresh_token_time, 1000);
	});
	
	if(paramcount == 0){
		//没有可修改的参数， 则直接提交显示报表页面
		$('#formdoc').submit();
	}

});

function refresh_token_time(){
	// 更新token的访问时间， 避免超时导致弹出登录页面
	$.ajax({
		url:'getparamtree.do',
		method:'post',
		cache:false,
		data: {opCode: opCode, proId: proId, op:"refresh_token_time"},
		dataType: "json",
        success: function (data){
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
        }
	})
}

//字符转换为UTF-8编码
function EncodeUtf8(s1)
{
			var sa1=s1.split("");
      var retV ="";
      var ret ="";
      for(var i = 0; i < sa1.length; i ++)
      {
      			var s = escape(sa1[i]);
      			var sa = s.split("%");
      			if(sa[0] != "")
			      {
			      	 retV += "%" + stringToHex(sa[0].substr(0,1));
			      }
			      for(var j = 1; j < sa.length; j ++)
			      {
			           if(sa[j].substring(0,1) == "u")
			           {
			               retV += Hex2Utf8(Str2Hex(sa[j].substring(1,5)));
			           }
			           else retV += "%" + sa[j];
			      }
      }
      ret=retV.toUpperCase();
      return ret;
}
function Str2Hex(s)
{
      var c = "";
      var n;
      var ss = "0123456789ABCDEF";
      var digS = "";
      for(var i = 0; i < s.length; i ++)
      {
         c = s.charAt(i);
         n = ss.indexOf(c);
         digS += Dec2Dig(eval(n));
          
      }
      //return value;
      return digS;
}
function Dec2Dig(n1)
{
      var s = "";
      var n2 = 0;
      for(var i = 0; i < 4; i++)
      {
         n2 = Math.pow(2,3 - i);
         if(n1 >= n2)
         {
            s += '1';
            n1 = n1 - n2;
          }
         else
          s += '0';
         
      }
      return s;
     
}
function Dig2Dec(s)
{
      var retV = 0;
      if(s.length == 4)
      {
          for(var i = 0; i < 4; i ++)
          {
              retV += eval(s.charAt(i)) * Math.pow(2, 3 - i);
          }
          return retV;
      }
      return -1;
}
function Hex2Utf8(s)
{
     var retS = "";
     var tempS = "";
     var ss = "";
     if(s.length == 16)
     {
         tempS = "1110" + s.substring(0, 4);
         tempS += "10" + s.substring(4, 10);
         tempS += "10" + s.substring(10,16);
         var sss = "0123456789ABCDEF";
         for(var i = 0; i < 3; i ++)
         {
            retS += "%";
            ss = tempS.substring(i * 8, (eval(i)+1)*8);
           
           
           
            retS += sss.charAt(Dig2Dec(ss.substring(0,4)));
            retS += sss.charAt(Dig2Dec(ss.substring(4,8)));
         }
         return retS;
     }
     return "";
} 
function stringToHex(str){
　　var val="";
　　for(var i = 0; i < str.length; i++){
　　　　if(val == "")
　　　　　　val = str.charCodeAt(i).toString(16);
　　　　else
　　　　　　val += "," + str.charCodeAt(i).toString(16);
　　}
　　return val;
}