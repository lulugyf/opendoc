<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.sitech.rom.common.bo.ProgressBo" %>
<%@ page import="com.sitech.crmpd.core.config.Configuration" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">bus节点脚本执行列表</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>省份运营商</th>
			<th>主机名称</th>
			<th>主机IP</th>
			<th>bus总线名称</th>
			<th>数据类型</th>
			<th>状态</th>
			<th>操作</th>
		</tr>
		<% 
		
		    String edit = request.getParameter("edit");
		    String del = request.getParameter("del");
		    String runstop = request.getParameter("runstop");
		    String provinceCode = request.getParameter("provinceCode");
		    String tellType = request.getParameter("tellType");
		%>
				
	</table>
	<div class="next" style="margin:0px">
		<div id="first" class="first_no"><a href="#this" onclick=gotoPage('1')></a></div>
		<div id="previous" class="previous_no"><a href="#this" onclick=gotoPage(Number(g('curpage').value)-1)></a></div>
		<span class="current"><input type="text" id="curpage" size="3" value="1"><input type="button" class="b_foot" value="确定" onclick="gotoPage(g('curpage').value)" ></span>
		<span class="pages" style="float:left;">共<label id="totalpage" style="padding:0 5px"></label>页</span> 
		<div id="forward" class="forward"><a href="#this" onclick=gotoPage(Number(g('curpage').value)+1)></a></div>
		<div id="last" class="last"><a href="#this" onclick=gotoPage(Number(g('totalpage').innerText))></a></div> 
		<select id="uiflimit" name="uiflimit" onchange="gotoPage('1')" >
			<option value="5">5</option>
			<option value="10" selected>10</option>
			<option value="15" >15</option>
			<option value="20" >20</option>
		</select>
		<span class="pages"><label style="padding:0 5px">共 <label id="totalrec" style="padding:0 5px"></label> 条</label></span>
		<span class="pages"><label style="padding:0 5px"><label id="iStartPos"></label> - <label id="iEndPos"></label></label></label></span>
	</div>
</div>
  
</div>	
</div>
<%@ include file="/npage/include/footer.jsp"%>
 </body>

<%  List dataList = (List)request.getAttribute("resultList");
	int pageSum = 0;
	if(dataList!=null){
		pageSum = dataList.size();
	}
	
	int cols=8;
