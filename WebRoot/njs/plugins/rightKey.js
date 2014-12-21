/*
 *右键记录文本框近十次输入
 *2009-12-05 14:30
 */
uif.rightKeyMemo={
    rigC: {
		focusObject:null,
	 	Ele:null,
		menuCreate:function(){                                  //画一个右键的面板
			var rt = document.getElementById("rightout");
			if(rt){
				document.body.removeChild(rt);
				}
			var rightout = document.createElement("div");
	 		rightout.setAttribute("id","rightout");
	 		
	 		var divif = document.createElement("iframe");           //解决ie6下div无法遮住select框的问题
	 		divif.setAttribute("id","divif");
	 		divif.src = "about:blank";
	 		
	 		var rightKeyMenu = document.createElement("div");
	 		rightKeyMenu.setAttribute("id","rightKeyMenu");
	 		rightKeyMenu.className = "rightMenu";
	 		
	 		var copy_div = document.createElement("div");
	 		
	 		copy_div.onclick = function(){
	 			if(document.all){
	 			    document.execCommand("Copy");
	 			}else{
	 			    if(document.getSelection()!=''){ //光标覆盖选中文字所在源是页面document文字
	 			        uif.rightKeyMemo.rigC.CopyToClipboard_ff(document.getSelection());
	 			    }else{ //光标覆盖选中文字所在源是页面input对象
	 			        var o=uif.rightKeyMemo.rigC.Ele;
	 			        alert(o.files.length);
	 			        if(o.selectionStart){
	 			            uif.rightKeyMemo.rigC.CopyToClipboard_ff(o.value.substr(o.selectionStart, o.selectionEnd - o.selectionStart));
	 			        }
	 			    }
	 			}
	 			
	 		}
	 		
	 		uif.mxResources.add(globalPathRoot+'/njs/resources/uif');
	 		
	 		var _copy = document.createElement("input");
	 		_copy.type = "button";
	 		_copy.value = uif.mxResources.get('copy','copy');
	 		copy_div.appendChild(_copy);
	 		//捕获事件源
	 		this.Ele = arguments.callee.caller.arguments[0].target;
	 		            
	 		var paste_div = document.createElement("div");
	 		
	 		paste_div.onclick = function(){
	 		    if(document.all){
		 			uif.rightKeyMemo.rigC.Ele.focus();                       
		 			document.execCommand("Paste");
	 		    }else{
	 		        uif.rightKeyMemo.rigC.Ele.focus();
	 		        try{
	 		            uif.rightKeyMemo.rigC.focusObject.value=uif.rightKeyMemo.rigC.PasteFromClipboard_ff();
	 		        }catch(e){}
	 		    }
	 		}
	 		
	 		var _paste = document.createElement("input");
	 		_paste.type = "button";
	 		_paste.value = uif.mxResources.get('paste','paste');
	 		paste_div.appendChild(_paste);
	 		
	 		rightout.appendChild(divif);
	 		rightKeyMenu.appendChild(copy_div);
	 		rightKeyMenu.appendChild(paste_div);
	 		rightout.appendChild(rightKeyMenu);
	 		
	 		document.body.appendChild(rightout);
	 		
	 	    var _rightout = document.getElementById("rightout");
	 	    
	 		_rightout.style.left = arguments.callee.caller.arguments[0].pageX+'px';
		    _rightout.style.top = arguments.callee.caller.arguments[0].pageY+(document.body.scrollTop||document.documentElement.scrollTop)+'px';

		    _rightout.style.display = "none";           //在未添加cookie数据前先将右键面板隐藏
	 	},
		menuShow: function(){                          //展示右键面板
			var rightout = document.getElementById("rightout");
			rightout.style.display = "block";
			document.getElementById("divif").style.height = rightout.offsetHeight;
		},
		menuHide: function(){
			var rightout = document.getElementById("rightout");
			if(rightout){
				document.body.removeChild(rightout);
			}
		},
		CopyToClipboard_ff: function (meintext){
			if (window.clipboardData) {
				// the IE-manier
				window.clipboardData.setData("Text", meintext);
			}
			else if (window.netscape) {
				// dit is belangrijk maar staat nergens duidelijk vermeld:
				// you have to sign the code to enable this, or see notes below
				try {   
	                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");   
	           } catch (e) {   
	               alert("被浏览器拒绝！\n请在浏览器地址栏输入'about:config'并回车\n然后将 'signed.applets.codebase_principal_support'设置为'true'");   
	           }   
				
				// maak een interface naar het clipboard
				var clip = Components.classes['@mozilla.org/widget/clipboard;1']
				.createInstance(Components.interfaces.nsIClipboard);
				if (!clip) return;
				//alert(clip);
				// maak een transferable
				var trans = Components.classes['@mozilla.org/widget/transferable;1']
				.createInstance(Components.interfaces.nsITransferable);
				if (!trans) return;
				
				// specificeer wat voor soort data we op willen halen; text in dit geval
				trans.addDataFlavor('text/unicode');
				
				// om de data uit de transferable te halen hebben we 2 nieuwe objecten
				// nodig om het in op te slaan
				var str = new Object();
				var len = new Object();
				var str = Components.classes["@mozilla.org/supports-string;1"]
				.createInstance(Components.interfaces.nsISupportsString);
				var copytext=meintext;
				str.data=copytext;
				trans.setTransferData("text/unicode",str,copytext.length*2);
				var clipid=Components.interfaces.nsIClipboard;
				if (!clip) return false;
				clip.setData(trans,null,clipid.kGlobalClipboard);
			}
			else {
				return false;
			}
			
			return false;
		},
		PasteFromClipboard_ff: function(){
		    if (window.clipboardData) {
			return (window.clipboardData.getData('text'));
			}
			else {
				if (window.netscape) {
					try {
						netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
						var clip = Components.classes["@mozilla.org/widget/clipboard;1"].createInstance(Components.interfaces.nsIClipboard);
						if (!clip) {
							return;
						}
						var trans = Components.classes["@mozilla.org/widget/transferable;1"].createInstance(Components.interfaces.nsITransferable);
						if (!trans) {
						return;
						}
						trans.addDataFlavor("text/unicode");
						clip.getData(trans, clip.kGlobalClipboard);
						var str = new Object();
						var len = new Object();
						trans.getTransferData("text/unicode", str, len);
					}
					catch (e) {
						alert("您的firefox安全限制限制您进行剪贴板操作，请打开'about:config'将signed.applets.codebase_principal_support'设置为true'之后重试，相对路径为firefox根目录/greprefs/all.js");
						return null;
					}
					if (str) {
						if (Components.interfaces.nsISupportsWString) {
						str = str.value.QueryInterface(Components.interfaces.nsISupportsWString);
						}
						else {
							if (Components.interfaces.nsISupportsString) {
								str = str.value.QueryInterface(Components.interfaces.nsISupportsString);
							}
							else {
							str = null;
							}
						}
					}
					if (str) {
						return (str.data.substring(0, len.value / 2));
					}
				}
			}
			return null; 
		}
	},
	//cookie的写操作
	/************************************************** 
	　参数说明： 
	  sName      Cookie名 
	  sValue     Cookie值
	  oExpires   失效日期
	*************************************************/
	setCookie: function(sName,sValue,oExpires){
	    var cookieNum = this.getCookie("cookieNum")?this.getCookie("cookieNum"):0;
		var flag = 0;
		var k = 1;
		
		if(cookieNum>10) k = cookieNum -9;   //看cookie中是否存了10个以上的值，如果超过10个，则只查看最近输入的10个中是否与此次存值重复
		for(var i=k;i<=cookieNum;i++){      
			var cName = "rkName".concat(i);
			if(sValue==this.getCookie(cName)){
				flag = 1;
				break;
				}
			}
		if(flag==0){                            //近10次存值中没有出现重复值，则进行存cookie操作
			var sCookie = sName + "=" + escape(sValue);
			if(oExpires){
				sCookie += "; expires=" + oExpires.toGMTString()+"; path=/";  // 设置cookie失效日期及cookie的访问路径
			}
			if(sCookie.length<4096){              //判断Cookie总长度是否大于4K
				document.cookie = sCookie;
				return true;                        //返回true，说明存值成功
			}else{
				return false;
			}
		}else{
			return false;
		}
	},
	/**cookie的取操作*/
	getCookie: function(sName){
		var sValue;
		var strCookie = document.cookie;
		var arrCookie = strCookie.split("; ");
		for(var i=0;i<arrCookie.length;i++){
			var arr=arrCookie[i].split("=");
			if(sName==arr[0]){
				sValue=unescape(arr[1]);
				break;
				}
			}
		return sValue;
	},
	/*获取右键选中的值*/
	catchBubble: function(val,obj){         
		if(obj!=null){
	 		obj.value = val;
	 		obj.focus();       //为了为验证validate_class.js提供焦点移开状态
	 		obj = null;
	 		this.focusObject = null;
		}
		this.rigC.menuHide();
	}
}

