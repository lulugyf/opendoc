var uif={}||window;

uif.mxResources = {
    resources: new Array(),
    add: function(basename, lan) {
        lan = (lan != null) ? lan: document.all?navigator.userLanguage:navigator.language;
        var dash = lan.indexOf('-');
	    if (dash > 0) {
	        lan = lan.substring(0, dash);
	    }
        if (lan != 'none') {
            try {
                var req = uif.mxResources.load(basename + '.properties');
                if (req.isReady()) {
                    uif.mxResources.parse(req.getText());
                }
            } catch(e) {}
            try {
                var req = uif.mxResources.load(basename + '_' + lan + '.properties');
                if (req.isReady()) {
                    uif.mxResources.parse(req.getText());
                }
            } catch(e) {}
        }
    },
    parse: function(text) {
        var lines = text.split('\n');
        for (var i = 0; i < lines.length; i++) {
            var index = lines[i].indexOf('=');
            if (index > 0) {
                var key = lines[i].substring(0, index);
                var idx = lines[i].length;
                if (lines[i].charCodeAt(idx - 1) == 13) {
                    idx--;
                }
                var value = lines[i].substring(index + 1, idx);
                uif.mxResources.resources[key] = unescape(value);
            }
        }
    },
    get: function(key, defaultValue) {
        var value = uif.mxResources.resources[key];
        if (value == null) {
            value = defaultValue;
        }
        return value;
    },
    load: function(url) {
        var req = new mxXmlRequest(url, null, 'GET', false);
        req.send();
        return req;
    },
    bind: function(scope, funct) {
        return function() {
            return funct.apply(scope, arguments);
        };
    }
};

function mxXmlRequest(url, params, method, async, username, password) {
    this.url = url;
    this.params = params;
    this.method = method || 'POST';
    this.async = (async != null) ? async: true;
    this.username = username;
    this.password = password;
};
mxXmlRequest.prototype.url = null;
mxXmlRequest.prototype.params = null;
mxXmlRequest.prototype.method = null;
mxXmlRequest.prototype.async = null;
mxXmlRequest.prototype.username = null;
mxXmlRequest.prototype.password = null;
mxXmlRequest.prototype.request = null;
mxXmlRequest.prototype.send = function(onload, onerror) {
    this.request = this.create();
    if (this.request != null) {
        this.request.onreadystatechange = uif.mxResources.bind(this,
        function() {
            if (this.isReady()) {
                if (onload != null) {
                    onload(this);
                }
            }
        });
        this.request.open(this.method, this.url, this.async, this.username, this.password);
        this.setRequestHeaders(this.request, this.params);
        this.request.send(this.params);
    }
};
mxXmlRequest.prototype.create = function() {
    if (window.XMLHttpRequest) {
        return function() {
            return new XMLHttpRequest();
        };
    } else if (typeof(ActiveXObject) != "undefined") {
        return function() {
            return new ActiveXObject("Microsoft.XMLHTTP");
        };
    }
} ();
mxXmlRequest.prototype.isReady = function() {
    return this.request.readyState == 4;
};
mxXmlRequest.prototype.getText = function() {
    return this.request.responseText;
};
mxXmlRequest.prototype.setRequestHeaders = function(request, params) {
    if (params != null) {
        request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    }
};


