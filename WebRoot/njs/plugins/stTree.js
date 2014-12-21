/****************************************************
	author：yangrq
	N[结点id]="结点Id，结点名称(nodeName)，父结点(paretNode)，传入函数";
	
*/
function stTree(Tname,rootTree)
{
	this.name=Tname;
	this.root=rootTree;
	this.N={};
	this.totalNode=0;
	this.imgSrc="";
	this.g=function(objectId)
	{
		if (document.getElementById && document.getElementById(objectId))
		{
			return document.getElementById(objectId);
		}
		else if (document.all && document.all[objectId])
		{
			return document.all[objectId];
		}
		else if (document.layers && document.layers[objectId])
		{
			return document.layers[objectId];
		}
		else 
		{
			return false;
		}
	};
	this.writeTree=function()
	{
		this.dataFormat();
		//dataFormat();
	};
}
stTree.prototype.version = '1.0';
stTree.fn = stTree.prototype;
stTree.fn.dataFormat = function()
{
  var aT=new Array();
  for(var nodeId in this.N)
  { 
  	var node=this.N[nodeId];
 		aT[aT.length]=nodeId;
  	if(node)
  	{
	  	var nodeAttr=node.split(";")
	  	this.aN(nodeAttr[0],nodeAttr[1],nodeAttr[2],nodeAttr[3]);
	  	this.N[nodeId]=null;
  	}
	}
	this.totalNode=aT.length;
  aT = null;
};
stTree.fn.expandClose=function(imgCur,ulCur)
{
	alert(imgCur);
	alert(ulCur);
	/*	*/
	}
stTree.fn.expandNode=function(itNode)
{alert("expand");
	if(this.totalNode>500)
	{
		alert("节点太多，打开很慢！")
		return false;
	}
	var exUl=null;
	if(typeof(itNode)!="undefined")
	{
		var exNode=document.getElementById(itNode);
		exNode.parentNode.onfocus;
	}
	exUl=this.g(this.root).getElementsByTagName("ul");
	for(var i=0;i<exUl.length;i++)
	{
		if(exUl[i]&&exUl[i].style.display=="none")
		{
			var exLen=exUl[i].id.length;
			exUl[i].style.display="block";
			var exNodeId=exUl[i].id.substring(3,exLen);
			var imgId=this.g("img_"+exNodeId);
			if(imgId&&imgId.tagName=="IMG")
			{
				imgId.src=this.imgSrc+"/opened.gif";
			}
		}
	}
};
stTree.fn.aN=function(nodeId,nodeName,nodeparId,ulrClick)
{
	if(nodeparId=="000"&&(!this.g(this.root+"_Ul"))) this.atRootIsEmpty();
	var curNode="ul_"+nodeparId;
	/*if(!this.g(curNode)&&nodeparId!="000") 
	{
		alert("出错，没有挂子节点的父节点");
		return false;
	}*/
	if(nodeparId=="000") 
	{
		this.newNode(this.root+"_Ul",nodeId,nodeName,ulrClick);
	}
	else
	{
		var treePraUl="ul_"+nodeparId;
		if(this.g(treePraUl))
		{
			this.newNode(treePraUl,nodeId,nodeName,ulrClick);
		}
		else
		{
				var praLi="li_"+nodeparId;
				var praImg="img_"+nodeparId;
				if(!this.g(praLi)){return false};
				var treeUl=document.createElement("ul");
				treeUl.id="ul_"+nodeparId;
				this.g(praLi).appendChild(treeUl);
				this.g(praImg).src=this.imgSrc+"/closed.gif";
				treeUl.style.display="none";
				treeUl.style.cursor="pointer";
				this.newNode(treeUl.id,nodeId,nodeName,ulrClick);
		}
	}
}
stTree.fn.newNode=function(rootId,nodeId,nodeName,ulrClick)
{
		var imgUlr=this.imgSrc;
		var treeLi=document.createElement("li");
		treeLi.id="li_"+nodeId;
		var treeImg=document.createElement("img");
		treeImg.id="img_"+nodeId;
		var treeA=document.createElement("a");
		treeA.id="a_"+nodeId;
		treeA.href="#this";
		treeA.innerHTML=nodeName;
		treeA.onclick=function()
		{
			eval(ulrClick);
		};
		treeLiPar=this.g(rootId);
		treeLiPar.appendChild(treeLi);
		treeLi.appendChild(treeImg);
		treeLi.appendChild(treeA);
		var imgUlr=this.imgSrc;
		treeImg.onclick=function()
			{
				var e = arguments[0] || window.event;
 				var imgNow = e.srcElement || e.target;
				var ulId="ul_"+imgNow.id.substring("4",imgNow.id.length);
				var ul_id=document.getElementById(ulId);
				if(!ul_id) return false;
				if(ul_id&&ul_id.style.display=="none")
					{
						ul_id.style.display="block";
						imgNow.src=imgUlr+"/opened.gif";
					}
				else
					{
						ul_id.style.display="none";
						imgNow.src=imgUlr+"/closed.gif";
					}
			}
		exClose=null;
		treeImg.src=this.imgSrc+"/child.gif";
		treeLi=null;
		treeImg=null;
		treeSpan=null;
		treeCh=null;
}
stTree.fn.atRootIsEmpty=function()
{
	var treeRoot=document.getElementById(this.root);
	var treeUl=document.createElement("ul");
	treeRoot.appendChild(treeUl);
	treeUl.id=this.root+"_Ul";
}

