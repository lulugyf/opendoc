/* 
 * 初始化参数
*/
var cookieId;           //cookie名称
var maxCount = 15;      //cookie最大保存个数，比showCount多出的用来做排序后备
var showCount = 10;     //cookie显示个数
var days = 30;          //cookie保存天数
var date = new Date();
var curCookieContent = null;
var curCookieJson = null;

/* 
 * 按照cookie中使用次数倒序，文本框输入匹配
*/
function matchMaxInput(obj,show_count,save_days){
	  
		getCookieObj(obj,show_count,save_days);
		
		if(curCookieJson){
			  var temp_name;
			  var temp_value;
			  
			  // 冒泡倒序排列，counts最大的在最后
				for(var i=0;i<curCookieJson.length;i++){
			      for(var j=0; j<curCookieJson.length-i-1; j++) {
			          if (curCookieJson[j].counts > curCookieJson[j+1].counts) {
			          	 temp_name = curCookieJson[j+1].name;
			          	 temp_value = curCookieJson[j+1].counts;
							     curCookieJson[j+1].name = curCookieJson[j].name;
							     curCookieJson[j+1].counts = curCookieJson[j].counts;
							     curCookieJson[j].name = temp_name;
							     curCookieJson[j].counts = temp_value;
							  }
			      }
			  }
			  
			  var opStrArr = new Array();
			  // 只显示showCount个
			  var m = showCount;
				for(var i=curCookieJson.length-1; i>=0; i--){
					  if(m>0){
			          opStrArr.push(unescape(curCookieJson[i].name));
			          m -=1;
			      }
			      else break;
			  }
			  
			  actb_free(obj,obj,opStrArr);
		}
}

/* 
 * 按照cookie中使用时间倒序，文本框输入匹配
*/
function matchRecentInput(obj,show_count,save_days){
	
		getCookieObj(obj,show_count,save_days);
		if(curCookieJson){
			  var opStrArr = new Array();
			  
			  // 只显示showCount个
			  var m = showCount;
				for(var i=curCookieJson.length-1; i>=0; i--){
					  if(m>0){
			          opStrArr.push(unescape(curCookieJson[i].name));
			          m -=1;
			      }
			      else break;
			  }
			  actb_free(obj,obj,opStrArr);
		}
}

/* 
 * 按照cookie中使用次数倒序显示，不匹配
*/
function recordMaxBtn(obj,show_count,save_days){
	  
		getCookieObj(obj,show_count,save_days);
		
		if(curCookieJson){
			  var temp_name;
			  var temp_value;
			  
			  // 冒泡倒序排列，counts最大的在最后
				for(var i=0;i<curCookieJson.length;i++){
			      for(var j=0; j<curCookieJson.length-i-1; j++) {
			          if (curCookieJson[j].counts > curCookieJson[j+1].counts) {
			          	 temp_name = curCookieJson[j+1].name;
			          	 temp_value = curCookieJson[j+1].counts;
							     curCookieJson[j+1].name = curCookieJson[j].name;
							     curCookieJson[j+1].counts = curCookieJson[j].counts;
							     curCookieJson[j].name = temp_name;
							     curCookieJson[j].counts = temp_value;
							  }
			      }
			  }
			  
			  var opStrArr = new Array();
			  var m = showCount;
			  var arrC = new Array();
			  
				for(var i=curCookieJson.length-1; i>=0; i--){
					  if(m>0){
					  	  arrC=unescape(curCookieJson[i].name).split(' ');
			          opStrArr.push(arrC[1]+' '+arrC[2] + ' C:parent.L('+arrC[0]+',\''+arrC[1]+'\',\''+arrC[2]+'\',\''+arrC[3]+'\',\''+arrC[4]+'\')');
			          m -=1;
			      }
			      else break;
			  }
			  
			  showMenu(obj,opStrArr);
		}
}

/* 
 * 按照cookie中使用时间倒序显示，不匹配
*/
function recordRecentTxt(obj,show_count,save_days){
	
		getCookieObj(obj,show_count,save_days);
		if(curCookieJson){
			  var opStrArr = new Array();
			  var m = showCount;
				for(var i=curCookieJson.length-1; i>=0; i--){
					  if(m>0){
			          opStrArr.push(unescape(curCookieJson[i].name) + ' C:T(\''+obj.id+'\',\''+curCookieJson[i].name+'\','+show_count+','+save_days+')');
			          m -=1;
			      }
			      else break;
			  }
			  showMenu(obj,opStrArr);
		}
}