/**扩展document.getElementById(id)多浏览器兼容性； id:要查找的对象id**/
uif.getElementById= function(id){ 
    if (typeof(id) != "string" || id == "") return null;
    if (document.getElementById) return document.getElementById(id);
    if (document.all) return document.all(id);
    try {return eval(id);} catch(e){ return null;}
};
/**浏览器版本检测**/
uif.browserCheck=function(){
	var ua = window.navigator.userAgent.toLowerCase();
	if(ua.indexOf("msie")>-1)uif.navigator = "msie";
	else if(ua.indexOf("firefox")>-1)uif.navigator = "firefox";
	else if(ua.indexOf("safari")>-1)uif.navigator = "Safari";
}
/**判断页面加载状态；url:页面地址**/
uif.pageLoadStatus= function(url){ 
    var XMLHTTP;
    if (window.XMLHttpRequest) { //ie6版本及以下不支持
        XMLHTTP = new XMLHttpRequest();
    } else if (typeof(ActiveXObject) != "undefined") { 
        XMLHTTP = new ActiveXObject("Microsoft.XMLHTTP");
    }
	XMLHTTP.open("HEAD",url,false);
	XMLHTTP.send();
	return XMLHTTP.status;
};
/**在线帮助**/
uif.help= { 
    prefix: window.document.location.href.substring(0, window.document.location.href.indexOf('/npage/')+1)+'npage/help/',
    suffix: '.html',
    defaultPage: window.document.location.href.substring(0, window.document.location.href.indexOf('/npage/')+1)+'npage/help/help.html',
    callHelp: function(o){
        if(o && uif.pageLoadStatus(this.prefix+o+this.suffix)==200){
            window.open(this.prefix+o+this.suffix);
        }else if(uif.pageLoadStatus(this.defaultPage)==200){
            window.open(this.defaultPage);
        }
    }
};
/**面包屑导航**/
uif.pageNav= {
    navArr: [],
    defaultPrefix: '\u5f53\u524d\u4f4d\u7f6e: ',
    pageNavShowId: 'breadcrumb',
    navSplit: ' > ',
    showPageNav: function(){
        var navLen = this.navArr.length;
        var navInner = '';
        if(uif.getElementById(this.pageNavShowId) && navLen>0){
    		for(var i=0; i<navLen; i++){
    		    navInner = navInner + this.navArr[i] + this.navSplit;
    		}
    		uif.getElementById(this.pageNavShowId).innerHTML = this.defaultPrefix + navInner.substring(0,navInner.length-4);
		}
    }
};
/**站点地图**/
uif.sitemap={
    N: {},
    node: {},
    mapid: "sitemap",
    names: "",
    _d: "\x0f",
	divider: "_",
	index: 0,
	totalNode: 0,
	writeHTML: function(){
		this.node["0"]= {
			id: "0",
			sourceIndex: "0"
		};
		this.dataFormat();
		this.loadAll("0");
	  },
	dataFormat: function(){
		var a = new Array();
		for (var id in this.N) a[a.length] = id;
		this.names = a.join(this._d + this._d);
		this.totalNode = a.length;
		a = null;
	},
	loadAll: function(id){
		var node = this.node[id];
		var d = this.divider;
		var _d = this._d;
		var sid = node.sourceIndex.substr(node.sourceIndex.indexOf(d) + d.length);
		
		var reg = new RegExp("(^|"+_d+")"+ sid +d+"[^"+_d+d +"]+("+_d+"|$)", "g");
		var cns = this.names.match(reg);
		
		if (cns){
			this.names = this.names.replace(reg,''); //删除匹配字符串;
			reg = new RegExp(_d, "g"); 
			for(var i=0; i<cns.length; i++){
				this.nodeToHTML(this.nodeInit(cns[i].replace(reg, ""), id));
				this.loadAll(this.index);
			} 
		}
	},
	nodeInit: function(sourceIndex, parentId){
		this.index++;
		var source= this.N[sourceIndex];
		var d = this.divider;
		var _d = this._d;
		var sid   = sourceIndex.substr(sourceIndex.indexOf(d) + d.length);
		var reg = new RegExp("(^|"+_d+")"+ sid +d+"[^"+_d+d +"]+("+_d+"|$)");
		var cns = reg.test(this.names);
					  
		this.node[this.index] = {
		   id: this.index,
		   parentId: parentId,
		   sourceIndex: sourceIndex
		};
		
		return this.node[this.index];
	},
	nodeToHTML: function(node){
		var cdiv=document.createElement("div");
		cdiv.id=node.sourceIndex;
		var child_div=document.createElement("div");
		child_div.id=node.sourceIndex+'_child';
		if(document.all){
			child_div.style.borderLeft='1px solid #ccc';
			child_div.style.marginLeft='20px';
		}else{
			child_div.setAttribute('style','margin-left:20px;border-left:1px solid #ccc');
		}
		
		var innerH = '<a href="#" onclick="'+this.getAttribute(this.N[node.sourceIndex],"C")+'">'+this.getAttribute(this.N[node.sourceIndex],'T')+'</a></DIV>';
		
		if(this.getElementById(this.node[node.parentId].sourceIndex+'_child')){
			cdiv.innerHTML = '<span style="color:#ccc">—</span>'+innerH;
			this.getElementById(this.node[node.parentId].sourceIndex+'_child').appendChild(cdiv);
			this.getElementById(this.node[node.parentId].sourceIndex+'_child').appendChild(child_div);
		}else{
			cdiv.innerHTML = innerH;
			this.getElementById(this.mapid).appendChild(cdiv);
			this.getElementById(this.mapid).appendChild(child_div);
		}
	},
	getAttribute: function(source, name){
		var reg = new RegExp("(^|;|\\s)"+ name +"\\s*:\\s*([^;]*)(\\s|;|$)", "i");
		if (reg.test(source)) 
		    return RegExp.$2.replace(/[\x0f]/g, ";"); 
		return "";
	},
	getElementById: function(id){
	    if (typeof(id) != "string" || id == "") return null;
	    if (document.getElementById) return document.getElementById(id);
	    if (document.all) return document.all(id);
	    try {return eval(id);} catch(e){ return null;}
	}
};

