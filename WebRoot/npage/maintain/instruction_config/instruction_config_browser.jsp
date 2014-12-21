
<%@page import="com.sitech.rom.common.dto.RomScriptsConfig"%>
<%@page import="java.util.*,
                java.net.*,
                java.text.*,
                java.util.zip.*,
                java.io.*" pageEncoding="UTF-8"
%>
 
 <%
 
  String ScriptsDir = "";
  String ScriptsName = "";
  String ReqUrl = "";
  String HostIP = "";
  String HostPort = "";
  int isConnected = 0;
  
 
 
  if(request.getAttribute("qryRsrCmd_File_Path") != null){
	 ScriptsDir = request.getAttribute("qryRsrCmd_File_Path").toString();
 	}
 	
 	
  if(request.getAttribute("qryRsrCmd_File_Name") != null){
	 ScriptsName =ScriptsDir+"/"+request.getAttribute("qryRsrCmd_File_Name").toString();
 	}
   
  if(request.getAttribute("qryRsrHostIP") != null){
	 HostIP = request.getAttribute("qryRsrHostIP").toString();
 	}
 	
  if(request.getAttribute("qryRsrHostPort") != null){
	 HostPort = request.getAttribute("qryRsrHostPort").toString();
 	}
 	
 	if(HostIP != "" && HostPort != ""){
 	try{
    	Socket newSocket = new Socket();
    	newSocket.connect(  new InetSocketAddress( InetAddress.getByName(HostIP ), Integer.parseInt(HostPort)), 3000);
    	
    	if(newSocket.isConnected()){
    		isConnected = 1;
    	}else{
    		isConnected = 0;
   		}
   		newSocket.close();
    }catch (IOException e){
   		 isConnected = 0;
    }
   }else{
 	 isConnected = 0;
 	 }
  
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="robots" content="noindex">
<meta http-equiv="expires" content="0">
 
<title></title>
</head>
<body onload="setViewBrowser()">
<form action="" method="post" id="BrowserForm" ></form>
 <iframe width="100%"  height="480" name="ifm" id="ifm" frameborder="0" src=""></iframe>
</body>

<script language="javascript" type="text/javascript">

function setViewBrowser(){
	
    var HostIP =  '<%=HostIP%>';
    var HostPort = '<%=HostPort%>';
    var ScriptsDir = '<%=ScriptsDir%>';
    var param = "dir="+ScriptsDir
    +"&isRight=1"
    +"&isUpLoad=0"
    +"&isNativeCommands=0"
    +"&isReadFile=0"
    +"&HostIP="+HostIP
    +"&HostPort="+HostPort;
    
    
    var isConnected = '<%=isConnected%>';
 
  
    if(HostIP == "" || HostPort == "" || ScriptsDir == "")
    {
    	  parent.showDialog("没有找到相关的网元配置信息，请确认是否配置正确！",1);
    	  parent.removeDivWin('divWin');
    	  
    }else if(isConnected == 1){
    	 
       var surl="http://"+ HostIP+":"+ HostPort+"/rpcapp/Browser_List.jsp?"+param;
   
	   document.forms['BrowserForm'].action=surl;
       document.forms['BrowserForm'].target="ifm";
   	   document.forms['BrowserForm'].submit();
   	  
	}else if(isConnected == 0){
    	 
        parent.showDialog("连接远程主机超时，请确认配置远程主机的IP地址、端口是否正确！",1);
    	parent.removeDivWin('divWin'); 
   	}
	 
}
 
	
</script>

</html> 