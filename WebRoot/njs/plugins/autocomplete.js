/**快速转入**/
uif.actb= function(objs,objh,ca){
	
	/* ---- Public Variables ---- */
	this.actb_timeOut = -1; // Autocomplete Timeout in ms (-1: autocomplete never time out)
	this.actb_lim = 10;    // Number of elements autocomplete can show (-1: no limit)
	this.actb_firstText = false; // should the auto complete be limited to the beginning of keyword?
	this.actb_mouse = true; // Enable Mouse Support
	this.actb_delimiter = new Array(';',',');  // Delimiter for multiple autocomplete. Set it to empty array for single autocomplete
	this.actb_startcheck = 1; // Show widget only after this number of characters is typed in.
	/* ---- Public Variables ---- */
	
	/* --- Styles --- */
	this.actb_bgColor = '#fff';
	this.actb_textColor = '#000';
	this.actb_hColor = '#fefe9c';
	this.actb_fFamily = 'Verdana';
	this.actb_fSize = '12px';
	this.actb_hStyle = 'color:#ff8500;text-decoration:underline;font-weight="bold"';
	/* --- Styles --- */
	
	/* ---- Private Variables ---- */
	var actb_delimwords = new Array();
	var ex=" ";
	var actb_cdelimword = 0;
	var actb_delimchar = new Array();
	var actb_display = false;
	var actb_pos = 0;
	var actb_total = 0;
	var actb_curr = null;
	var actb_hidden = null;
	var actb_rangeu = 0;
	var actb_ranged = 0;
	var actb_bool = new Array();
	var actb_pre = 0;
	var actb_toid;
	var actb_tomake = false;
	var actb_getpre = "";
	var actb_mouse_on_list = 1;
	var actb_kwcount = 0;
	var actb_caretmove = false;
	this.actb_keywords = new Array();
	/* ---- Private Variables---- */
	
	this.actb_keywords = ca;
	var actb_self = this;
	
	actb_curr = objs; //文本框对象
	actb_hidden = objh; //隐藏对象
	
	//文本框获取焦点绑定事件
	//addEvent(actb_curr,"focus",actb_setup);
	$(actb_curr).bind("focus",function(){actb_setup();});
	//绑定事件
	function actb_setup(){
		//addEvent(document,"keydown",actb_checkkey);
		//addEvent(actb_curr,"blur",actb_clear);
		//addEvent(document,"keypress",actb_keypress);
			
		$(document).bind("keydown",actb_checkkey);
		$(actb_curr).bind("blur",actb_clear);
		$(document).bind("keypress",actb_keypress);
	}
	
	//取消事件绑定恢复初始状态
	function actb_clear(evt){
		if (!evt) evt = event;
		//removeEvent(document,"keydown",actb_checkkey);
		//removeEvent(actb_curr,"blur",actb_clear);
		//removeEvent(document,"keypress",actb_keypress);
			
		$(document).unbind("keydown",actb_checkkey);
		$(actb_curr).unbind("blur",actb_clear);
		$(document).unbind("keypress",actb_keypress);
		actb_removedisp();
	}
	//解析用户每输入一个字符在结果列表中着重显示该字符 拼接好显示的html代码
	function actb_parse(nn){
		
		//nn的格式 “0121 签退 QT”
		//去掉拼音显示 add by zengwan 
		var arrTemp = nn.split(" ");
		var n ="";
		for(i=0;i<arrTemp.length-1;i++){
			 if(i==0){
			 	n += arrTemp[i];		
			 }else{
			 	n += " " + 	arrTemp[i];		
			 }
		}
		//end by zengwan
		//n的格式 “0121 签退”
		
		if (actb_self.actb_delimiter.length > 0){
			var t = $.trim(actb_delimwords[actb_cdelimword]).addslashes();
			var plen = $.trim(actb_delimwords[actb_cdelimword]).length;
				
			}else{
			var t = actb_curr.value.addslashes();
			var plen = actb_curr.value.length;
		}
		var tobuild = '';
		var i;
		if (actb_self.actb_firstText){
			var re = new RegExp("^" + t, "i");
		}else{
			var re = new RegExp(t, "i");
		}
		var p = n.search(re);
			
			if( p == -1) p += 1;
			
			for (i=0;i<p;i++){
			tobuild += n.substr(i,1);
		}
		tobuild += "<font style='"+(actb_self.actb_hStyle)+"'>"
		for (i=p;i<plen+p;i++){
			tobuild += n.substr(i,1);
		}
		tobuild += "</font>";
			for (i=plen+p;i<n.length;i++){
			tobuild += n.substr(i,1);
		}
			
			return tobuild;
	}
	//生成提示框
	function actb_generate(){
		if (document.getElementById('tat_tablediv')){ actb_display = false;document.body.removeChild(document.getElementById('tat_tablediv')); } 
		if (actb_kwcount == 0){
			actb_display = false;
			return;
		}
		var cdiv=document.createElement("div");
		cdiv.id="tat_tablediv";
		//cdiv.width="200px";
		cdiv.style.position='absolute';
		cdiv.style.overflow="visible";
		cdiv.style.zIndex=51;
		cdiv.innerHTML='<iframe id="div_iframe" style="position:absolute" scrolling="no"	frameborder="0" src="about:blank"></iframe>';
		cdiv.style.top = eval(curTop(actb_curr) + actb_curr.offsetHeight) + 5 + "px";
		cdiv.style.left = curLeft(actb_curr) + "px";
		a = document.createElement('table');
		a.width="200px";
		a.cellSpacing='0px';
		a.cellPadding='0px';
			a.style.position='absolute';
			a.border='0px';
		//a.style.position='absolute';
		//a.style.zIndex=51;
		//a.style.top = eval(curTop(actb_curr) + actb_curr.offsetHeight) + 5 + "px";
		//a.style.left = curLeft(actb_curr) + "px";
		a.style.backgroundColor=actb_self.actb_bgColor;
		
		a.style.filter = "progid:DXImageTransform.Microsoft.Shadow(Color=#dddddd,Direction=120,strength=4);";
		a.id = 'tat_table';
			cdiv.appendChild(a);
			document.body.appendChild(cdiv);
		var i;
		var first = true;
		var j = 1;
		if (actb_self.actb_mouse){
			a.onmouseout = actb_table_unfocus;
			a.onmouseover = actb_table_focus;
		}
		var counter = 0;
		for (i=0;i<actb_self.actb_keywords.length;i++){
			if (actb_bool[i]){
				counter++;
				r = a.insertRow(-1);
				if (first && !actb_tomake){
					r.style.backgroundColor = actb_self.actb_hColor;
					first = false;
					actb_pos = counter;
				}else if(actb_pre == i){
					r.style.backgroundColor = actb_self.actb_hColor;
					first = false;
					actb_pos = counter;
				}else{
					r.style.backgroundColor = actb_self.actb_bgColor;
				}
				r.id = 'tat_tr'+(j);
				c = r.insertCell(-1);
				c.style.color = actb_self.actb_textColor;
				c.style.fontFamily = actb_self.actb_fFamily;
				c.style.fontSize = actb_self.actb_fSize;
				c.innerHTML = actb_parse(actb_self.actb_keywords[i]);
				c.id = 'tat_td'+(j);
				c.setAttribute('pos',j);
				if (actb_self.actb_mouse){
					c.style.cursor = 'pointer';
					c.onclick=actb_mouseclick;
					c.onmouseover = actb_table_highlight;
				}
				j++;
			}
			if( j - 1 == actb_self.actb_lim && j < actb_total){
				r = a.insertRow(-1);
				r.style.backgroundColor = actb_self.actb_bgColor;
				c = r.insertCell(-1);
				c.style.color = actb_self.actb_textColor;
				c.style.fontFamily = 'arial narrow';
				c.style.fontSize = actb_self.actb_fSize;
				c.align='center';
				replaceHTML(c,'\\/');
				if (actb_self.actb_mouse){
					c.style.cursor = 'pointer';
					c.onclick = actb_mouse_down;
				}
				break;
			}
		}
		actb_rangeu = 1;
		actb_ranged = j-1;
		actb_display = true;
		if (actb_pos <= 0) actb_pos = 1;
		 document.getElementById("div_iframe").style.height=document.getElementById("tat_table").offsetHeight;
		 document.getElementById("div_iframe").style.width=document.getElementById("tat_table").offsetWidth;
	}
	function actb_remake(){
		document.body.removeChild(document.getElementById('tat_tablediv'));
		var cdiv=document.createElement("div");
		cdiv.id="tat_tablediv";
		//cdiv.width="200px";
		cdiv.style.position='absolute';
		cdiv.style.overflow="visible";
		cdiv.style.zIndex=51;
		cdiv.innerHTML='<iframe id="div_iframe" style="position:absolute" scrolling="no"	frameborder="0" src="about:blank"></iframe>';
		cdiv.style.top = eval(curTop(actb_curr) + actb_curr.offsetHeight) + 5 + "px";
		cdiv.style.left = curLeft(actb_curr) + "px";
		a = document.createElement('table');
		a.width="200px";
		a.cellSpacing='0px';
		a.cellPadding='0px';
			
		a.border='0px';
		a.style.position='absolute';
		//a.style.zIndex=51;
		//a.style.top = eval(curTop(actb_curr) + actb_curr.offsetHeight) + 5 + "px";
		//a.style.left = curLeft(actb_curr) + "px";
		a.style.backgroundColor=actb_self.actb_bgColor;
			
		a.style.filter = "progid:DXImageTransform.Microsoft.Shadow(Color=#dddddd,Direction=120,strength=4);";
		a.id = 'tat_table';
		cdiv.appendChild(a);
		document.body.appendChild(cdiv);
		var i;
		var first = true;
		var j = 1;
		if (actb_self.actb_mouse){
			a.onmouseout = actb_table_unfocus;
			a.onmouseover = actb_table_focus;
		}
	    
	    var i;
			var first = true;
			var j = 1;
			//向上翻页
			if (actb_rangeu > 1){
				r = a.insertRow(-1);
				c = r.insertCell(-1);
				c.style.backgroundColor = actb_self.actb_bgColor;
				c.style.color = actb_self.actb_textColor;
				c.style.fontFamily = 'arial narrow';
				c.style.fontSize = actb_self.actb_fSize;
				c.align='center';
				replaceHTML(c,'/\\');
				if (actb_self.actb_mouse){
					c.style.cursor = 'pointer';
					c.onclick = actb_mouse_up;
				}
			}
			for (i=0;i<actb_self.actb_keywords.length;i++){
				if (actb_bool[i]){
					if (j >= actb_rangeu && j <= actb_ranged){
						r = a.insertRow(-1);
						r.id = 'tat_tr'+(j);
						c = r.insertCell(-1);
						c.style.backgroundColor = actb_self.actb_bgColor;
						c.style.color = actb_self.actb_textColor;
						c.style.fontFamily = actb_self.actb_fFamily;
						c.style.fontSize = actb_self.actb_fSize;
						c.innerHTML = actb_parse(actb_self.actb_keywords[i]);
						c.id = 'tat_td'+(j);
						c.setAttribute('pos',j);
						if (actb_self.actb_mouse){
							c.style.cursor = 'pointer';
							c.onclick=actb_mouseclick;
							c.onmouseover = actb_table_highlight;
						}
						j++;
					}else{
						j++;
					}
				}
				if (j > actb_ranged) break;
			}
			//向下翻页
			if (j-1 < actb_total){
				r = a.insertRow(-1);
				c = r.insertCell(-1);
				c.style.backgroundColor = actb_self.actb_bgColor;
				c.style.color = actb_self.actb_textColor;
				c.style.fontFamily = 'arial narrow';
				c.style.fontSize = actb_self.actb_fSize;
				c.align='center';
				replaceHTML(c,'\\/');
				if (actb_self.actb_mouse){
					c.style.cursor = 'pointer';
					c.onclick = actb_mouse_down;
				}
			}
			
		 document.getElementById("div_iframe").style.height=document.getElementById("tat_table").offsetHeight;
		 document.getElementById("div_iframe").style.width=document.getElementById("tat_table").offsetWidth;
	}
	function actb_goup(){
			
		if (!actb_display) return;
		if (actb_pos == 1) return;
			
		document.getElementById('tat_td'+actb_pos).style.backgroundColor = actb_self.actb_bgColor;
		actb_pos--;
		if (actb_pos < actb_rangeu) actb_moveup();
		document.getElementById('tat_td'+actb_pos).style.backgroundColor = actb_self.actb_hColor;
		if (actb_toid) clearTimeout(actb_toid);
		if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function(){actb_mouse_on_list=0;actb_removedisp();},actb_self.actb_timeOut);
	}
	function actb_godown(){
		if (!actb_display) return;
		if (actb_pos == actb_total) return;
			
		document.getElementById('tat_td'+actb_pos).style.backgroundColor = actb_self.actb_bgColor;
			
		actb_pos++;
		if (actb_pos > actb_ranged) actb_movedown();
		document.getElementById('tat_td'+actb_pos).style.backgroundColor = actb_self.actb_hColor;
		if (actb_toid) clearTimeout(actb_toid);
		if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function(){actb_mouse_on_list=0;actb_removedisp();},actb_self.actb_timeOut);
	}
	function actb_movedown(){
		actb_rangeu++;
		actb_ranged++;
		actb_remake();
	}
	function actb_moveup(){
		actb_rangeu--;
		actb_ranged--;
		actb_remake();
	}
	
	/* Mouse */
	function actb_mouse_down(){
		document.getElementById('tat_td'+actb_pos).style.backgroundColor = actb_self.actb_bgColor;
		actb_pos++;
		actb_movedown();
		document.getElementById('tat_td'+actb_pos).style.backgroundColor = actb_self.actb_hColor;
		actb_curr.focus();
		actb_mouse_on_list = 0;
		if (actb_toid) clearTimeout(actb_toid);
		if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function(){actb_mouse_on_list=0;actb_removedisp();},actb_self.actb_timeOut);
	}
	function actb_mouse_up(evt){
		if (!evt) evt = event;
		if (evt.stopPropagation){
			evt.stopPropagation();
		}else{
			evt.cancelBubble = true;
		}
		document.getElementById('tat_td'+actb_pos).style.backgroundColor = actb_self.actb_bgColor;
		actb_pos--;
		actb_moveup();
		document.getElementById('tat_td'+actb_pos).style.backgroundColor = actb_self.actb_hColor;
		actb_curr.focus();
		actb_mouse_on_list = 0;
		if (actb_toid) clearTimeout(actb_toid);
		if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function(){actb_mouse_on_list=0;actb_removedisp();},actb_self.actb_timeOut);
	}
	function actb_mouseclick(evt){
		if (!evt) evt = event;
		if (!actb_display) return;
		actb_mouse_on_list = 0;
		actb_pos = this.getAttribute('pos');
		actb_penter();
	}
	function actb_table_focus(){
		actb_mouse_on_list = 1;
	}
	function actb_table_unfocus(){
		actb_mouse_on_list = 0;
		if (actb_toid) clearTimeout(actb_toid);
		if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function(){actb_mouse_on_list = 0;actb_removedisp();},actb_self.actb_timeOut);
	}
	function actb_table_highlight(){
		actb_mouse_on_list = 1;
		document.getElementById('tat_td'+actb_pos).style.backgroundColor = actb_self.actb_bgColor;
		actb_pos = this.getAttribute('pos');
			
		while (actb_pos < actb_rangeu) actb_moveup();
		while (actb_pos > actb_ranged) actb_movedown();
		document.getElementById('tat_td'+actb_pos).style.backgroundColor = actb_self.actb_hColor;
			
		if (actb_toid) clearTimeout(actb_toid);
		if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function(){actb_mouse_on_list = 0;actb_removedisp();},actb_self.actb_timeOut);
	}

	function actb_penter(){
		if (!actb_display) return;
		actb_display = false;
		var word = '';
		var c = 0;
	
	
		for (var i=0;i<=actb_self.actb_keywords.length;i++){
			if (actb_bool[i]) c++;
			if (c == actb_pos){
				word = actb_self.actb_keywords[i];
				break;
			}
		}
		//add by by 20080408 start
		 actb_curr.value = word;
		 actb_hidden.value = i;
			 
		//alert(actb_hidden.value);
		 actb_mouse_on_list = 0;
		 actb_removedisp();
		//end
		//actb_insertword(word);  modify by 20080408
		l = getCaretStart(actb_curr);
		//调用main.jsp页面方法
		if((typeof quicknav)=="function")
		{
			//alert(content_array[actb_hidden.value]);
			quicknav(content_array[actb_hidden.value]);
		}
	}
	
	//增加了回车的动作，防止营业员输入opcode过快 by shibc 20080721
	function actb_enter_penter(){
		var _tbval = objh.value;
		if (!actb_display) return;
		actb_display = false;
		var word = '';
		var c = 0;
	
		//alert("_tbval="+_tbval); 
		for (var i=0;i<=actb_self.actb_keywords.length;i++){
			if (actb_bool[i]) c++;
			if (c == actb_pos){
				word = actb_self.actb_keywords[i];
					//alert("word="+word);
					break;
			}
		}
		//add by by 20080408 start
		 actb_curr.value = word;
		 actb_hidden.value = i;
		 actb_mouse_on_list = 0;
		 actb_removedisp();
		//end
		//actb_insertword(word);  modify by 20080408
		l = getCaretStart(actb_curr);
		//获取输入op_code
		/***
			
			for(var cindex=0;cindex<content_array.length;cindex++)
		{
			var ctmp = content_array[cindex];
			//add by zengwan
				ctmp_temp = ctmp.split(",");
				//end
				
			if(ctmp_temp[1]==_tbval)
			{
				//alert("ctmp[1]="+ctmp[1]);
				//调用main.jsp页面方法
				quicknav(ctmp);
				return;
			}
		}
			
			***/
		if((typeof quicknav)=="function")
		{
				
				quicknav(content_array[actb_hidden.value]);
		}
	}
	
	function actb_removedisp(){
		if (actb_mouse_on_list==0){
			actb_display = 0;
			if (document.getElementById('tat_tablediv')){ document.body.removeChild(document.getElementById('tat_tablediv')); }
			if (actb_toid) clearTimeout(actb_toid);
		}
	}
	function actb_keypress(e){
		if (actb_caretmove) stopEvent(e);
		return !actb_caretmove;
	}
	function actb_checkkey(evt){
			
		if (!evt) evt = event;
		a = evt.keyCode;
		caret_pos_start = getCaretStart(actb_curr);
		actb_caretmove = 0;
		//add by 20080408 start
		actb_hidden.value = -1;
		//end
		switch (a){
			case 38:
				actb_goup();
				actb_caretmove = 1;
				return false;
				break;
			case 40:
				actb_godown();
				actb_caretmove = 1;
				return false;
				break;
			case 13: case 9:
				if (actb_display){
					actb_caretmove = 1;
					//actb_penter();
					actb_enter_penter();
					return false;
				}else{
					return true;
				}
				break;
			default:
				setTimeout(function(){actb_tocomplete(a)},50);
				break;
		}
	}
	
	function actb_tocomplete(kc){
		if (kc == 38 || kc == 40 || kc == 13) return;
		var i;
		if (actb_display){ 
			var word = 0;
			var c = 0;
			for (var i=0;i<=actb_self.actb_keywords.length;i++){
				if (actb_bool[i]) c++;
				if (c == actb_pos){
					word = i;
					break;
				}
			}
			actb_pre = word;
		}else{ actb_pre = -1};
		
		if (actb_curr.value == ''){
			actb_mouse_on_list = 0;
			actb_removedisp();
			return;
		}
		if (actb_self.actb_delimiter.length > 0){
			caret_pos_start = getCaretStart(actb_curr);
			caret_pos_end = getCaretEnd(actb_curr);
			
			delim_split = '';
			for (i=0;i<actb_self.actb_delimiter.length;i++){
				delim_split += actb_self.actb_delimiter[i];
			}
			delim_split = delim_split.addslashes();
			delim_split_rx = new RegExp("(["+delim_split+"])");
			c = 0;
			actb_delimwords = new Array();
			actb_delimwords[0] = '';
			for (i=0,j=actb_curr.value.length;i<actb_curr.value.length;i++,j--){
				if (actb_curr.value.substr(i,j).search(delim_split_rx) == 0){
					ma = actb_curr.value.substr(i,j).match(delim_split_rx);
					actb_delimchar[c] = ma[1];
					c++;
					actb_delimwords[c] = '';
				}else{
					actb_delimwords[c] += actb_curr.value.charAt(i);
				}
			}
	
	
			var l = 0;
			actb_cdelimword = -1;
			for (i=0;i<actb_delimwords.length;i++){
				if (caret_pos_end >= l && caret_pos_end <= l + actb_delimwords[i].length){
					actb_cdelimword = i;
				}
				l+=actb_delimwords[i].length + 1;
			}
			var ot = $.trim(actb_delimwords[actb_cdelimword]); 
			var t = $.trim(actb_delimwords[actb_cdelimword].addslashes());
		}else{
			var ot = actb_curr.value;
			var t = actb_curr.value.addslashes();
		}
		if (ot.length == 0){
			actb_mouse_on_list = 0;
			actb_removedisp();
		}
		if (ot.length < actb_self.actb_startcheck) return this;
		if (actb_self.actb_firstText){
			var re = new RegExp("^" + t, "i");
		}else{
			var re = new RegExp(t, "i");
		}
	
	
		actb_total = 0;
		actb_tomake = false;
		actb_kwcount = 0;
		for (i=0;i<actb_self.actb_keywords.length;i++){
			actb_bool[i] = false;
			if (re.test(actb_self.actb_keywords[i])){
				actb_total++;
				actb_bool[i] = true;
				actb_kwcount++;
				if (actb_pre == i) actb_tomake = true;
			}
		}
	
	
		if (actb_toid) clearTimeout(actb_toid);
		if (actb_self.actb_timeOut > 0) actb_toid = setTimeout(function(){actb_mouse_on_list = 0;actb_removedisp();},actb_self.actb_timeOut);
		actb_generate();
	}
	
	
	// Stop an event from bubbling up the event DOM
	function stopEvent(evt){
		evt || window.event;
		if (evt.stopPropagation){
			evt.stopPropagation();
			evt.preventDefault();
		}else if(typeof evt.cancelBubble != "undefined"){
			evt.cancelBubble = true;
			evt.returnValue = false;
		}
		return false;
	}
	
	/*    Caret Functions     */
	
	// Get the end position of the caret in the object. Note that the obj needs to be in focus first
	function getCaretEnd(obj){
		if(typeof obj.selectionEnd != "undefined"){
			return obj.selectionEnd;
		}else if(document.selection&&document.selection.createRange){
			var M=document.selection.createRange();
			try{
				var Lp = M.duplicate();
				Lp.moveToElementText(obj);
			}catch(e){
				var Lp=obj.createTextRange();
			}
			Lp.setEndPoint("EndToEnd",M);
			var rb=Lp.text.length;
			if(rb>obj.value.length){
				return -1;
			}
			return rb;
		}
	}
	// Get the start position of the caret in the object
	function getCaretStart(obj){
		if(typeof obj.selectionStart != "undefined"){
			return obj.selectionStart;
		}else if(document.selection&&document.selection.createRange){
			var M=document.selection.createRange();
			try{
				var Lp = M.duplicate();
				Lp.moveToElementText(obj);
			}catch(e){
				var Lp=obj.createTextRange();
			}
			Lp.setEndPoint("EndToStart",M);
			var rb=Lp.text.length;
			//alert(rb);
			if(rb>obj.value.length){
				return -1;
			}
			return rb;
		}
	}
	/*    Escape function   */
	String.prototype.addslashes = function(){
		return this.replace(/(["\\\.\|\[\]\^\*\+\?\$\(\)])/g, '\\$1');
	}
	
	//两端去空格函数
	String.prototype.trim = function() {    return this.replace(/(^\s*)|(\s*$)/g,""); }
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
	
	/* Types Function */
	
	/* Object Functions */
	
	function replaceHTML(obj,text){
		while(el = obj.childNodes[0]){
			obj.removeChild(el);
		};
		obj.appendChild(document.createTextNode(text));
	}
	return this;

};