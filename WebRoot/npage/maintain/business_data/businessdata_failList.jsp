<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
<body>
<div id="operation" style="padding:0px">
<div id="operation_table" style="margin:0px">
<div class="title"> <div class="text">交易失败列表</div></div>  
<div class="list">
	<table id="mTable">
		<tr>
			<th>业务功能代码</th>
			<th>交易代码</th>
			<th>交易流水</th>
			<th>报文</th>
		</tr>
		
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
<div align="center">
    <font color="red"><span id="succInfo">${result}</span></font>
</div>
  
</div>	
</div>
<%@ include file="/npage/include/footer.jsp"%>
 </body>
 
<script language="javascript" type="text/javascript">
function showXml(transXml){
	transXml=encodeURI(transXml);
	openDivWin("<%=request.getContextPath()%>/npage/maintain/business_data/businessdata_detailXml.jsp?transXml="+transXml,"交易报文","600","400");
}
</script>


<%  List dataList = (List)request.getAttribute("failList");
	int pageSum = dataList.size();
	int cols=4;
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
	    <%for(int j=0; j<cols; j++){%>  
	       arrPage[<%=i%>][<%=j%>]= '<%=((List)dataList.get(i)).get(j)%>';
	<%}}%>
	
	window.onload=function(){
		  gotoPage(1);
		  initFlag=1;
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
		parent.reinitIframeTime();
		
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
			
			for(var j=0;j<3;j++){
				arrTd[j]=insertTr.insertCell(j);
				arrTd[j].innerText=arrPage[iStartPos+i][j];
			}
			arrTd[3]=insertTr.insertCell(3);
			arrTd[3].innerHTML='<a style="text-decoration:underline" href="#this" onclick="showXml(\''+arrPage[iStartPos+i][3]+'\')">报文</a>';
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
</html>