%>
<script language="JavaScript">

	var totalpage;
	var pageSize;  
	var pageSum=<%=pageSum%>;
	var resultCol=<%=cols%>;
	var initFlag=0;
	var arrPage = new Array();
	
	<%for(int i=0; i<pageSum; i++){%> // 将java二维List数据转化为js二维数组
		  arrPage[<%=i%>] = new Array();
	      arrPage[<%=i%>][0]= '<%=(((ProgressBo)dataList.get(i)).getProvinceName())+(((ProgressBo)dataList.get(i)).getTellName())%>';
	      arrPage[<%=i%>][1]= '<%=((ProgressBo)dataList.get(i)).getHostName()%>';
	      arrPage[<%=i%>][2]= '<%=((ProgressBo)dataList.get(i)).getHostIp()%>';
	      arrPage[<%=i%>][3]= '<%=((ProgressBo)dataList.get(i)).getItemName()%>';
	      var isOwn='';
	      <%
	      	if(((ProgressBo)dataList.get(i)).getIsOwn()==0){%>
	      	    isOwn='自建';
	      	<%}else{%>
	      	    isOwn='<%=((ProgressBo)dataList.get(i)).getLoginNo()%>共享';
	      	<%}%>
	      arrPage[<%=i%>][4]= isOwn;
	      arrPage[<%=i%>][5]= '';
	      arrPage[<%=i%>][6]= '<%=((ProgressBo)dataList.get(i)).getActionArr()%>';
	      arrPage[<%=i%>][7]= '<%=((ProgressBo)dataList.get(i)).getItemId()%>';
	<%}%>
	
	window.onload=function(){
		  gotoPage(1);
		  initFlag=1;
		  
		parent.reinitIframeRun();
	}
	
	function gotoPage(pageNum){
		
		pageSize = g('uiflimit').value;
		totalpage = parseInt(pageSum%parseInt(pageSize))==0?parseInt(pageSum/parseInt(pageSize)):parseInt(pageSum/parseInt(pageSize))+1;
		g("totalpage").innerText= totalpage;
		g("totalrec").innerText= pageSum;//总记录数；
		
		modifyClass(pageNum);
		
		if(pageNum>0){
			if(pageNum>totalpage){
				g("curpage").value = totalpage;
				g("current").innerText = totalpage;
				pageNum=totalpage;
			}else{
				g("curpage").value = pageNum;
				g("current").innerText = pageNum;
			}
		}else{
			g("curpage").value = 1;
			g("current").innerText = 1;
			pageNum=1;
		}
    	
    	var iStartPos = (parseInt(pageNum)-1)*parseInt(pageSize);
		var iEndPos = parseInt(pageNum)*parseInt(pageSize);
		var retNum = pageSum==0?0:((iEndPos >= pageSum)?(pageSum - iStartPos) : parseInt(pageSize)); // 每页显示数据实际行数
		
		dataWrite("mTable",iStartPos,retNum);
		parent.unLoading('ajaxLoadingDiv');
		
		iEndPos=(iEndPos >= pageSum)?pageSum:iEndPos;
		g('iStartPos').innerText=pageSum==0?0:iStartPos+1;
		g('iEndPos').innerText=iEndPos;
	}

	function g(objectId){
		if(document.getElementById && document.getElementById(objectId)){
			return document.getElementById(objectId);
		}else if (document.all && document.all[objectId]){
			return document.all[objectId];
		}else if (document.layers && document.layers[objectId]){
			return document.layers[objectId];
		}else {
			return false;
		}
	}
  
	function dataWrite(tableID,iStartPos,retNum){
    	//清除表格数据
	   var tab = document.getElementById(tableID);
	   var len=tab.rows.length;
	   var thC = 0;
	   
	   for(var i=0;i<len;i++){
		 	  if(tab.children[0].children[i].children[0].tagName=='TH') 
		 	    thC++; //计算表头所占行数
		 }
		 for(var i=thC;i<len;i++){
		 	 tab.deleteRow();
		 }
		
		//写入表格数据
		var tableId=g(tableID);
    	for(var i=0; i<retNum; i++){ 
			var insertTr = tableId.insertRow(-1);
			var arrTd = new Array();
			
			for(var j=0;j<5;j++){
				arrTd[j]=insertTr.insertCell(j);
				arrTd[j].innerText=arrPage[iStartPos+i][j];
			}
			arrTd[5]=insertTr.insertCell(5);
			arrTd[5].id='td'+arrPage[iStartPos+i][7];
			arrTd[6]=insertTr.insertCell(6);
			var inHtml='';
			var actionTrr='';
			if(arrPage[iStartPos+i][6].length>0)actionTrr=arrPage[iStartPos+i][6].substring(0,arrPage[iStartPos+i][6].length-1);
			var bunArr=actionTrr.split(';');
			for(var m=0;m<bunArr.length;m++){
				inHtml+='<input type="button" name="runstop" style="display:none" onclick="execProcAction(\''+arrPage[iStartPos+i][7]+'\',\''+bunArr[m].split('_')[2]+'\',\''+arrPage[iStartPos+i][0]+'-'+arrPage[iStartPos+i][2]+'\',\''+arrPage[iStartPos+i][3]+'\')" class="b_foot" value="'+bunArr[m].split('_')[1]+'" />';
			}
			inHtml+='<input type="button" name="runstop" style="display:none" onclick="clearProcAction(\''+arrPage[iStartPos+i][7]+'\')" class="b_foot" value="清空状态" />';
			arrTd[6].innerHTML=inHtml;
		}
		
    if('<%=edit%>'=='Y'){
        $("input[name='edit']").each(function(){
            $(this).css('display','');
        })
    }
    if('<%=del%>'=='Y'){
        $("input[name='del']").each(function(){
            $(this).css('display','');
        })
    }
    if('<%=runstop%>'=='Y'){
        $("input[name='runstop']").each(function(){
            $(this).css('display','');
        })
    }
	}
	
	function modifyClass(pageNum){
		pageNum=parseInt(pageNum);
		if(totalpage!=1){
			if(pageNum>1){
				g('first').className='first';
				g('previous').className='previous';
			}else{
				g('first').className='first_no';
				g('previous').className='previous_no';
			}
			if(pageNum<totalpage){
				g('forward').className='forward';
				g('last').className='last';
			}else{
				g('forward').className='forward_no';
				g('last').className='last_no';
			}
		}else{
			g('first').className='first_no';
			g('previous').className='previous_no';
			g('forward').className='forward_no';
			g('last').className='last_no';
		}
	}

</script>
<script language="javascript" type="text/javascript">
$(document).ready(function () {
    parent.unLoading('ajaxLoadingDiv');
});
 

var showtd="";
function execProcAction(itemId,scriptsId,hostName,itemName){
	showtd="td"+itemId;
	document.getElementById(showtd).innerHTML = "";

	var packet = new AJAXPacket("<%=request.getContextPath()%>/busRun.do");
	packet.data.add("scriptsId" ,scriptsId);
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=provinceCode%>');
	packet.data.add("tellType" ,'<%=tellType%>');
	packet.data.add("hostName" ,hostName);
	packet.data.add("itemName" ,itemName);
	core.ajax.sendPacket(packet,doResultShow);
	packet =null;
}

function doResultShow(packet){
	var showtext="";
	var retCode = packet.data.findValueByName("retCode");
	if(retCode=='0'){
		showtext=packet.data.findValueByName("retMsg");
		showtext=decodeURI(showtext);
	}else{
		if(retCode=='noright'){
			showtext="您没有权限进行此操作！";			
		}else{
			showtext=packet.data.findValueByName("retMsg");
			showtext=decodeURI(showtext);
		}
	}
 
	document.getElementById(showtd).innerHTML = showtext;
	
}

function clearProcAction(itemId){
	showtd="td"+itemId;
	document.getElementById(showtd).innerHTML = "";
}
</script>
</html>
