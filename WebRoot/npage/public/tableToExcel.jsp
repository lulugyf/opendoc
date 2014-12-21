<%@ page contentType="text/html;charset=GBK" %>

<%
	response.setContentType("application/vnd.ms-excel");
	response.setContentType("charset=GBK");
	request.setCharacterEncoding("GBK");
	String excelFileName = request.getParameter("excelFileName");
	if (excelFileName == null){
	  excelFileName="Excel.xls";
	}
	String userAgent = request.getHeader("User-Agent");
    byte[] bytes = userAgent.contains("MSIE")?excelFileName.getBytes("GBK"):excelFileName.getBytes("UTF-8");
    excelFileName = new String(bytes,"ISO-8859-1"); 
	
	response.setHeader("Content-Disposition","attachment; filename=" + excelFileName);
%>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<%=request.getParameter("tableContent")%>



