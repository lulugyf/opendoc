 
<%@page import="java.util.*,
                java.net.*,
                java.text.*,
                java.util.zip.*,
                java.io.*" pageEncoding="UTF-8"
%>
 
<%!

String conv2Html(int i) {
		if (i == '&') return "&amp;";
		else if (i == '<') return "&lt;";
		else if (i == '>') return "&gt;";
		else if (i == '"') return "&quot;";
		else if (i == '\n') return "<br/>";
		else return "" + (char) i;
	  }
 %>
 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String content = "";
	String  text = "";
	int i;
	if(request.getParameter("readerid") != null){
		String readerid = request.getParameter("readerid");
		
		try{
			File ef = new File(readerid);
   		InputStreamReader read = new InputStreamReader(new FileInputStream(ef),"GB2312");
   		BufferedReader reader=new BufferedReader(read);
     
          while ((i = reader.read()) >= 0) {
                    content += conv2Html(i);
                }
               
       reader.close();
    }catch (Exception e) {
         System.out.println("读取文件内容操作出错");
         e.printStackTrace();
    }
    
    }
    if(request.getParameter("values") != null){
        text = request.getParameter("values");
      } 
  
 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
		<style type="text/css">
		input.button {background-color: #c0c0c0; color: #666666;
		border: 1px solid #999999; margin: 5px 1px 5px 1px;}
		input.textfield {margin: 5px 1px 5px 1px;}
		input.button:Hover { color: #444444 }
		table.filelist {background-color:#666666; width:100%; border:0px none #ffffff}
		.formular {margin: 1px; background-color:#ffffff; padding: 1em; border:1px solid #000000;}
		.formular2 {margin: 1px;}
		th { background-color:#c0c0c0 }
		tr.mouseout { background-color:#ffffff; }
		tr.mousein  { background-color:#eeeeee; }
		tr.checked  { background-color:#cccccc }
		tr.mousechecked { background-color:#c0c0c0 }
		td { font-family:Verdana, Arial, Helvetica, sans-serif; font-size: 8pt; color: #666666;}
		td.message { background-color: #FFFF00; color: #000000; text-align:center; font-weight:bold}
		td.error { background-color: #FF0000; color: #000000; text-align:center; font-weight:bold}
		A { text-decoration: none; }
		A:Hover { color : Red; text-decoration : underline; }
		BODY { font-family:Verdana, Arial, Helvetica, sans-serif; font-size: 8pt; color: #666666;}
	</style>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  <body onload="getInnerHtml()">
  <table  type="text/css">
  <tr><td id="table">
  <%=content%>
  </td></tr>
  </table>
  <script type="text/javascript">
  
  function getInnerHtml(){
  	var text = '<%=text%>';
  	if(text.length != 0){ 
  	 var  dd = document.getElementById("table").innerHTML ;
  	 document.getElementById("table").innerHTML = dd.replace(/<%=text%>/g, "<font color=\"red\" size=\"5\">"+'<%=text%>'+"</font>");
  	}
  }
  	
  </script>
   <br>
  </body>
</html>