/* 
 * 保存cookie值
 * saveCookie(当前输入框对象)
*/
function saveCookie(obj,show_count,save_days){
    getCookieObj(obj,show_count,save_days);
	  setCurCookie(obj.value);
}

/* 
 * 保存cookie值
 * saveCookieById(id,value)
*/
function saveCookieById(objId,objValue,show_count,save_days){
    getCookieObjById(objId,show_count,save_days);
	  setCurCookie(objValue);
}

/* 
 * 通过id获取cookie对象
*/
function getCookieObjById(objId,show_count,save_days){
    if(objId){
		    initCookie(objId,show_count,save_days); // 初始化全局变量
		    getCurCookie(); // 获取cookieId的cookie信息
    }else return;
}

/* 
 * 通过对象获取cookie对象
*/
function getCookieObj(obj,show_count,save_days){
    if(obj && obj.id){
		    initCookie(obj.id,show_count,save_days); // 初始化全局变量
		    getCurCookie(); // 获取cookieId的cookie信息
    }else return;
}

/* 
 * 获取cookie对象
*/
function getCurCookie(){
    curCookieContent = getCookieContent();
    curCookieJson = getCookieJson();
}

/* 
 * 初始化参数
 * initCookie(cookie名称,最大保存个数,显示个数,保存天数)
*/
function initCookie(cookie_id,show_count,save_days){
    cookieId = cookie_id;
    var r = /^[0-9]*[1-9][0-9]*$/;
    if(show_count && r.test(show_count)) {
    	  showCount = show_count; 
    	  maxCount = show_count+5; 
    }else{
        showCount = 10;
        maxCount = 15;
    }
    if(save_days && r.test(save_days)) days = save_days;
    date.setTime(date.getTime()+days*24*60*60*1000);
}

/* 
 * 设置cookie值
 * setCurCookie(新增cookie条目值)
*/
function setCurCookie(cvalue){
	 
	 if(navigator.cookieEnabled && cvalue && cvalue!=''){ 
	 	  
		  if(curCookieContent){
		  	  // 读取转换后的Json对象
		  	  if(curCookieJson){ 
		  	  	  // 内容在cookie中已存在则计数器增1，不存在则新增条目
						  if(getItemCounts(cvalue) > 0){ // 已存在
						  	  setItemCounts(cvalue);     
						  }
						  else if(curCookieJson.length < maxCount){ 
						  	  addCookieItem(cvalue);
						  }
						  else{
						  	  replaceCookieItem(cvalue);
						  }
				  }
				  else{
				      newCookie(cvalue);
				  }
		  }
		  // 无cookie记录
		  else{
		      newCookie(cvalue);
		  }
	 }
}   

/* 
 * 读取cookie
*/
function getCookieContent(){
	 if(navigator.cookieEnabled){
			 var curCookie = document.cookie.match(new RegExp("(^| )"+cookieId+"=([^;]*)(;|$)"));
		   if(curCookie != null){
		       return curCookie[2];
		   }
   }
   return null;
}

/* 
 * 转换cookie内容为Json对象
*/
function getCookieJson(){   
   if(curCookieContent != null){
   	   return eval(curCookieContent);
   }
   return null;
}

/* 
 * 新增cookie
*/
function newCookie(cvalue){
    document.cookie=cookieId+'=[{name:\''+escape(cvalue)+'\',counts:1}];expires='+date.toGMTString()+';path=/';
}

/* 
 * 读取cookie某条目counts值
*/
function getItemCounts(cvalue){
   for(var i=0;i<curCookieJson.length;i++){
       if(unescape(curCookieJson[i].name)==cvalue){
           return curCookieJson[i].counts;
       }
   }
   return 0;
}

/* 
 * 累加cookie条目计数值，并且将此条目重置为最新
*/
function setItemCounts(cvalue){ 
   var cur = '[';
   var cnt = 0;
   for(var i=0; i<curCookieJson.length; i++){
       if(unescape(curCookieJson[i].name)==cvalue){
           cnt = curCookieJson[i].counts+1;
       }else{
           cur += '{name:\''+curCookieJson[i].name+'\',counts:'+curCookieJson[i].counts+'},';
       }
   }
   cur += '{name:\''+escape(cvalue)+'\',counts:'+cnt+'}]';
   document.cookie=cookieId+'='+cur+';expires='+date.toGMTString()+';path=/';
}

