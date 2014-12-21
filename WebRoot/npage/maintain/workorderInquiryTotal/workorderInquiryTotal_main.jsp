<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>工单统计查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div id="operation">
		<form name="srchFrm" target="ifm" method=post>
			<input type=hidden name="proId" id="proId" value="<%=proId%>">
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">

			<%@ include file="/npage/include/header.jsp"%>
			<div id="operation_table">
				<div class="input">
					<table>
						<tr>
							<th>省份运营商：</th>
							<td><select name="provinceTell" id="provinceTell">
									<c:if test="${provinceTellcorpList!=null}">
										<c:forEach items="${provinceTellcorpList}" var="item">
											<option value="${item.provinceCode}_${item.tellcorpCode}">${item.provinceName}${item.tellcorpName}</option>
										</c:forEach>
									</c:if>
							</select></td>
							<th>*查询时段：</th>
							<td><input type="radio" name="mon" id="lastMon" value="_his"
								onclick="radioChoice()" />往月 <input type="radio" name="mon"
								id="curMon" value="" onclick="radioChoice()" />当月 <span id="err"></span>
							</td>
						</tr>
						<tr>
							<th>*网元编号：</th>
							<td><select name="hlrCode" id="hlrCode" class="required"
								onchange="hlrCodeChange()">
									<option value=""></option>
									<c:if test="${cellHlrList !=null}">
										<c:forEach items="${cellHlrList}" var="item">
											<option value="${item.cellCode}_${item.hlrCode}">${item.hlrCode}</option>
										</c:forEach>
									</c:if>
							</select></td>
							<th>FROM_ID：</th>
							<td><input type="text" id="fromId" name="fromId" /></td>
						</tr>
						<tr>
							<th>*开始时间：</th>
							<td><input id="opTimeStart" name="opTimeStart" type="text"
								class="required"
								onfocus="var mindate=StartMinDate();var maxdate=StartMaxDate();var startdate=startDate();WdatePicker({startDate:startdate,dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,minDate:mindate,maxDate:maxdate})" />
							</td>

							<th>*结束时间：</th>
							<td><input id="opTimeEnd" name="opTimeEnd" type="text"
								class="required"
								onfocus="var maxdate=EndMaxDate();var mindate=EndMinDate();var startdate=EndDate();WdatePicker({startDate:startdate,dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true,minDate:mindate,maxDate:maxdate})" />
							</td>
						</tr>
						<tr>
							<td colspan="4" style="text-align:center"><input
								type="button" class="b_foot" value="查询" onclick="doSrchSubmit()" />&nbsp;&nbsp;
								<input type="button" class="b_foot" value="重置"
								onclick="javascript:document.forms('srchFrm').reset();" /> <input
								type="button" class="b_foot" value="导出" onclick="doReport()" />
							</td>
						</tr>
					</table>
				</div>

				<iframe name="ifm" src="" style="width:100%;height:400px;"
					frameborder="0"></iframe>
				<iframe name="rptExport" id="rptExport" src="" style="display:none"></iframe>

			</div>
			<%@ include file="/npage/include/footer.jsp"%>
		</form>
	</div>
</body>
<!-- 自动补全引入js -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/njs/plugins/actb/common.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/njs/plugins/actb/myactb.js"></script>

<script language="javascript" type="text/javascript">

var suffix='';
var cellCode='';
var hlrCode='';
var prelude='';
var bool=true;
var tableName='';
//查询表单提交
function doSrchSubmit(){
    if(!radioNotChoice()){
       return false;	
    }
	if(!checksubmit(srchFrm)){
		return false;		
	}
	hlrCodeChange();
    suffix= $('input:radio[name="mon"]:checked').val();
    tableName=prelude+suffix;
    checkTableName(tableName);

    if(!bool){
	   return false;
	}
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/npage/maintain/workorderInquiryTotal/workorderInquiryTotal_list.jsp?tableName="+tableName+"&cellCode="+cellCode+"&hlrCode="+hlrCode;
    document.forms['srchFrm'].submit();
}

function doReport(){
    if(!radioNotChoice()){
       return false;	
    }
	if(!checksubmit(srchFrm)){
		return false;		
	}
	hlrCodeChange();
	suffix= $('input:radio[name="mon"]:checked').val();
    tableName=prelude+suffix;
    checkTableName(tableName);
    if(!bool){
	   return false;
	}
	var provinceTell=document.getElementById('provinceTell').value;
	var provinceCode=provinceTell.substring(0,provinceTell.indexOf('_'));
	var tellType=provinceTell.substring(provinceTell.indexOf('_')+1);
	var fromId=$("#fromId").val();  
	var qryPara='?proId=<%=proId%>&opCode=<%=opCode%>&provinceCode='+provinceCode+'&tellType='+tellType+'&tableName='+tableName+'&cellCode='+cellCode+'&hlrCode='+hlrCode+'&fromId=' + fromId;
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/womInquiryTotalExport.do"+ qryPara;
    document.forms['srchFrm'].target='rptExport';
    document.forms['srchFrm'].submit();
    unLoading('ajaxLoadingDiv');
}

