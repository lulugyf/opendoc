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
							<div id="mzTree"></div>
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
	var busiTrans='<%=request.getParameter("busiTrans")%>';
	with(tree){
		//已选节点
		<c:forEach var="item" items="${busiList}">
			var tempArr=busiTrans.split(',');
			var flag=0;
			for(var i=0;i<tempArr.length;i++){
				if(tempArr[i].split(':')[0]=='${item.busiCode}'){
					flag=1;
					break;
				}
			}
			if(flag==0){
				N["0_#${item.busiCode}"]="T:${item.busiCode}（${item.busiName}）;ctrl:sel;";
			}else{
				N["0_#${item.busiCode}"]="T:${item.busiCode}（${item.busiName}）;ctrl:sel;checked:1;";
			}
			
		</c:forEach>
		
		<c:forEach var="item" items="${transList}">
			var tempArr=busiTrans.split(',');
			var flag=0;
			for(var i=0;i<tempArr.length;i++){
				if(tempArr[i].split(':')[0]=='${item.busiCode}'){
					var tArr=tempArr[i].split(':')[1].split(',');
					for(var m=0;m<tArr.length;m++){
						if(tArr[m]=='${item.transCode}'){
							flag=1;
						}
					}
					if(flag==1) break;
				}
			}
			if(flag==0){
				N["#${item.busiCode}_&${item.transCode}"]="T:${item.transCode}（${item.transName}）;ctrl:sel;";
			}else{
				N["#${item.busiCode}_&${item.transCode}"]="T:${item.transCode}（${item.transName}）;ctrl:sel;checked:1;";
			}
			
		</c:forEach>	
		
	}
	tree.expandAll();
	//tree插入相应层
	document.getElementById("mzTree").innerHTML = tree.toString();
}

function setTransRelate(id){
    var es=document.getElementsByName(id);
    var out="";
    var temp="";
    for(var i=0;i<es.length;i++){
        if (es[i].checked) { 
        	if(es[i].value.indexOf('#')>-1){
        		temp=es[i].value.substring(es[i].value.indexOf('#')+1);
        	}else{
        		out+=temp+':'+es[i].value.substring(es[i].value.indexOf('&')+1)+',';
        	}
        }
    }
    if(out.length>0)out=out.substring(0,out.length-1);
    
    parent.setBusiTrans(out);
    parent.removeDivWin('divWin');
}


</script>
</html>