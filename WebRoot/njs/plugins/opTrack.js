//定义两个数组变量，分别存放位置的X、Y坐标
var arrMouseX = new Array();
var arrMouseY = new Array();
var iStep = 0;//记录步骤数
var recordMap = {};//记录每个控件被点击的次数
var login_on="测试";
var opcode="1004";

//获取json的长度
function jsonLen(obj){
	var len = 0;
	for(var item in obj){
		len++;	
	}
	return len;
}
function getScrollTop()
{ 
	var scrollTop=0; 
	if(document.documentElement&&document.documentElement.scrollTop){
		scrollTop=document.documentElement.scrollTop; 
	} 
	else if(document.body){
		scrollTop=document.body.scrollTop; 
	} 
	return scrollTop; 
}

function getScrollLeft()
{ 
	var scrollLeft=0; 
	if(document.documentElement&&document.documentElement.scrollLeft){
		scrollLeft=document.documentElement.scrollLeft; 
	} 
	else if(document.body){
		scrollLeft=document.body.scrollLeft; 
	} 
	return scrollLeft; 
}

//获取鼠标坐标位置
function getMousePosition(flag,e){
	var e = e||window.event; 
  var objSrc = e.srcElement|| e.target;//event source element 
 	var left = 0; 
  var top  = 0;
  while (objSrc.offsetParent){
			if(objSrc.offsetParent.tagName=="TR"){
				var tdObj=objSrc.parentNode;
				while(tdObj){
						left += tdObj.offsetLeft;
						tdObj=getPreviousSibling(tdObj);
					}
			}
      left += objSrc.offsetLeft; 
      top  += objSrc.offsetTop; 
      objSrc = objSrc.offsetParent; 
      
  } 
  left += objSrc.offsetLeft;//source element's offsetTop 
  top  += objSrc.offsetTop;//source element's offsetLeft 
  
  
  	mouseOffsetX = left; 
	  mouseOffsetY = top;
  /*if(e.offsetX){
	  mouseOffsetX = left + e.offsetX; 
	  mouseOffsetY = top + e.offsetY;
	}else{
		mouseOffsetX = left; 
	  mouseOffsetY = top;
	}*/

  
   
    if(flag=="x")return mouseOffsetX;
    if(flag=="y")return mouseOffsetY;
}
function getPreviousSibling(obj){
	var previousObj=obj.previousSibling;
	while(previousObj&&previousObj.nodeType!=1){
		 previousObj=previousObj.previousSibling;
	}
	return previousObj;
}

//记录事件
function record(){
	var e = arguments[0] || window.event;
	var eObj = e.srcElement || e.target;
	
	if(eObj&&eObj.type!=undefined){
		var _name = "";
		if(eObj.type=="button"){
			_name = eObj.value==""?(eObj.title+"_["+eObj.type+"]"):(eObj.value+"_["+eObj.type+"]");
		}else if(eObj.tagName=="A"){
			_name = eObj.innerText+"_["+eObj.type+"]";
		}else if(getPreviousSibling(eObj.parentNode).tagName=="TH"){
			_name = getPreviousSibling(eObj.parentNode).innerHTML+"_["+eObj.type+"]";
		}
		if(_name=="")_name = eObj.type;
		if(jsonLen(recordMap)>0){
			if(recordMap[_name]!=undefined){
					var _value = recordMap[_name];
					recordMap[_name] =++_value;
				}else{
					recordMap[_name] = 1;	
				}
		}else{
				recordMap[_name] = 1;	
		}
		arrMouseX[iStep] = getMousePosition("x",e);
		arrMouseY[iStep] = getMousePosition("y",e);
		iStep++;
	}
}
//开始记录
function startRecord(){
	var bd=document.getElementsByTagName("body")[0];
	if(bd.addEventListener){
		bd.addEventListener("click",record,true);	
	}else if(bd.attachEvent){
		bd.attachEvent("onclick",record)
	}
	//document.body.attachEvent("onclick",record);
}

//结束记录
function endRecord(){
	var bd=document.getElementsByTagName("body")[0];
	if(bd.removeEventListener){
		bd.removeEventListener("click",record,true);	
	}else if(bd.detachEvent){
		bd.detachEvent("onclick",record)
	}
	
	//document.body.detachEvent("onclick",record);
	saveRecordData(arrMouseX,arrMouseY,iStep,recordMap)//可以根据实际情况调整保存操作的位置
}

//播放操作
function rePlay(arrX,arrY,step){
	if(document.getElementById("miniMouse")){
		document.body.removeChild(document.getElementById("miniMouse"));
	}
	var iStepPlay = 0;
	var miniMouse = document.createElement("div");
	miniMouse.setAttribute("id","miniMouse");
	miniMouse.style.zIndex=1000;
	miniMouse.style.position="absolute";
	miniMouse.style.fontSize="18";
	miniMouse.style.fontWeight="bold";
	miniMouse.style.display = "";
	miniMouse.innerHTML = "*";
	miniMouse.style.color = "red";
	document.body.appendChild(miniMouse);
	var Timer = setInterval(function(){stepPlay()},1000);
	

	//按步回放
	function stepPlay(){
		if(iStepPlay>=step){
			window.clearInterval(Timer);			
			return true;
		}else{
			miniMouse.innerHTML = "*"+iStepPlay;
			miniMouse.style.left = arrX[iStepPlay]+"px";
			miniMouse.style.top = arrY[iStepPlay]+"px";
			iStepPlay++;
		}
	}
}

//操作轨迹数据存储预留接口，需要二次开发完成
function saveRecordData(arrX,arrY,step,rMap){
	//alert("arrX==="+arrX+"---"+"arrY======"+arrY+"----step===="+step+"----rMap===="+rMap);
}

//数据分析默认接口方法
function dataDisplay(divId){
	var innersStr = "<table style='border:1'><tr><th>元素名称</th><th>元素类型</th><th>次数</th></tr>";
	for(var item in recordMap){
			innersStr +="<tr><td>"+item.split("_")[0]+"</td><td>"+item.split("_")[1]+"</td><td>"+recordMap[item]+"</td></tr>"
	}
	document.getElementById(divId).innerHTML = innersStr;
}
//数据分析扩展接口，
function auDataDisplay(rMap){	
	
}

//获取当前时间
function getCurDate(d){
	var s = "";
	var m=d.getMonth()+1,
		dt=d.getDate(),
		h=d.getHours(),
		mi=d.getMinutes(),
		se=d.getSeconds(),
		ms=d.getMilliseconds,
		c = "";
	
	if(m>9){
	}else{
		m="0"+m;
	}
	s += d.getYear() + c;
	s += m + c;
	s += (dt>9?dt:"0"+dt) + c;
	s += (h>9?h:"0"+h) + c;
	s += (mi>9?mi:"0"+mi) + c;
	s += (se>9?se:"0"+se) + c;
	s += (ms>9?(ms>99?ms:"0"+ms):"00"+se)
	return s;
}