uif.showFirstMenu = function(arr,obj){
	var menus;
	try{
		var j = "(" + arr +")"; 
		menus = eval(j);
	}catch(e){
		menus = null;
	}
	var oli = document.getElementById(obj);
	var i = 0;
	for(var p in menus){
		var li = document.createElement("li");
		li.setAttribute("opcode",p);
		li.setAttribute("opname",menus[p]);
		if(i==0)li.className = "on";
		
		var _a = document.createElement("a");
		_a.setAttribute("href","#none");
		_a.className = "text";
		_a.innerText = menus[p];
		
		li.appendChild(_a);
		oli.appendChild(li);
		
		i++;
	}
};

/*模块关联*/
uif.relModule = {
	relArr: [],
	relId:'oRelation',
	showRelModule:function(){
		var relLen = this.relArr.length;
		var relInner = "";
		if(document.getElementById(this.relId) && relLen>0 ){
			for(var i=0;i<relLen;i++){
				relInner += this.relArr[i]+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
			}
			document.getElementById(this.relId).innerHTML = relInner;
		}
	}

};

/**图表
 * swfFilePath:swf文件地址；dataXml:xml格式的字符串；showDiv:页面上显示图片的元素id；width:图表显示宽度；height:图表显示高度
 **/
uif.generateChartsByXml= function(swfFilePath,dataXml,showDiv,width,height){
    var chart = new FusionCharts(swfFilePath, "ChartIdXml", width, height);
	chart.setDataXML(dataXml); //读xml数据
    chart.render(showDiv);  //图形展示区域组件id值
};
uif.generateChartsByUrl= function(swfFilePath,dataUrl,showDiv,width,height){
    var chart = new FusionCharts(swfFilePath, "ChartIdUrl", width, height);
	chart.setDataURL(dataUrl);//读xml数据文件地址	   
	chart.render(showDiv);
};




slideDialog=function(msgContent,_timeout){uif.slideDialog(msgContent,_timeout)};
checksubmit=function(frm){return (uif.validate.checksubmit(frm))};
validateElement=function(elem){return uif.validate.validateElement(elem)};
validateField=function(elem){uif.validate.validateField(elem)};
actb=function(objs,objh,ca){uif.actb(objs,objh,ca)};
callHelp=function(o){uif.help.callHelp(o)};