/* 
 * 新增cookie项
*/
function addCookieItem(cvalue){
    var cur = curCookieContent;
	  cur = cur.substr(0,cur.lastIndexOf(']'))+',{name:\''+escape(cvalue)+'\',counts:1}]';
    document.cookie=cookieId+'='+cur+';expires='+date.toGMTString()+';path=/';
}

/* 
 * 用新项替换cookie中使用最少项
*/
function replaceCookieItem(cvalue){
	  var cur = '[';
	  var flag = 0;
	  var minCount = curCookieJson[0].counts;
	  
	  // 找出cookie条目中counts最小值
	  for(var i=1; i<curCookieJson.length; i++){ 
	      if(minCount==1) break;
	      if(curCookieJson[i].counts < minCount){
	          minCount = curCookieJson[i].counts;
	      }
	  }
	  // 替换cookie中counts值最小的条目
    for(var i=0; i<curCookieJson.length; i++){
    	  // 没有替换过
    	  if(flag == 0){ 
    	  	  // 删除（跳过）第一个counts最小的条目，在cookie末尾追加新增条目
		        if(curCookieJson[i].counts==minCount){ 
		        	  flag = 1;
		        }else{
		            cur += '{name:\''+curCookieJson[i].name+'\',counts:'+curCookieJson[i].counts+'},';
		        }
	      }
	      // 已替换过
	      else{ 
	          cur += '{name:\''+curCookieJson[i].name+'\',counts:'+curCookieJson[i].counts+'},';
	      }
    }
    
    cur += '{name:\''+escape(cvalue)+'\',counts:1}]';
    document.cookie=cookieId+'='+cur+';expires='+date.toGMTString()+';path=/';
}

/* 
 * 显示cookie
*/
function showCookie(cookieId,obj){
	var curCookie = document.cookie.match(new RegExp("(^| )"+cookieId+"=([^;]*)(;|$)"));
   if(curCookie != null){
       if(document.all){
           document.getElementById(obj).innerText=unescape(curCookie[2]);
       }else{
           document.getElementById(obj).textContent=unescape(curCookie[2]);
       }
   }
   else{
       if(document.all){
           document.getElementById(obj).innerText='';
       }else{
           document.getElementById(obj).textContent='';
       }
   }
}

/* 
 * 清除cookie
*/
function clearCurCookie(cookieId){   
	 var date=new Date();   
	 date.setTime(date.getTime()-1);
	 document.cookie=cookieId+'=;expires='+date.toGMTString()+';path=/';   
}

// 获取对象
function gId(o){
    return document.getElementById(o);
}



/*** 不匹配显示下拉框 ***/

var bef_alisTableId ; //记录上次的对象，一个页面多个事件的情况
var bef_objs_id;

