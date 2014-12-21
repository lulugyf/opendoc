
//主按钮鼠标经过样式
function btnHover(){
	$(".b_foot").hover(
		function () {
		    this.className = "b_foot_hover";
		},
		function () {
		    this.className = "b_foot";
		});
	$(".b_foot_long").hover(
		function () {
		    this.className = "b_foot_long_hover";
		},
		function () {
		    this.className = "b_foot_long";
		});
}

//控制文本框变色样式
function chgInputStyle(){
	//$("input:text,input:password,textarea").focus(function(){this.style.backgroundColor = "#FFFF66";});	
	//$("input:text,input:password,textarea").blur(function(){this.style.backgroundColor = "";});	
	$("input:text,input:password,textarea").bind("focus",function(){
		this.style.backgroundColor = "#FFFF66";
		});
	$("input:text,input:password,textarea").bind("blur",function(){
	this.style.backgroundColor = "";
	});
}

$(document).ready(function(){
	
	//$("input[type='radio']").css("border","0");//yandq写样式里
	
	//$("input[type='text'][disabled]").attr("class","input_disabled"); 
	
	//防拷贝
	 $(".nocopy").each(function(i){
	 		$(this).css({color: "darkgray"}); 
		 	$(this).bind("selectstart",function(){event.returnValue=false;});
		});
		
	//回车自动跳转聚焦 
	$("input,select").bind("keydown", function(){ 
		if(event.keyCode==13 && event.srcElement.type!='button' && 
		event.srcElement.type!='submit' && event.srcElement.type!='reset'&& event.srcElement.type!='hidden' && 
		event.srcElement.type!='textarea' && event.srcElement.type!='radio'&& event.srcElement.type!='file'&& event.srcElement.type!='') event.keyCode=9; 
	});

	   //增加提交等待效果
		var formNum = document.forms.length;
		for(i=0;i<formNum;i++){
			var oldSubmit;
			var form=document.forms[i];
			if(form != null && form != 'undefined'){
				
				form.sub=form.submit;
				form.oldSubmit = form.submit;
				form.submit = function (){
		    loading();
		   	form.oldSubmit();
				}
			}
		}
});

// 弹出功能模块
function openFunc(opCode){
	var content_array = top.content_array;
	for(var i=0; i<content_array.length; i++){
		var arr = content_array[i];
		if(typeof(arr) != "undefined" && typeof(arr.length) != "undefined"){
			if(arr[1] == opCode){
				top.L(arr[0], arr[1], arr[2], arr[3], arr[4]);
				break ;
			}
		}
	}
}

//模块关闭方式
function finishFunc(opCode, finishType){
	if(!finishType){
		finishType = 0;	
	}
	if(finishType == 1){
		removeCurrentTab();
	}else{
		return;
	}
}

// 关闭当前tab
function removeCurrentTab(){
	
	//alert("1="+parent.g_activateTab);
	if(parent.g_activateTab == undefined){
		var l_activateTab = "";
		var lis = parent.document.getElementById('tabtag').getElementsByTagName('li');
		for(var i=0; i<lis.length; i++){
			if(lis[i].className == "current"){
				l_activateTab = lis[i].id;
				break;		        
			} 
		}
		//alert("2="+l_activateTab);
		parent.removeTab(l_activateTab);
  }else{
  	//alert("3="+parent.g_activateTab);
		parent.removeTab(parent.g_activateTab); 
  }
}

var oldClose = window.close;
window.close=function()
{
	if((typeof parent.removeTab )=="function")//本级和二级
	{
		 removeCurrentTab();
	}else 	//弹出
	{
		var oldClose2 = oldClose;
		oldClose2();
		oldClose2 = null;
	}
} 

//表格滚动条自适应
function tableAutosize(){
	$(".tableAutosize table").each(function(){
		$(this).parent().width($(this).parent().prev().width()).css("margin","0 auto");
		$(this).width($(this).parent().width()).css("margin","0 auto");
	})
}
//双屏------begin----------------
function getMainPage(){
	var myWindow=window;
	while(myWindow!=myWindow.parent){
		if(myWindow.document.body.id=="main_page"){
			return myWindow;
		}
		myWindow=myWindow.parent;
	}
	return (myWindow.document.body.id=="main_page")?myWindow:null;
}
//双屏------end---------------

