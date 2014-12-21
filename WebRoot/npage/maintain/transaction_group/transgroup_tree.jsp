<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>工号树</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div id="operation">
	<form name="srchFrm" method=post>
	    <div id="operation_table">			
			<div class="input">	
				<table>
					<tr>
						<td>
							分组名称：<%=request.getParameter("groupName") %>
							<div id="mzTree" style="margin-top:5px"></div>
						</td>
					</tr>
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="su" onClick="setTransRelate('sel')" class="b_foot" value="确定" />
				<input type="button" name="can" onClick="parent.removeDivWin('divWin');" class="b_foot" value="取消" />
			</div>
			<div align="center">
			    <font color="red"><span id="succInfo">${operInfo}</span></font>
			</div>
		</div>
		<%@ include file="/npage/include/footer.jsp" %>
	</form>
</div>						
</body>

<script language="javascript" src="<%=request.getContextPath()%>/njs/plugins/MzTreeView12.js"></script>	
<script language="javascript" type="text/javascript">
window.onload=function(){
	
	tree = new MzTreeView("tree");
	tree.setIconPath("<%=request.getContextPath()%>/nresources/UI/images/mztree/");//设置图片路径
	with(tree){
		//所有节点
		<c:forEach var="item" items="${busiAllList}">
			N["0_${item.itemId}#"]="T:${item.busiCode}（${item.busiName}）;ctrl:sel;";
		</c:forEach>
		
		<c:forEach var="item" items="${transAllList}">
			N["${item.itemId}#_${item.transId}"]="T:${item.transCode}（${item.transName}）;ctrl:sel;";
		</c:forEach>
		
		//已选节点
		<c:forEach var="item" items="${busiList}">
			N["0_${item.itemId}#"]="T:${item.busiCode}（${item.busiName}）;ctrl:sel;checked:1;";
		</c:forEach>
		
		<c:forEach var="item" items="${transList}">
			N["${item.itemId}#_${item.transId}"]="T:${item.transCode}（${item.transName}）;ctrl:sel;checked:1;";
		</c:forEach>	
		
	}
	tree.expandAll();
	//tree插入相应层
	document.getElementById("mzTree").innerHTML = tree.toString();
}

function setTransRelate(id){
    var es=document.getElementsByName(id);
    var out="";
    for(var i=0;i<es.length;i++){
        if (es[i].checked && es[i].value.indexOf('#')<0) out+=es[i].value+",";
    }
    if(out.length>0)out=out.substring(0,out.length-1);
    
    var packet = new AJAXPacket("<%=request.getContextPath()%>/setTransRelate.do");
	packet.data.add("proId" ,"<%=proId%>");
	packet.data.add("opCode" ,"<%=opCode%>");
	packet.data.add("provinceCode" ,'<%=request.getParameter("provinceCode")%>');
	packet.data.add("tellType" ,'<%=request.getParameter("tellType")%>');
	packet.data.add("groupId" ,'<%=request.getParameter("groupId")%>');
	packet.data.add("groupName" ,'<%=request.getParameter("groupName")%>');
	packet.data.add("hostName" ,'<%=request.getParameter("hostName")%>');
	packet.data.add("transStr" ,out);
	core.ajax.sendPacket(packet,doSetRow);
	packet =null;
}
function doSetRow(packet){
	var retCode = packet.data.findValueByName("retCode");
	
  	if(retCode=='1'){
  	    $('#succInfo').html("分组交易关系设置成功！");
  	    parent.doSrchSubmit();
  	}else if(retCode=='noright'){
  	    $('#succInfo').html("您没有权限进行此操作！");
  	}else{
  	    $('#succInfo').html("分组交易关系设置失败！");
  	}
}

</script>
</html>