function showMenu(objs,ca)
{   
    this.menu_keywords = ca;
	  this.menu_bgColor = '#fff';
	  this.menu_textColor = '#000';
	  this.menu_hColor = '#fefe9c';
	  this.menu_fSize = '12px';
	  
	  this.alisTableId = "menu_"+objs.id;
    
    var menu_self = this;
		
		menu_generate();
		document.onclick=function(){hiddenMenuAlis()};
	  //addEvent(document,"click",hiddenMenuAlis);
	  
		function hiddenMenuAlis(){ // 点击页面其他区域隐藏弹出层
			  var e = getEvent();  
	      var elem = e.srcElement||e.target;
	      if(elem.id != this.alisTableId && elem.id != bef_objs_id && document.getElementById(this.alisTableId)){
		      	menu_removedisp(this.alisTableId);
	      }
	      if(!document.getElementById(this.alisTableId)){
					  document.onclick=function(){};
					  //removeEvent(document,"click",hiddenMenuAlis);
				}
	    }
	    
	    function getEvent(){ //同时兼容ie和ff的写法
	         if(document.all)    return window.event;        
	         func=getEvent.caller;            
	         while(func!=null){    
	             var arg0=func.arguments[0];
	             if(arg0){
	                 if((arg0.constructor==Event || arg0.constructor ==MouseEvent)
	                     || (typeof(arg0)=="object" && arg0.preventDefault && arg0.stopPropagation)){    
	                     return arg0;
	                 }
	             }
	             func=func.caller;
	         }
	         return null;
		 }
    
    
		function menu_generate(){
				
				menu_removedisp(this.alisTableId);
				menu_removedisp(bef_alisTableId);
				
				bef_alisTableId=this.alisTableId;
				bef_objs_id=objs.id;
				
				var cdiv=document.createElement("div");
				cdiv.id=this.alisTableId;
				cdiv.style.position='absolute';
				cdiv.style.overflow="visible";
				cdiv.className='tat_table';
				cdiv.style.zIndex=51;
				cdiv.innerHTML='<iframe id="menu_iframe_'+objs.id+'" style="position:absolute" scrolling="no"	frameborder="0" src="about:blank"></iframe>';
				cdiv.style.top = eval(curTop(objs) + objs.offsetHeight) + 5 + "px";
				cdiv.style.left = curLeft(objs) + "px";
				
				a = document.createElement('table');
				a.style.width="200px"
				a.cellSpacing='0px';
				a.cellPadding='0px';
				a.style.position='absolute';
				a.style.backgroundColor=menu_self.menu_bgColor;
				a.style.filter = "progid:DXImageTransform.Microsoft.Shadow(Color=#dddddd,Direction=120,strength=4);";
				cdiv.appendChild(a);
				document.body.appendChild(cdiv);
				
				var j = 1;
				var iner = '';
				var fun = '';
				var oS = '';
				
				for (var i=0;i<menu_self.menu_keywords.length;i++){
					
						r = a.insertRow(-1);
						r.id = 'tat_tr'+(j);
						c = r.insertCell(-1);
						c.style.backgroundColor = menu_self.menu_bgColor;
						c.style.color = menu_self.menu_textColor;
						c.style.fontSize = menu_self.menu_fSize;
						
						oS = menu_self.menu_keywords[i];
						if(oS.indexOf('C:')>-1){
						    iner = trim(oS.substring(0,oS.indexOf('C:')));
						    fun = trim(oS.substring(oS.indexOf('C:')+2));
						}else{
						    iner = trim(oS);
						}
						c.innerHTML = iner;
						c.hiddenFun = fun;
						
						c.id = 'tat_td'+(j);
						c.style.cursor = 'pointer';
						c.onclick = function(){menu_mouseclick(this)};
						c.onmouseover = function(){menu_mouseover(this)};
						c.onmouseout = function(){menu_mouseout(this)};
						j++;
				}
				
			  document.getElementById("menu_iframe_"+objs.id).style.height=document.getElementById(this.alisTableId).offsetHeight;
			  document.getElementById("menu_iframe_"+objs.id).style.width=document.getElementById(this.alisTableId).offsetWidth;
		}
		
		function menu_mouseclick(o){
		    
				var fun = o.hiddenFun;
		    
		    if(o.hiddenFun!=''){ //执行方法
		        try{
		          eval(fun);
		        }catch(e){}
		    }
		    menu_removedisp(this.alisTableId);
		}
		
		function menu_mouseover(o){
		    o.style.backgroundColor = menu_self.menu_hColor;
		}
		
		function menu_mouseout(o){
		    o.style.backgroundColor = menu_self.menu_bgColor;
		}
		
		function menu_removedisp(_id){
				if(_id && document.getElementById(_id)){ 
					  document.body.removeChild(document.getElementById(_id));
				}
		}
		
		function trim(str){
    		return str.replace(/^\s*(\S*(\s+\S+)*)\s*$/, "$1");
		}
	}

/* Event Functions */
// 追加事件
// Add an event to the obj given
// event_name refers to the event trigger, without the "on", like click or mouseover
// func_name refers to the function callback when event is triggered
function addEvent(obj,event_name,func_name){
	if (obj.attachEvent){
		obj.attachEvent("on"+event_name, func_name);
	}else if(obj.addEventListener){
		obj.addEventListener(event_name,func_name,true);
	}else{
		obj["on"+event_name] = func_name;
	}
}

// Removes an event from the object
function removeEvent(obj,event_name,func_name){
	if (obj.detachEvent){
		obj.detachEvent("on"+event_name,func_name);
	}else if(obj.removeEventListener){
		obj.removeEventListener(event_name,func_name,true);
	}else{
		obj["on"+event_name] = null;
	}
}

/* --- Escape --- */

/* Offset position from top of the screen */
function curTop(obj){
	toreturn = 0;
	while(obj){
		toreturn += obj.offsetTop;
		obj = obj.offsetParent;
	}
	return toreturn;
}
function curLeft(obj){
	toreturn = 0;
	while(obj){
		toreturn += obj.offsetLeft;
		obj = obj.offsetParent;
	}
	return toreturn;
}
/* ------ End of Offset function ------- */

