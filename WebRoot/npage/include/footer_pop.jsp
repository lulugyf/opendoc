<script type="text/javascript" src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/system/system.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/validate_class.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<%
if(rightkey.equals("Y"))
	{%>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/rightKey.js" defer="true" ></script>
<%}%>

<%
if(hotkey.equals("Y"))
	{%>
<%@ include file="/npage/include/public_hotkey.jsp" %>
<%}%>

<script language="javascript">
$(document).ready(function(){
<%if(chgcolor.equals("Y"))
	{%>
			btnHover();//主按钮鼠标经过样式
			
			chgInputStyle();//控制文本框变色样式
<%}%>

});
</script>