$("input:text").bind("focus", function(){
	uif.rightKeyMemo.rigC.focusObject=this;
});

/********鼠标移出，记录cookie********/
$("input:text").bind("blur", function(){
	if(this.getAttribute("readonly")==true){
		 return false;
	}else{ 
		var Then = new Date();
		Then.setTime(Then.getTime()+1*3600000);//小时
		Cookie_value = this.value.replace(/(^\s*)|(\s*)|(\s*$)/g, "");
		var cookieNum = uif.rightKeyMemo.getCookie("cookieNum")?uif.rightKeyMemo.getCookie("cookieNum"):0;
		if(Cookie_value){
			cookieNum++;
			Cookie_name = "rkName".concat(cookieNum);      //设置要存的cookie值的名字
			if(uif.rightKeyMemo.setCookie(Cookie_name,Cookie_value,Then)){   //如果cookie值存入成功，设置计数器
				uif.rightKeyMemo.setCookie("cookieNum",cookieNum,Then);
			}
		}
	}
});

/********读取cookie值，展示右键********/
$("input:text").bind("contextmenu", function(){
    if(this.getAttribute("readonly")==true){
		return false;
	}else{
		var o=arguments.callee.caller.arguments[0].target;
		if(o.tagName=="INPUT"){
			uif.rightKeyMemo.rigC.focusObject=o;
		}
		uif.rightKeyMemo.rigC.menuCreate();
				
		var len = uif.rightKeyMemo.getCookie("cookieNum")?uif.rightKeyMemo.getCookie("cookieNum"):0;  //读取cookie中的计数器
		var rightKeyMenu = document.getElementById("rightKeyMenu");
		if(len>0){
			var j = 0;
			if(len>10) j=len-9;                                     ///读取近十次的cookie值
			for(var i=j;i<=len;i++){
				(function(x){
					var aName = "rkName".concat(x);                  //设置要读取的cookie值的名字
					var aValue = uif.rightKeyMemo.getCookie(aName);
					if(aValue){
						var first=rightKeyMenu.firstChild;
						var _div =document.createElement("div");
						first.parentNode.insertBefore(_div,first);
						_div.innerHTML = aValue;
						_div.onclick = function(){
							uif.rightKeyMemo.catchBubble(aValue,uif.rightKeyMemo.rigC.focusObject);     
							}
						}
					}(i))
				}
			}
		uif.rightKeyMemo.rigC.menuShow();
		return false;
	}
});

$(document).bind("contextmenu", function(){
	uif.rightKeyMemo.rigC.menuCreate();
	uif.rightKeyMemo.rigC.menuShow();
	return false;
});

	
/*隐藏右键*/
document.onclick = function(){
	uif.rightKeyMemo.rigC.menuHide();
}