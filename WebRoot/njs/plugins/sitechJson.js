(function() {
    var window = this,
    undefined, sitechJson = window.sitechJson = function(c) {
        return new sitechJson.p.init(c);
    },
    reg = (new RegExp()).compile("(\\w+)\\s*\\[(\\d+?)\\]"),
    regAttr = (new RegExp()).compile("^(\\w+[^[](?:\\[\\d+\\])*)\\[(>?\\w+)=([^=]+)\\]"),
    regSplit = (new RegExp()).compile("[./]*([^./]+)(?=[./])*", "g");

    //sitechJson instance body
    sitechJson.p = sitechJson.prototype = {
        version: 3.0,
        author: "yuguozhou",
        init: function(c) {
            var core = c;
            var context = core;;
            this._getContext = function() {
                return context;
            }
            this._getCore = function() {
                return core;
            }
            this._setContext = function(c) {
                context = c;
            }
            this._setCore = function(c) {
                core = c;
            }
        },
        find: function(selector) {
            var tempArr = [];
            var core = this._getCore();
            var context = this._getContext();
            if (!core) return sitechJson(null);
            var path = selector.split(".");
            if (!path || path.length == 0 || core.childNodes.length == 0) {
                this._setContext(core);
                return sitechJson(null);
            }
            var i = 0;
            do {
                var regMatch = path[i].match(reg);
                path[i] = regMatch ? regMatch[1] : path[i];
                var arrayIndex = regMatch ? regMatch[2] : 0;
                var k = 0;
                if (!context.childNodes || !context.childNodes[k] || !context.childNodes[k].tagName) {
                    this._setContext(core);
                    return sitechJson(null);
                }

                do {

                    if (!arrayIndex && !arguments[1]) {
                        if (!arguments[2] && context.childNodes[k].tagName == path[i]) {
                            break;
                        } else if (arguments[2] && context.childNodes[k].tagName == path[i]) {
                            if (!path[i + 1]) {
                                context.childNodes[k].parent = context;
                                tempArr.push(context.childNodes[k]);
                            } else break;
                        }
                    } else if (arrayIndex) {
                        if (context.childNodes[k].tagName == path[i]) {
                            context.childNodes[k].parent = context;
                            tempArr.push(context.childNodes[k]);
                        }

                    } else if (!arrayIndex && arguments[1]) {
                        if (!arguments[2]) {
                            if (context.childNodes[k].tagName == path[i]) {
                                var innerJson = sitechJson(context.childNodes[k]);
                                if (arguments[1][2].charAt(0) == ">") {
                                    if (innerJson.deepFind("/" + arguments[1][2].slice(1)).value() == arguments[1][3]) {

                                        break;
                                    }
                                } else {
                                    if (innerJson.find(arguments[1][2]).value() == arguments[1][3]) {
                                        break;
                                    }
                                }

                            }
                        } else {
                            if (context.childNodes[k].tagName == path[i]) {
                                var innerJson = sitechJson(context.childNodes[k]);
                                if (arguments[1][2].charAt(0) == ">") { //遍历所有相同子节点?现在默认只有一个该类型的子节点，比如，product下面只有一个producttype节点，来定位子产品数组
                                    if (innerJson.deepFind("/" + arguments[1][2].slice(1)).value() == arguments[1][3]) {

                                        context.childNodes[k].parent = context;
                                        tempArr.push(context.childNodes[k]);
                                    }
                                } else {
                                    if (innerJson.find(arguments[1][2]).value() == arguments[1][3]) {
                                        context.childNodes[k].parent = context;
                                        tempArr.push(context.childNodes[k]);
                                    }
                                }

                            }
                        }
                    }

                } while ( typeof context . childNodes [++ k ] != "undefined") ;
                if (tempArr.length) {
                    if (arguments[2] && !path[i + 1]) {
                        this._setContext(core);
                        return tempArr;
                    } else {
                        if (typeof tempArr[arrayIndex] != "undefined") {
                            context = tempArr[arrayIndex];
                        } else {
                            this._setContext(core);
                            return sitechJson(null);
                        }
                    }
                    tempArr = [];
                } else if (typeof context.childNodes[k] == "undefined") {
                    this._setContext(core);
                    return sitechJson(null);
                } else {
                    context.childNodes[k].parent = context;
                    context = context.childNodes[k];

                }

            } while ( typeof path [++ i ] != "undefined");

            this._setContext(core);
            return sitechJson(context);

        },
        deepFind: function(selector) {

            function search(c) {
                if (!c.tagName || !c.childNodes) return null;
                var tempArr = [];
                for (var l = 0; l < c.childNodes.length; l++) {

                    if (c.childNodes[l].tagName == path[i]) {
                        if (!arrayIndex1 && !arguments[1]) {
                            c.childNodes[l].parent = c;
                            return c.childNodes[l];
                        } else {
                            if (!arguments[2]) {
                                c.childNodes[l].parent = c;
                                tempArr.push(c.childNodes[l]);
                            } else {
                                var deepState = false;
                                var innerPath = null;
                                if (arguments[2][2].charAt(0) == ">") {
                                    deepState = true;
                                    innerPath = ("/" + arguments[2][2].slice(1))
                                }
                                if (deepState) {
                                    if (sitechJson(c.childNodes[l]).deepFind(innerPath).value() == arguments[2][3]) {
                                        c.childNodes[l].parent = c;
                                        tempArr.push(c.childNodes[l]);
                                    }
                                } else {
                                    var attrLen = c.childNodes[l] ? c.childNodes[l].childNodes.length: 0;
                                    for (var nin = 0; nin < attrLen; nin++) {

                                        if ((c.childNodes[l].childNodes[nin].tagName == arguments[2][2]) && (c.childNodes[l].childNodes[nin].childNodes && c.childNodes[l].childNodes[nin].childNodes[0] && (c.childNodes[l].childNodes[nin].childNodes[0] == arguments[2][3]))) {
                                            c.childNodes[l].parent = c;
                                            tempArr.push(c.childNodes[l]);
                                            break;
                                        }
                                    }
                                }

                            }
                        }
                    } else {
                        var inner = search(c.childNodes[l], !!arguments[1], arguments[2]);
                        if (inner && ((inner.length != undefined) ? !!inner.length: true)) {
                            return inner;
                        }
                    }
                }
                if (arguments[1]) return tempArr;
                if (typeof tempArr[arrayIndex1] != "undefined") {
                    return tempArr[arrayIndex1];
                } else {
                    return null
                } //此处算法会产生丢失情况，待改进
                return null;

            }
            var core = this._getCore();
            var context = this._getContext();
            var path = selector.match(regSplit);
            var tempArr = [];
            if (!core) return sitechJson(null);
            if (!path || path.length == 0 || core.childNodes.length == 0) {
                this._setContext(core);
                return sitechJson(null);
            }
            var i = 0;
            do {

                if (path[i].charAt(0) == "." || path[i].charAt(0) != "/") { (path[i].charAt(0) == ".") && (path[i] = path[i].slice(1));
                    var tempAttrArray = path[i].match(regAttr);
                    if (tempAttrArray) {
                        if (!path[i + 1] && arguments[1]) {
                            return this.find(tempAttrArray[1], tempAttrArray, true)
                        }
                        context = this.find(tempAttrArray[1], tempAttrArray)._getContext();

                        if (context == null) {
                            this._setContext(core);
                            return sitechJson(null);
                        }
                        this._setContext(context);

                    } else {
                        if (!path[i + 1] && arguments[1]) {
                            return this.find(path[i], false, true)
                        }
                        context = this.find(path[i])._getContext();

                        if (context == null) {
                            this._setContext(core);
                            return sitechJson(null);
                        }
                        this._setContext(context);
                    }

                } else {

                    path[i] = path[i].slice(1);
                    var tempAttrArray1 = path[i].match(regAttr);
                    if (tempAttrArray1) {
                        path[i] = tempAttrArray1[1];
                        var regMatch1 = path[i].match(reg);
                        path[i] = regMatch1 ? regMatch1[1] : path[i];
                        var arrayIndex1 = regMatch1 ? regMatch1[2] : 0;
                        if (!path[i + 1] && arguments[1]) {
                            ////////////////////////////////////////////////////
                            return search(context, true, tempAttrArray1)
                            ///////////////////////////////////////////////////
                        }
                        var deepState = false;

                        if (tempAttrArray1[2].charAt(0) == ">") {
                            deepState = true;
                            tempAttrArray1[2] = ("/" + tempAttrArray1[2].slice(1))
                        }
                        if (arrayIndex1) {
                            context = search(context);
                            if (!context) {
                                this._setContext(core);
                                return sitechJson(null);
                            }

                            if (deepState) {
                                //此处先不作子节点存在数组列表的情况
                                if (sitechJson(context).deepFind(tempAttrArray1[2]).value() == tempAttrArray1[3]) {

                                    this._setContext(context);
                                }
                            } else {
                                var attrLen = context ? context.childNodes.length: 0;
                                for (var nin = 0; nin < attrLen; nin++) {

                                    if ((context.childNodes[nin].tagName == tempAttrArray1[2]) && (context.childNodes[nin].childNodes && context.childNodes[nin].childNodes[0] && (context.childNodes[nin].childNodes[0] == tempAttrArray1[3]))) {
                                        //attrState = true;
                                        this._setContext(context);
                                        break;
                                    }
                                }
                            }
                            break;

                        }
                        var contextArr = search(context, true);
                        if (contextArr) {

                            for (var o = 0; o < contextArr.length; o++) {
                                context = contextArr[o];
                                var attrState = false;
                                if (deepState) {
                                    //此处先不作子节点存在数组列表的情况
                                    if (sitechJson(context).deepFind(tempAttrArray1[2]).value() == tempAttrArray1[3]) {

                                        attrState = true;
                                        this._setContext(context);
                                    }
                                } else {
                                    var attrLen = context ? context.childNodes.length: 0;
                                    for (var nin = 0; nin < attrLen; nin++) {

                                        if ((context.childNodes[nin].tagName == tempAttrArray1[2]) && (context.childNodes[nin].childNodes && context.childNodes[nin].childNodes[0] && (context.childNodes[nin].childNodes[0] == tempAttrArray1[3]))) {
                                            attrState = true;
                                            this._setContext(context);
                                            break;
                                        }
                                    }
                                }
                                if (attrState) {
                                    break;
                                }
                            }
                            if (!attrState) {
                                this._setContext(core);
                                return sitechJson(null);
                            }
                        } else {
                            this._setContext(core);
                            return sitechJson(null);
                        }
                    } else {
                        var regMatch1 = path[i].match(reg);
                        path[i] = regMatch1 ? regMatch1[1] : path[i];
                        var arrayIndex1 = regMatch1 ? regMatch1[2] : 0;

                        context = search(context);
                        if (!context) {
                            this._setContext(core);
                            return sitechJson(null);
                        }
                        this._setContext(context);
                    }

                }

            } while ( typeof path [++ i ] != "undefined");
            this._setContext(core);
            return sitechJson(context);
        },
        findArr: function(selector) {
            return new sitechJsonArr(this.find(selector, false, true));
        },
        dfindArr: function(selector) {
            return new sitechJsonArr(this.deepFind(selector, true));
        },
        value: function() {
            if (!this._getContext()) return "没有选择到节点，无返回值";
            return (this._getContext().type) ? (typeof this._getContext().childNodes != "undefined" ? this._getContext().childNodes[0] : "") : "节点类型，无返回值";

        },
        isNull: function() {
            return ! this._getContext();
        },
        set: function(v) {
            var context = this._getContext();
            if (context.type) {
                if (typeof context.childNodes == "undefined") {
                    context.childNodes = [];
                }
                context.childNodes[0] = v;
                return true;
            };
            return false;

        },

        addTag: function(value, tagName) {
            var context = this._getContext();
            for (var i = 0; i < context.childNodes.length; i++) {
                if (context.childNodes[i].tagName == tagName) {
                    var tempObj = {
                        "childNodes": [value],
                        "tagName": tagName,
                        "type": context.childNodes[i].type
                    };
                    tempObj.parent = context;
                    context.childNodes.push(tempObj);
                    return true;
                }
            }
            return false;
        },
        addValue: function(v) {
            if (typeof v != "number" || typeof v != "string") return false;
            var context = this._getContext();
            if (context.type) context.childNodes = [v];

        },
        addNode: function(obj) {
            if(obj&&obj._getContext)
            {
                var objContext = obj._getContext();
                var parentContext = this._getContext();
                if (typeof objContext.tagName != "undefined") {
                    if (typeof parentContext.childNodes == "undefined") parentContext.childNodes = [];
                    objContext.parent = parentContext;
                    parentContext.childNodes.push(objContext);
                    return true;
                }
            }
            return false;

        },
        remove: function() {
            var context = this._getContext();
            if (!context.parent) {
                alert("此节点没有挂接到任何节点，不能删除节点本身");
                return false;
            };
            if (!arguments[0]) {
                if (this.isNull() || context.parent.childNodes.length < 1) return false;
                for (var i = 0; i < context.parent.childNodes.length; i++) {
                    if (context.parent.childNodes[i] == context) {
                        context.parent.childNodes.splice(i, 1);
                        this._setContext(null);
                        return true;
                    }
                }

            } else {
                context.childNodes = [];
                return true
            }
            return false;
        },
        returnTagName: function() {
            var context = this._getContext();
            if (context) {
                return context.tagName
            } else {
                return "空节点，无tagName";
            }

        },
        returnType: function() {
            var context = this._getContext();
            if (context) {
                return context.type
            } else {
                return "空节点，无type";
            }

        },
        returnChildSum: function() {
            var context = this._getContext();
            if (context) {
                return context.childNodes ? context.childNodes.length: 0
            } else {
                return "空节点，无childNode";
            }

        },
        removeIndex: function(tName, index) {
            var context = this._getContext();
            var tempArr = [];
            for (var i = 0; i < context.childNodes.length; i++) {

                if (context.childNodes[i].tagName == tName) {
                    tempArr.push(i);
                }
                if ((tempArr.length > 0) && (index <= (tempArr.length - 1))) {
                    context.childNodes.splice(index, 1);
                    return true;
                }
            }
            return false;
        },
        toJson: function() {
            var _c = this._getCore();
            return toJSON(_c);
        }

        ,
        clone: function() {

            var context = this._getContext();
            var newContext = clone(context);
            return sitechJson(newContext);
        }

    }
    sitechJson.p.init.prototype = sitechJson.p;
    sitechJson.generateNode = function(tagName, childNode, type) {
        var arr = [];
        arr.push(childNode);
        if (type) {
            return sitechJson({
                "tagName": tagName,
                "type": type,
                "childNodes": arr
            }

            );
        } else {
            return sitechJson({
                "tagName": tagName,
                "childNodes": arr
            }

            );
        }
    };
    //unexposed class for array
    var sitechJsonArr = function(jsonarr) {
        if (jsonarr && jsonarr.length) this.arr = jsonarr;
        else this.arr = [];
    }
    sitechJsonArr.prototype = {
        get: function(num) {
            if (num < this.arr.length) return sitechJson(this.arr[num]);
            else return sitechJson(null)
        },
        remove: function(num) {
            if (num < this.arr.length) {
                var ele = this.arr[num];
                this.arr.splice(num, 1);
                return sitechJson(ele).remove();
            } else {
                return false
            }
        },
        //toJson:function(){},
        length: function() {
            return this.arr.length
        },
        isNull: function() {
            return ! this.arr.length
        },
        removeAll: function() {
            var ele;
            while (ele = this.arr.pop()) {
                if (!sitechJson(ele).remove()) return false;
            };
            return true;
        }

    };
    function clone(myObj) {
        if (typeof(myObj) != 'object') return myObj;
        if (myObj == null) return myObj;
        var myNewObj = {}; (Object.prototype.toString.apply(myObj) === '[object Array]') && (myNewObj = []);
        for (var i in myObj) {
            if (i != "parent" && myObj.hasOwnProperty(i)) {
                myNewObj[i] = clone(myObj[i]);
                myNewObj[i].parent = myNewObj;
            } else continue
        }

        return myNewObj;

    }
    //thanks to yuweiqiang for the following code which I merge into my sitechJson framework,see details in http://blog.csdn.net/yuweiqiang/archive/2009/07/03/4320140.aspx
    function toJSON(object) {
        var type = typeof object;
        if ('object' == type) {
            if (Array == object.constructor) type = 'array';
            else if (RegExp == object.constructor) type = 'regexp';
            else type = 'object';
        }
        switch (type) {
        case 'undefined':
        case 'unknown':
            return;
            break;
        case 'function':
        case 'boolean':
        case 'regexp':
            return object.toString();
            break;
        case 'number':
            return isFinite(object) ? object.toString() : 'null';
            break;
        case 'string':
            return '"' + object.replace(/(\\|\")/g, "\\$1").replace(/\n|\r|\t/g,
            function() {
                var a = arguments[0];
                return (a == '\n') ? '\\n': (a == '\r') ? '\\r': (a == '\t') ? '\\t': ""
            }) + '"';
            break;
        case 'object':
            if (object === null) return 'null';
            var results = [];
            for (var property in object) {
                if (property == "parent") continue;
                var value = toJSON(object[property]);
                if (value !== undefined) results.push(toJSON(property) + ':' + value);
            }
            return '{' + results.join(',') + '}';
            break;
        case 'array':
            var results = [];
            for (var i = 0; i < object.length; i++) {
                var value = toJSON(object[i]);
                if (value !== undefined) results.push(value);
            }
            return '[' + results.join(',') + ']';
            break;
        }
    }
})();



function addInstanceNode(nodename,path,adjacentNode,container,tempIndex){
	var clazz=null;
	var fun=null;
	if(typeof tempIndex!="undefined")
	{
		
		if(typeof tempIndex=="object") tempIndex=tempIndex.toString();
		if(typeof (tempIndex-0)=="number")
		{
			clazz=instanceTemplate[nodename][tempIndex];
			fun=pushValue[nodename][tempIndex];
		}
		else 
			{
				alert("索引值必须为数值型！");
				return false;
			}
	}
	else
		{
			clazz=instanceTemplate[nodename];
			fun=pushValue[nodename];
		}
	if(clazz){
		var currentNode = clazz();
		fun(currentNode,container);
		if(path)
			adjacentNode.find(path).addNode(currentNode);
		else
			adjacentNode.addNode(currentNode);	
		return true;
	}else{
		alert("查找无此类!");
		return false;
	}
}

var instanceTemplate={
ATTRVALUEINFO:function(){
    return sitechJson(
        {
					"childNodes":[{"type":"string","tagName":"ATTR_NO"},{"type":"string","tagName":"ATTR_VALUE"}],"tagName":"ATTRVALUEINFO"
				}
	)
}
, 

BILL_POST_ADD:function(){
    return sitechJson(
        {
				"childNodes":[{"type":"int","tagName":"POST_ADDR_ID"}],"tagName":"BILL_POST_ADD"
	    	}
	)
}
,
BUSIINFO:function(){
    return sitechJson(
    	{
				"childNodes":[{"type":"long","tagName":"SERVICE_OFFER_ID"},{"type":"long","tagName":"SERIAL_NO"},{"type":"int","tagName":"CUST_ID_TYPE"},{"tagName":"ORDER_LINE_FEELIST"}],"tagName":"BUSIINFO"
	    }
	)
}
,
BUSI_MODEL:[
function(){
    return sitechJson(
    	{
			"childNodes":[{"type":"string","tagName":"USER_TYPE"},{"childNodes":[{"type":"string","tagName":"STOP_FLAG"},{"type":"string","tagName":"MASTER_SERV_ID"},{"type":"string","tagName":"SVC_ID"},{"type":"string","tagName":"BRAND_ID"},{"type":"int","tagName":"OWNER_TYPE"},{"type":"string","tagName":"USER_GRADE_CODE"},{"type":"int","tagName":"CARD_TYPE"},{"type":"string","tagName":"GROUP_FLAG"},{"type":"string","tagName":"PASSWD_TYPE"},{"type":"string","tagName":"USER_PASSWD"},{"type":"string","tagName":"CREDIT_CODE"},{"type":"double","tagName":"LIMIT_OWE"},{"type":"long","tagName":"CMD_RIGHT"},{"type":"string","tagName":"ASSURE_FLAG"},{"type":"string","tagName":"PHOTO_FLAG"},{"type":"string","tagName":"GROUP_ID"},{"type":"string","tagName":"SERVICE_GROUP"},{"type":"string","tagName":"BAK_FIELD"},{"type":"string","tagName":"OWED_FLAG"},{"type":"int","tagName":"BILL_TYPE"},{"type":"int","tagName":"BILLING_CYCLE_TYPE_ID"},{"type":"string","tagName":"VIP_CARD_NO"},{"type":"int","tagName":"VIP_CREATE_TYPE"},{"type":"string","tagName":"BILLING_MODE"},{"type":"int","tagName":"EXPIRE_TYPE"},{"type":"string","tagName":"EMP_GROUP"},{"type":"string","tagName":"EMP_ID"},{"type":"string","tagName":"QUERY_CDRFLAG"},{"type":"string","tagName":"LMT_ADJUST_TYPE"},{"type":"string","tagName":"BUY_NAME"},{"type":"string","tagName":"TERM_TEMPLET"},{"type":"string","tagName":"MACHINE_CODE"},{"type":"string","tagName":"INNET_MODE"},{"type":"string","tagName":"OPEN_TYPE"},{"type":"string","tagName":"INNET_SCHEME"},{"type":"string","tagName":"EXCLUSIVE_FLAG"},{"type":"string","tagName":"INNET_TYPE"}],"tagName":"USER_BASE"},{"childNodes":[{"type":"string","tagName":"USER_NAME"},{"type":"string","tagName":"USER_PASSWD"},{"type":"string","tagName":"LOGIN_NAME"},{"type":"string","tagName":"LOGIN_PASSWD"},{"type":"string","tagName":"CONTACT_NO"}],"tagName":"SUBSCRIBER_ATTR"},{"tagName":"USER_CONTACT_LIST"},{"childNodes":[{"type":"int","tagName":"ADDRESS_ID"},{"type":"string","tagName":"EXTERN_ADDRESS"},{"type":"int","tagName":"BUREAU_ID"},{"type":"int","tagName":"EXCHANGE_ID"},{"type":"int","tagName":"STAT_REGION_ID"}],"tagName":"USER_SERV_LOC"},{"childNodes":[{"type":"string","tagName":"IMSI_NO"},{"type":"string","tagName":"SIM_NO"}],"tagName":"USER_SIM"},{"tagName":"USER_RELA_LIST"},{"tagName":"SERV_ADD_NUM_LIST"},{"tagName":"USER_ADD_LIST"},{"childNodes":[{"type":"int","tagName":"STATUS_CODE"},{"type":"string","tagName":"ACCOUNT_TYPE"},{"type":"string","tagName":"PAY_CODE"},{"type":"string","tagName":"CONTRACT_NAME"},{"type":"string","tagName":"CONTRACT_PASSWD"},{"type":"string","tagName":"ACCOUNT_LIMIT"},{"tagName":"CON_ADD_LIST"},{"childNodes":[{"type":"string","tagName":"TRUST_TYPE"},{"type":"string","tagName":"BANK_CODE"},{"type":"string","tagName":"BANK_CUST"},{"type":"string","tagName":"POST_BANK_CODE"},{"type":"string","tagName":"ACCOUNT_NO"},{"type":"string","tagName":"CARD_NO"},{"type":"string","tagName":"PHONE_NO"},{"type":"string","tagName":"TRUST_CONTRACT"}],"tagName":"CON_TRUST"}],"tagName":"CON_MSG"},{"childNodes":[{"type":"int","tagName":"POSTNO_FLAG"},{"type":"int","tagName":"POST_TYPE"},{"type":"string","tagName":"POST_ZIP"},{"type":"string","tagName":"POST_ADDRESS"},{"type":"string","tagName":"POST_NAME"},{"type":"int","tagName":"POST_CYCLE"},{"type":"string","tagName":"POST_FLAG"},{"type":"string","tagName":"INFO_TYPE"},{"type":"string","tagName":"SEND_CONTENT"},{"type":"string","tagName":"SEND_CHN"},{"type":"string","tagName":"SEND_DAY"},{"type":"string","tagName":"EFF_DATE"},{"type":"string","tagName":"EXP_DATE"},{"type":"string","tagName":"IS_SEND_SALES"},{"tagName":"BILL_POST_ADD_LIST"}],"tagName":"BILL_POST"},{"childNodes":[{"tagName":"PRODUCT_LIST"}],"tagName":"PROD_INS"}],"tagName":"BUSI_MODEL"		    
			}
	)	
}
,
function(){
    return sitechJson(
    	{
				"childNodes":[{"childNodes":[{"type":"int","tagName":"TYPE_CODE"},{"type":"string","tagName":"CUST_NAME"},{"type":"string","tagName":"CUST_LEVEL"},{"type":"string","tagName":"ID_TYPE"},{"type":"string","tagName":"ID_ICCID"},{"type":"string","tagName":"ID_ADDRESS"},{"type":"string","tagName":"ID_VALIDDATE"},{"type":"int","tagName":"ADMIN_LEVEL"},{"type":"int","tagName":"STATUS_CODE"},{"type":"int","tagName":"ADDRESS_ID"},{"type":"string","tagName":"EXTERN_ADDRESS"},{"type":"string","tagName":"CUST_ADDRESS"},{"type":"string","tagName":"CUST_POST"},{"type":"string","tagName":"CREATE_LOGIN"},{"type":"string","tagName":"GROUP_ID"},{"type":"string","tagName":"SERVICE_GROUP"},{"type":"string","tagName":"OWNED_CHNL_ID"},{"type":"string","tagName":"EMP_ID"},{"type":"string","tagName":"EMP_GROUP"},{"type":"string","tagName":"CUST_CD"},{"type":"string","tagName":"DEFAULT_LANG"},{"type":"int","tagName":"CARD_TYPE"},{"type":"string","tagName":"VIP_FLAG"},{"type":"string","tagName":"VIP_CARD_NO"},{"type":"int","tagName":"VIP_CREATE_TYPE"},{"type":"string","tagName":"SIGN_FLAG"},{"type":"string","tagName":"TRUE_FLAG"}],"tagName":"CUST_BASE_INFO"},{"childNodes":[{"type":"int","tagName":"TYPE_CODE"},{"type":"string","tagName":"IDENTIFY_TYPE"},{"type":"int","tagName":"LEVEL_CODE"},{"type":"string","tagName":"CUST_PASSWD"},{"type":"string","tagName":"ID_ICCID"},{"type":"string","tagName":"ID_TYPE"},{"type":"BLOB","tagName":"ELEC_SIGN"},{"type":"BLOB","tagName":"ELEC_FINGERPRINT"}],"tagName":"CUST_IDENTIFY"},{"childNodes":[{"type":"string","tagName":"ID_TYPE"},{"type":"string","tagName":"ID_ICCID"},{"type":"string","tagName":"ID_NAME"},{"type":"string","tagName":"ID_SEX"},{"type":"string","tagName":"ID_BIRTHDAY"},{"type":"string","tagName":"ID_ADDRESS"},{"type":"int","tagName":"VALID_TERM"},{"type":"string","tagName":"SIGN_DATE"},{"type":"string","tagName":"SCAN_NOTE"},{"type":"string","tagName":"SCAN_FILE"},{"type":"long","tagName":"SCAN_FILE_SIZE"},{"type":"string","tagName":"SCAN_PICTURE"},{"type":"string","tagName":"CUST_ALIAS_NAME"}],"tagName":"CUST_CERTSCAN"},{"tagName":"CUST_ADD_LIST"},{"childNodes":[{"childNodes":[{"type":"string","tagName":"ID_TYPE"},{"type":"string","tagName":"ID_ICCID"},{"type":"string","tagName":"CONTACT_TYPE"},{"type":"string","tagName":"CONTACT_NAME"},{"type":"string","tagName":"CONTACT_PHONE"},{"type":"int","tagName":"ADDRESS_ID"},{"type":"string","tagName":"CONTACT_ADDRESS"},{"type":"string","tagName":"CONTACT_POST"},{"type":"string","tagName":"CONTACT_EMAIL"},{"type":"string","tagName":"CONTACT_MAILADDRESS"},{"type":"string","tagName":"CONTACT_FAX"},{"type":"string","tagName":"OFFICE_PHONE"},{"type":"string","tagName":"HOME_PHONE"},{"type":"string","tagName":"LIKE_CONTMODE"},{"type":"string","tagName":"LIKE_CONTTIME"},{"type":"string","tagName":"CONNECT_INTERVAL"},{"type":"string","tagName":"DISLIKE_CONTMODE"},{"type":"string","tagName":"DISLIKE_CONTTIME"},{"type":"string","tagName":"EVECTION"}],"tagName":"CUST_CONTACT"}],"tagName":"CUST_CONTACT_LIST"},{"childNodes":[{"type":"int","tagName":"SEX_CODE"},{"type":"int","tagName":"NATION"},{"type":"int","tagName":"NATION_ID"},{"type":"string","tagName":"POLITICAL_EXP"},{"type":"string","tagName":"WORK_CODE"},{"type":"int","tagName":"PROFESSION_ID"},{"type":"string","tagName":"BIRTHDAY"},{"type":"string","tagName":"LUNAR_TYPE"},{"type":"string","tagName":"CUST_LOVE"},{"type":"string","tagName":"CUST_HABIT"},{"type":"string","tagName":"HOME_PHONE"},{"type":"string","tagName":"MARRIED"},{"type":"string","tagName":"IS_HAVING_KIDS"},{"type":"string","tagName":"RESIDE_ADDR"},{"type":"string","tagName":"HOME_POST"},{"type":"string","tagName":"FAITH"},{"type":"string","tagName":"INCOME"},{"type":"string","tagName":"WEB_NAME"},{"childNodes":[{"type":"string","tagName":"CONSUME_HABIT"},{"type":"string","tagName":"CONSUME_CODE"}],"tagName":"CUST_CONSUME"},{"childNodes":[{"type":"string","tagName":"WORK_CLASS"},{"type":"string","tagName":"UNIT_NAME"},{"type":"string","tagName":"UNIT_ADDR"},{"type":"string","tagName":"UNIT_POST"},{"type":"string","tagName":"UNIT_TELE"},{"type":"string","tagName":"UNIT_DEPT"},{"type":"string","tagName":"UNIT_DUTY"},{"type":"string","tagName":"CONTRACT_NO"},{"type":"string","tagName":"REGISTER_DATE"}],"tagName":"CUST_WORK"},{"childNodes":[{"type":"string","tagName":"SCHOOL_NAME"},{"type":"string","tagName":"SPECIALITY"},{"type":"string","tagName":"ENTRY_YEAR"},{"type":"string","tagName":"GRADE"},{"type":"string","tagName":"CONTACT_PHONE"},{"type":"string","tagName":"SOCIETY_RELATION"}],"tagName":"CUST_EDU"}],"tagName":"PERSONAL_CUST"},{"childNodes":[{"type":"long","tagName":"MASTER_CUST_ID"}],"tagName":"HOME_CUST"},{"childNodes":[{"type":"long","tagName":"MASTER_CUST_ID"}],"tagName":"PARTY_CUST"}],"tagName":"BUSI_MODEL"
	    }
	)	
}
]
,
CON_ADD:function(){
     return sitechJson(
        {
					"childNodes":[{"type":"string","tagName":"FIELD_CODE"},{"type":"string","tagName":"BUSI_TYPE"},{"type":"string","tagName":"FIELD_VALUE"},{"type":"string","tagName":"OTHER_VALUE"}],"tagName":"CON_ADD"
	    	}
	)
}
,
GROUP_INFO:function(){
     return sitechJson(
          {
						"childNodes":[{"type":"string","tagName":"OPERATE_TYPE"},{"type":"long","tagName":"GROUP_ID"},{"type":"string","tagName":"GROUP_TYPE"},{"type":"string","tagName":"GROUP_CODE"},{"type":"string","tagName":"GROUP_DESC"},{"type":"string","tagName":"LOCK_FLAG"},{"tagName":"GROUPATTR_LIST"},{"tagName":"GROUPMBRINFO_LIST"}],"tagName":"GROUP_INFO"
	        }
	)
}
,
GROUPATTR:function(){
     return sitechJson(
        {
				"childNodes":[{"type":"string","tagName":"OPERATE_TYPE"},{"type":"string","tagName":"ATTR_ID"},{"type":"string","tagName":"GRP_NO"},{"type":"string","tagName":"EFF_DATE"},{"type":"string","tagName":"EXP_DATE"},{"tagName":"ATTRVALUEINFO_LIST"}],"tagName":"GROUPATTR"
	      }
	)
}
,
GROUPMBRATTR:function(){
     return sitechJson(
        {
				"childNodes":[{"type":"string","tagName":"OPERATE_TYPE"},{"type":"string","tagName":"ATTR_ID"},{"type":"string","tagName":"GRP_NO"},{"type":"string","tagName":"EFF_DATE"},{"type":"string","tagName":"EXP_DATE"},{"tagName":"ATTRVALUEINFO_LIST"}],"tagName":"GROUPMBRATTR"
	      }
	)
}
,
GROUPMBRINFO:function(){
     return sitechJson(
        {
				"childNodes":[{"type":"string","tagName":"OPERATE_TYPE"},{"type":"long","tagName":"MEMBER_ID"},{"type":"string","tagName":"OBJECT_TYPE"},{"type":"string","tagName":"OBJECT_ID"},{"type":"long","tagName":"MBR_ROLE"},{"type":"string","tagName":"SHORT_NO"},{"type":"string","tagName":"LOCK_FLAG"},{"type":"string","tagName":"MBR_DESC"},{"type":"string","tagName":"EFF_DATE"},{"type":"string","tagName":"EXP_DATE"},{"tagName":"GROUPMBRATTR_LIST"}],"tagName":"GROUPMBRINFO"
	      }
	)
}
,
PRODATTR:function(){
        return sitechJson(
        {
				"childNodes":[{"type":"string","tagName":"OPERATE_TYPE"},{"type":"string","tagName":"ATTR_ID"},{"type":"string","tagName":"GRP_NO"},{"type":"string","tagName":"EFF_DATE"},{"type":"string","tagName":"EXP_DATE"},{"tagName":"ATTRVALUEINFO_LIST"}],"tagName":"PRODATTR"
	      }
	)
}
,
PRODPRCATTR:function(){
         return sitechJson(
        {
				"childNodes":[{"type":"string","tagName":"OPERATE_TYPE"},{"type":"string","tagName":"ATTR_ID"},{"type":"string","tagName":"GRP_NO"},{"type":"string","tagName":"EFF_DATE"},{"type":"string","tagName":"EXP_DATE"},{"tagName":"ATTRVALUEINFO_LIST"}],"tagName":"PRODPRCATTR"
	      }
	)
}
,
PRODUCT:function(){
         return sitechJson(
        {
				"childNodes":[{"type":"string","tagName":"OPERATE_TYPE"},{"type":"string","tagName":"PROD_PRCID"},{"type":"string","tagName":"REL_PROD_PRCID"},{"type":"long","tagName":"PRODPRCINS_ID"},{"type":"long","tagName":"RELPRCINS_ID"},{"type":"string","tagName":"EFF_DATE"},{"type":"string","tagName":"EXP_DATE"},{"type":"string","tagName":"DEVELOP_NO"},{"tagName":"PRODPRCATTR_LIST"},{"tagName":"PRODATTR_LIST"},{"tagName":"SVCATTR_LIST"}],"tagName":"PRODUCT"
	      }
	)
}
,
ROOT:function(){
         return sitechJson(
        {
				"childNodes":[{"childNodes":[{"type":"int","tagName":"BATCH_TYPE"},{"type":"long","tagName":"TEMPLATE_ID"}],"tagName":"MSG_TYPE"},{"childNodes":[{"childNodes":[{"type":"int","tagName":"REGION_ID"},{"type":"string","tagName":"CHANNEL_TYPE"},{"type":"string","tagName":"LOGIN_NO"},{"type":"string","tagName":"LOGIN_PWD"},{"type":"string","tagName":"IP_ADDRESS"},{"type":"string","tagName":"GROUP_ID"},{"type":"long","tagName":"CONTACT_ID"},{"type":"string","tagName":"OP_CODE"},{"type":"string","tagName":"OP_NOTE"},{"type":"string","tagName":"SYS_NOTE"},{"type":"long","tagName":"CUST_ID"},{"type":"long","tagName":"ID_NO"},{"type":"string","tagName":"SERVICE_NO"},{"type":"long","tagName":"CONTRACT_NO"}],"tagName":"OPR_INFO"},{"childNodes":[{"childNodes":[{"type":"long","tagName":"BUSI_TYPE_ID"}],"tagName":"ORDER_INFO"}],"tagName":"BUSIINFO_LIST"}],"tagName":"REQUEST_INFO"}],"tagName":"ROOT"
	      }
	)
}
,
SERV_ADD_NUM:function(){
         return sitechJson(
        {
				"childNodes":[{"type":"string","tagName":"SVC_ID"},{"type":"string","tagName":"ADD_SERVICE_NO"}],"tagName":"SERV_ADD_NUM"
	      }
	)
}
,
SVCATTR:function(){
         return sitechJson(
        {
				"childNodes":[{"type":"string","tagName":"OPERATE_TYPE"},{"type":"string","tagName":"SVC_ID"},{"type":"string","tagName":"ATTR_ID"},{"type":"string","tagName":"GRP_NO"},{"type":"string","tagName":"EFF_DATE"},{"type":"string","tagName":"EXP_DATE"},{"tagName":"ATTRVALUEINFO_LIST"}],"tagName":"SVCATTR"
	      }
	)
}
,
TEAM_INFO:function(){
         return sitechJson(
        {
				"childNodes":[{"type":"string","tagName":"OPERATE_TYPE"},{"type":"long","tagName":"TEAM_ID"},{"type":"string","tagName":"TEAM_TYPE"},{"type":"string","tagName":"TEAM_NAME"},{"tagName":"TEAMMBRINFO_LIST"}],"tagName":"TEAM_INFO"
	      }
	)
}
,
TEAMMBRINFO:function(){
         return sitechJson(
        {
				"childNodes":[{"type":"string","tagName":"OPERATE_TYPE"},{"type":"string","tagName":"OBJECT_ID"},{"type":"string","tagName":"EFF_DATE"},{"type":"string","tagName":"EXP_DATE"}],"tagName":"TEAMMBRINFO"
	      }
	)
}
,
USER_ADD:function(){
         return sitechJson(
        {
				"childNodes":[{"type":"string","tagName":"FIELD_CODE"},{"type":"string","tagName":"BUSI_TYPE"},{"type":"string","tagName":"FIELD_VALUE"},{"type":"string","tagName":"OTHER_VALUE"}],"tagName":"USER_ADD"
	      }
	)
}
,
USER_RELA:function(){
         return sitechJson(
        {
				"childNodes":[{"type":"long","tagName":"SLAVE_ID"},{"type":"string","tagName":"RELATION_CODE"},{"type":"string","tagName":"SLAVE_PHONE"},{"type":"int","tagName":"REL_VALUE"}],"tagName":"USER_RELA"
	      }
	)
}
}


var pushValue = {
ATTRVALUEINFO:function(){

}
, 

BILL_POST_ADD:function(){

}
,
BUSIINFO:function(){

}
,
BUSI_MODEL:[
function(){
	
}
,
function(){
	
}
]
,
CON_ADD:function(){

}
,
GROUP_INFO:function(){

}
,
GROUPATTR:function(){

}
,
GROUPMBRATTR:function(){

}
,
GROUPMBRINFO:function(){

}
,
PRODATTR:function(){

}
,
PRODPRCATTR:function(){

}
,
PRODUCT:function(){

}
,
ROOT:function(){

}
,
SERV_ADD_NUM:function(){

}
,
SVCATTR:function(){

}
,
TEAM_INFO:function(){

}
,
TEAMMBRINFO:function(){

}
,
USER_ADD:function(){

}
,
USER_RELA:function(){

}
}