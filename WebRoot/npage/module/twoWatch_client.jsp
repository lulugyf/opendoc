<%
 /**************************************
 双屏程序加载控件 及 是否调用的控制页面
 ***************************************/
 boolean flag_forTWoS =false;
 String cookieValue =(String)session.getAttribute("doubleFlag");
 
 if("true".equals(cookieValue)){
 
 	 flag_forTWoS=true;
 	 System.out.println("seraphime※※※※※※※※※※※※※※※※※※※※※flag_forTWoS===="+flag_forTWoS);
  }
  //System.out.println("seraphime※※※※※※※※※※※※※※※※※※※※※flag_forTWoS===="+flag_forTWoS);
session.setAttribute("flag_forTWoS", Boolean.toString(flag_forTWoS));
%>
<%if(flag_forTWoS==true){%>
<OBJECT ID="sc"
		CLASSID="CLSID:10E6F627-EBE7-4CCB-8180-98188E594D4B"
		CODEBASE="<%=request.getContextPath()%>/ocx/SocketClient.CAB#version=1,0,0,8" style="display:none">
</OBJECT>	 
<%}%>  

<script language="javascript"> 
	var useConf = 0;	
	var open_flag="";
	function getUseConf() /*判断是否加载双屏*/
	{
		 <%if(flag_forTWoS==true){%>
		 	useConf =1;
		<%}else{%>
			useConf= 0;
		<%}%>

			return useConf;
	}	 
	//参数为:twowatch_flag
	function getTwoWatch_Flag(name)
	{
	    var nameEQ = name + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0;i < ca.length;i++)
	    {
	        var c = ca[i];
	        while (c.charAt(0)==' ') c = c.substring(1,c.length);
	        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	    }
	    return true;
	}		
 	function sendInfo_forTwoS(valueStr)
 {
 	
  if(getUseConf()!=1) return;
   
 	var sock  = document.getElementById("sc"); 	 
 	try{
	 sock.send(valueStr);
	}catch(E)
	{
		//alert("双屏控件未安装成功");	
	}
 }

	</script>
	