/***********


***********/
function stcchTree(Tname,rootTree)
{
	this.name=Tname;
	this.root=rootTree;
	this.N={};
	this.totalNode=0;
	this.imgSrc="";
	this.g=function(objectId)
	{
		if (document.getElementById && document.getElementById(objectId))
		{
			return document.getElementById(objectId);
		}
		else if (document.all && document.all[objectId])
		{
			return document.all[objectId];
		}
		else if (document.layers && document.layers[objectId])
		{
			return document.layers[objectId];
		}
		else 
		{
			return false;
		}
	};
	this.writeTree=function()
	{
		this.dataFormat();
			//dataFormat();
	};
}
stcchTree.prototype.version = '1.0';
stcchTree.fn = stcchTree.prototype;
stcchTree.fn.dataFormat = function()
{
  var aT=new Array();
  for(var nodeId in this.N)
  { 
  	var node=this.N[nodeId];
 		aT[aT.length]=nodeId;
  	if(node)
  	{
	  	var nodeAttr=node.split(";")
	  	this.aN(nodeAttr[0],nodeAttr[1],nodeAttr[2],nodeAttr[3]);
	  	this.N[nodeId]=null;
  	}
	}
	this.totalNode=aT.length;
  aT = null;
};
stcchTree.fn.expandNode=function(itNode)
{alert("expand");
	if(this.totalNode>200)
	{
		alert("节点太多，打开很慢！")
		return false;
	}
	var exUl=null;
	if(itNode)
	{
		var exNode=this.g(itNode)
		exUl=exNode.getElementsByTagName("ul");
	}
	else
	{
		exUl=this.g(this.root).getElementsByTagName("ul");
	}
	for(var i=0;i<exUl.length;i++)
	{
		if(exUl[i]&&exUl[i].style.display=="none")
		{
			var exLen=exUl[i].id.length;
			exUl[i].style.display="block";
			var exNodeId=exUl[i].id.substring(3,exLen);
			var imgId=this.g("img_"+exNodeId);
			if(imgId&&imgId.tagName=="IMG")
			{
				imgId.src=this.imgSrc+"/opened.gif";
			}
		}
	}
};
stcchTree.fn.aN=function(nodeId,nodeName,nodeparId,isHasChild)
{
	if(nodeparId=="000"&&(!this.g(this.root+"_Ul"))) this.atRootIsEmpty();
	var curNode="ul_"+nodeparId;
	if(!this.g(curNode)&&nodeparId!="000") 
	{
		alert("出错，没有挂子节点的父节点");
		return false;
	}
	if(nodeparId=="000") 
	{
		this.newNode(this.root+"_Ul",nodeId,nodeName,isHasChild);
	}
	else
	{
		treePraUl="ul_"+nodeparId
		this.newNode(treePraUl,nodeId,nodeName,isHasChild);
	}
}
stcchTree.fn.newNode=function(rootId,nodeId,nodeName,isHasChild)
{
		var imgUlr=this.imgSrc;
		var treeLi=document.createElement("li");
		treeLi.id="li_"+nodeId;
		var treeImg=document.createElement("img");
		treeImg.id="img_"+nodeId;
		var treeSpan=document.createElement("span");
		treeSpan.id="span_"+nodeId;
		var treeCh=document.createElement("input");
		treeCh.type="checkBox"
		treeCh.id="ch_"+nodeId;
		treeCh.onclick=function()
		{
			//alert("aaaaaaa");
			//funCheck(this.id);
			funCheck(this.id,nodeName);
		}
		treeSpan.innerHTML=nodeName;
		treeLiPar=this.g(rootId);
		treeLiPar.appendChild(treeLi);
		treeLi.appendChild(treeImg);
		treeLi.appendChild(treeCh);
		treeLi.appendChild(treeSpan);
		if(isHasChild=="1")
		{
			//treeLi.removeChild(treeCh);
			var treeUl=document.createElement("ul");
			treeUl.id="ul_"+nodeId;
			treeLi.appendChild(treeUl);
			treeImg.src=this.imgSrc+"/closed.gif";
			treeUl.style.display="none";
			treeUl.style.cursor="pointer";
			treeImg.onclick=function()
			{
				if(treeUl.style.display=="none")
				{
					treeUl.style.display="block";
					this.src=imgUlr+"/opened.gif";
				}
				else
				{
					treeUl.style.display="none";
					this.src=imgUlr+"/closed.gif";
				}
			}
		}
		else
		{
			treeImg.src=this.imgSrc+"/child.gif";
		}
		treeLi=null;
		treeImg=null;
		treeSpan=null;
		treeCh=null;
}
stcchTree.fn.atRootIsEmpty=function()
{
	var treeRoot=document.getElementById(this.root);
	var treeUl=document.createElement("ul");
	treeRoot.appendChild(treeUl);
	treeUl.id=this.root+"_Ul";
}
/***********


***********/
function stdcchTree(Tname,rootTree)
{
	this.name=Tname;
	this.root=rootTree;
	this.N={};
	this.totalNode=0;
	this.imgSrc="";
	this.g=function(objectId)
	{
		if (document.getElementById && document.getElementById(objectId))
		{
			return document.getElementById(objectId);
		}
		else if (document.all && document.all[objectId])
		{
			return document.all[objectId];
		}
		else if (document.layers && document.layers[objectId])
		{
			return document.layers[objectId];
		}
		else 
		{
			return false;
		}
	};
	this.writeTree=function()
	{
		this.dataFormat();
			//dataFormat();
	};
}
stdcchTree.prototype.version = '1.0';
stdcchTree.fn = stdcchTree.prototype;
stdcchTree.fn.dataFormat = function()
{
  var aT=new Array();
  for(var nodeId in this.N)
  { 
  	var node=this.N[nodeId];
 		aT[aT.length]=nodeId;
  	if(node)
  	{
	  	var nodeAttr=node.split(";")
	  	this.aN(nodeAttr[0],nodeAttr[1],nodeAttr[2],nodeAttr[3]);
	  	this.N[nodeId]=null;
  	}
	}
	this.totalNode=aT.length;
  aT = null;
};
stdcchTree.fn.aN=function(nodeId,nodeName,nodeparId,isHasChild)
{

	if(nodeparId=="000"&&(!this.g(this.root+"_Ul"))) this.atRootIsEmpty();
	var curNode="ul_"+nodeparId;
	if(!this.g(curNode)&&nodeparId!="000") 
	{
		alert("出错，没有挂子节点的父节点");
		return false;
	}
	if(nodeparId=="000") 
	{
		this.newNode(this.root+"_Ul",nodeId,nodeName,isHasChild);
	}
	else
	{
		treePraUl="ul_"+nodeparId
		this.newNode(treePraUl,nodeId,nodeName,isHasChild);
	}
}
stdcchTree.fn.newNode=function(rootId,nodeId,nodeName,isHasChild)
{
		var imgUlr=this.imgSrc;
		var treeLi=document.createElement("li");
		treeLi.id="li_"+nodeId;
		var treeImg=document.createElement("img");
		treeImg.id="img_"+nodeId;
		var treeSpan=document.createElement("span");
		treeSpan.id="span_"+nodeId;
		var treeCh=document.createElement("input");
		treeCh.type="checkBox"
		treeCh.id="ch_"+nodeId;
		treeCh.onclick=function()
		{
			var curId=this.id.substring(3,this.id.length);
			funCheck(curId,nodeName);
		}
		treeSpan.innerHTML=nodeName;
		treeLiPar=this.g(rootId);
		treeLiPar.appendChild(treeLi);
		treeLi.appendChild(treeImg);
		treeLi.appendChild(treeCh);
		treeLi.appendChild(treeSpan);
		if(isHasChild=="1")
		{
			var treeUl=document.createElement("ul");
			treeUl.id="ul_"+nodeId;
			treeLi.appendChild(treeUl);
			treeImg.src=this.imgSrc+"/closed.gif";
			treeUl.style.display="none";
			treeUl.style.cursor="pointer";
			treeImg.onclick=function()
			{
				if(treeUl.style.display=="none")
				{
					treeUl.style.display="block";
					this.src=imgUlr+"/opened.gif";
					var curId=this.id.substring(4,this.id.length);
					/*for(var i=0;i<treeUl.childNodes.length;i++)
					{
						alert(treeUl.childNodes[i]);
					}*/
					if(!treeUl.childNodes[0]) stGetTreeNode(curId);
				}
				else
				{
					treeUl.style.display="none";
					this.src=imgUlr+"/closed.gif";
				}
			}
		}
		else
		{
			treeImg.src=this.imgSrc+"/child.gif";
		}
		treeLi=null;
		treeImg=null;
		treeSpan=null;
		treeCh=null;
}
stdcchTree.fn.atRootIsEmpty=function()
{
	var treeRoot=document.getElementById(this.root);
	var treeUl=document.createElement("ul");
	treeRoot.appendChild(treeUl);
	treeUl.id=this.root+"_Ul";
}
/***********
	动态不带Checkbox树
***********/
function stdTree(Tname,rootTree)
{
	this.name=Tname;
	this.root=rootTree;
	this.N={};
	this.totalNode=0;
	this.imgSrc="";
	this.g=function(objectId)
	{
		if (document.getElementById && document.getElementById(objectId))
		{
			return document.getElementById(objectId);
		}
		else if (document.all && document.all[objectId])
		{
			return document.all[objectId];
		}
		else if (document.layers && document.layers[objectId])
		{
			return document.layers[objectId];
		}
		else 
		{
			return false;
		}
	};
	this.writeTree=function()
	{
		this.dataFormat();
			//dataFormat();
	};
}
stdTree.prototype.version = '1.0';
stdTree.fn = stdTree.prototype;
stdTree.fn.dataFormat = function()
{
  var aT=new Array();
  for(var nodeId in this.N)
  { 
  	var node=this.N[nodeId];
 		aT[aT.length]=nodeId;
  	if(node)
  	{
	  	var nodeAttr=node.split(";")
	  	this.aN(nodeAttr[0],nodeAttr[1],nodeAttr[2],nodeAttr[3],nodeAttr[4]);
	  	this.N[nodeId]=null;
  	}
	}
	this.totalNode=aT.length;
  aT = null;
};
stdTree.fn.aN=function(nodeId,nodeName,nodeparId,isHasChild,ulrClick)
{
	if(nodeparId=="000"&&(!this.g(this.root+"_Ul"))) this.atRootIsEmpty();
	var curNode="ul_"+nodeparId;
	if(!this.g(curNode)&&nodeparId!="000") 
	{
		alert("出错，没有挂子节点的父节点");
		return false;
	}
	if(nodeparId=="000") 
	{
		this.newNode(this.root+"_Ul",nodeId,nodeName,isHasChild,ulrClick);
	}
	else
	{
		treePraUl="ul_"+nodeparId
		this.newNode(treePraUl,nodeId,nodeName,isHasChild,ulrClick);
	}
}
stdTree.fn.newNode=function(rootId,nodeId,nodeName,isHasChild,ulrClick)
{
		var imgUlr=this.imgSrc;
		var treeLi=document.createElement("li");
		treeLi.id="li_"+nodeId;
		var treeImg=document.createElement("img");
		treeImg.id="img_"+nodeId;
		var treeA=document.createElement("a");
		treeA.id="a_"+nodeId;
		treeA.href="#this";
		treeA.innerHTML=nodeName;
		treeA.title=nodeName;
    treeA.onclick=function()
    {
      if(document.getElementById("rootTree_Ul")){
	   		sTree = document.getElementById("rootTree_Ul");
	   	}else{
	   		sTree = document.getElementById("rootTree1_Ul");
	   	}
	  var treeAs=sTree.getElementsByTagName("a");
      for(var i =0;i<treeAs.length;i++){
      treeAs[i].style.color="#333333";
      treeAs[i].style.fontWeight="normal";
   	 }
     if(typeof(ulrClick)!="undefined")
     {
      this.style.color="#DA7C28";
      this.style.fontWeight="bold";
      eval(ulrClick);
     }
			else
			{
				var curId=this.id.substring(2,this.id.length);
				//funCheck(curId,nodeName);
			}
		};
		treeLiPar=this.g(rootId);
		treeLiPar.appendChild(treeLi);
		treeLi.appendChild(treeImg);
		treeLi.appendChild(treeA);
		if(isHasChild=="1")
		{
			//treeLi.removeChild(treeCh);
			treeA.onclick=function(){return false;}
			var treeUl=document.createElement("ul");
			treeUl.id="ul_"+nodeId;
			treeLi.appendChild(treeUl);
			treeImg.src=this.imgSrc+"/closed.gif";
			treeUl.style.display="none";
			treeUl.style.cursor="pointer";
			treeImg.onclick=function()
			{
				if(treeUl.style.display=="none")
				{
					treeUl.style.display="block";
					this.src=imgUlr+"/opened.gif";
					var curId=this.id.substring(4,this.id.length);
					/*for(var i=0;i<treeUl.childNodes.length;i++)
					{
						alert(treeUl.childNodes[i]);
					}*/
					if(!treeUl.childNodes[0]) stGetTreeNode(curId);
				}
				else
				{
					treeUl.style.display="none";
					this.src=imgUlr+"/closed.gif";
				}
			}
		}
		else
		{
			treeImg.src=this.imgSrc+"/child.gif";
		}
		treeLi=null;
		treeImg=null;
		treeSpan=null;
		treeCh=null;
}
stdTree.fn.atRootIsEmpty=function()
{
	var treeRoot=document.getElementById(this.root);
	var treeUl=document.createElement("ul");
	treeRoot.appendChild(treeUl);
	treeUl.id=this.root+"_Ul";
}


