<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="uif/si.tld" prefix="si" %>
<%@ taglib uri="uif/si-logic.tld" prefix="logic" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sitech.rom.common.dto.RomSysRole" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<link rel="stylesheet" type="text/css" href="style/conf_style.css"/>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/menu_min.js"></script>
<body>

<%@page import="java.util.*"%>
<%@page import="com.sitech.rom.rpt.bo.*"%>
<%
	MyBaseBO thePage = (MyBaseBO) request.getAttribute("bo");
	//System.out.println("pageNumjsp:" + thePage.getPageNum());
	int theBforePageNum = thePage.getPageNum() - 1;
	int theNextPageNum = thePage.getPageNum() + 1;
%>
<table cellspacing="0" style="margin:0 auto;">
          
           <tr>
            <td>
            	<%
            		if(thePage.getPageNum()==1){
            	%>
            	首页&nbsp;前一页&nbsp;
            	<%
            		}else{
            	%>
            	<a href="##" onclick="querySubmit('1')">首页</a>
            	<a href="##" onclick="querySubmit('<%=theBforePageNum %>')">前一页</a>&nbsp;
            	<%		
            		}
            	%>
            	<%=thePage.getPageNum() %>&nbsp;
            	<%
            		if(thePage.getPageNum()==thePage.getPageCount()){
            	%>
            	下一页&nbsp;末页&nbsp;
            	<%
            		}else{
            	%>
            	<a href="##" onclick="querySubmit('<%=theNextPageNum %>')">下一页</a>
            	<a href="##" onclick="querySubmit('<%=thePage.getPageCount() %>')">末页</a>
            	<%		
            		}
            	%>
            	跳转到&nbsp;<select onchange="querySubmit(this.value);">&nbsp;
            	<%
            		for(int i=1;i<thePage.getPageCount()+1;i++){
            	%>
            		<option value ="<%=i %>" 
            	<%
            		if(thePage.getPageNum()==i){
            	%>
            		selected = "selected" 
            	<%
            		}	
            	%>
            		><%=i%></option>
            	<%
            		}
            	%>
				</select>&nbsp;页&nbsp;
				共&nbsp;<%=thePage.getPageCount() %>&nbsp;页&nbsp;
				共&nbsp;<%=thePage.getTotalCount() %>&nbsp;条
            </td>
          </tr>
        </table>
</body>
<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">

function querySubmit(pageNum){
	//alert(pageNum);
	$("#pageNum").val(pageNum);
    document.forms['listFrm'].submit();
}

</script>
</html>