function hlrCodeChange(){

	var cellhlr = $("#hlrCode").find("option:selected").val();
	
	if(cellhlr!='' && cellhlr!='NULL'){        
        cellCode = cellhlr.split('_')[0];
       	hlrCode = cellhlr.split('_')[1];
    }
    getTableName();
}
//获取表名
function getTableName(){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/getTableName.do");
	packet.data.add("loginNo" ,'<%=session.getAttribute("loginNo").toString()%>');
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
    packet.data.add("provinceCode" ,'<%=request.getParameter("provinceCode")%>');
	packet.data.add("tellType" ,'<%=request.getParameter("tellType")%>');

	packet.data.add("hlrCode" ,hlrCode);
	packet.data.add("cellCode" ,cellCode);
	core.ajax.sendPacketHtml(packet,doGetTabName);
	packet =null;
}
function doGetTabName(data){
  if(data=='noright'){
        bool=false;
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  }else if(data!='' && data != 'NULL'){
        bool=true;
    	prelude=data;
  }else
  {  
        bool=false;
        parent.parent.showDialog("您所查找的网元编号对应的表不存在！",0);
  }
}

//检查表是否存在
function checkTableName(tableName){
	var packet = new AJAXPacket("<%=request.getContextPath()%>/checkTableName.do");
	packet.data.add("loginNo" ,'<%=session.getAttribute("loginNo").toString()%>');
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
    packet.data.add("provinceCode" ,'<%=request.getParameter("provinceCode")%>');
	packet.data.add("tellType" ,'<%=request.getParameter("tellType")%>');

	packet.data.add("tableName" ,tableName);
	core.ajax.sendPacketHtml(packet,doCheckTabName);
	packet =null;
}

function doCheckTabName(data){
  if(data=='noright'){
        bool=false;
  	    parent.parent.showDialog("您没有权限进行此操作！",0);
  }else if(data=='1'){
        bool=true;
  }else
  { 
        bool=false;
        parent.parent.showDialog("您所查找的网元编号对应的表不存在！",0);     
  }
}

function radioNotChoice(){
   var list= $('input:radio[name="mon"]:checked').val();
   if(list==null){
      document.getElementById("err").innerText = "请选择时间段"; 
      document.getElementById("err").className="error_css";
                return false;
   }else{
      return true;
   }
}

function radioChoice(){
      document.getElementById("err").innerText = "";
      document.getElementById("err").className = "";
      $("#opTimeStart").attr("value",'');//清空内容
      $("#opTimeEnd").attr("value",'');//清空内容
}



function StartMinDate(){
  if($('#curMon').attr("checked")){
      return "%y-%M-01 00:00:00";
  }
  else if($('#lastMon').attr("checked")){
      return "1900-01-01 00:00:00";
  } 
  else
  {
     radioNotChoice();
  }
}

function startDate(){
  if($('#curMon').attr("checked")){
      return "%y-%M-%d 00:00:00";
  }
  else if($('#lastMon').attr("checked")){
       return "%y-{%M-1}-%d 00:00:00";
  }else{
      return "%y-%M-%d 00:00:00";
  }
}

function EndDate(){
  if($('#curMon').attr("checked")){
      return "%y-%M-%d 23:59:59";
  }
  else if($('#lastMon').attr("checked")){
       return "%y-{%M-1}-%d 23:59:59";
  }else{
      return "%y-%M-%d 23:59:59";
  } 
}

function StartMaxDate(){
  if($('#curMon').attr("checked")){
     if($('#opTimeEnd').val()!=""){
      return "#F{$dp.$D(\'opTimeEnd\')}";
     }
     else
     {
       return "%y-%M-%ld 23:59:59";
     }
  }
  else if($('#lastMon').attr("checked")){
     if($('#opTimeEnd').val()!=""){
        return "#F{$dp.$D(\'opTimeEnd\')}";
     }
     else
     {
        return "%y-{%M-1}-%ld 23:59:59";
     }
       
  } 
}

function EndMaxDate(){
  if($('#curMon').attr("checked")){
      return "%y-%M-%ld 23:59:59";
  }
  else if($('#lastMon').attr("checked")){
       return "%y-{%M-1}-%ld 23:59:59";
  } 
  else
  {
     radioNotChoice();
  }
}

function EndMinDate(){
  if($('#curMon').attr("checked")){
      if($('#opTimeStart').val()!=""){
         return "#F{$dp.$D(\'opTimeStart\')}";
      }
      else
      {
         return "%y-%M-01 00:00:00";
      }
  }
  else if($('#lastMon').attr("checked")){
       return "#F{$dp.$D(\'opTimeStart\')}";
  }  
}
</script>
</html>