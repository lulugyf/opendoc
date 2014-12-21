<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String parentNode = request.getParameter("parentNode");
	String parentName = request.getParameter("parentName");
	String themePath = (String)session.getAttribute("themePath");
	System.out.println("parentNode="+parentNode);
%>
<script language="JavaScript">
	
	tree<%=parentNode%> = new MzTreeView("tree<%=parentNode%>");
	tree<%=parentNode%>.setIconPath("<%=request.getContextPath()%>/nresources/<%=themePath%>/images/mztree/");
	with(tree<%=parentNode%>)
	{
		N["0_60000"]="T:用户界面框架";
		/*for(var i=0; i<atree.length; i++){
			if(atree[i][4] == "#"){
				N[atree[i][0]+"_"+atree[i][1]]="T:"+atree[i][2]+";C:L('"+atree[i][3]+"','"+atree[i][1]+"','"+atree[i][2]+"','"+atree[i][4]+"','000')";
			}else{
				N[atree[i][0]+"_"+atree[i][1]]="T:["+atree[i][1]+"]"+atree[i][2]+";C:L('"+atree[i][3]+"','"+atree[i][1]+"','"+atree[i][2]+"','"+atree[i][4]+"','000')";
			}
		}
		*/
		N["0_60000"]="T:远程运行管理系统";
		N["60000_60001"]="T:用户管理;";
	    N["60001_demo1"]="T:工号管理;C:L('1','demo5','工号管理','user/syslogin/login_main.jsp','000')";
		N["60001_demo2"]="T:角色管理;C:L('1','demo1','角色管理','../role.do','000')";
		N["60001_demo3"]="T:权限管理;C:L('1','demo2','权限管理','demo/styleManage.jsp','000')";
		N["60001_demo10"]="T:工号密码管理;C:L('1','demo10','工号密码管理','user/loginpass/pass_main.jsp','000')";
		
		N["60000_60002"]="T:控制端管理;";
	    N["60002_demo4"]="T:主机管理;C:L('1','demo4','主机管理','demo/flowManage.jsp','000')";
	    N["60002_demo9"]="T:远程用户管理;C:L('1','demo9','远程用户管理','user/syslogin/main.jsp','000')";
	    N["60002_demo5"]="T:进程管理;C:L('1','demo5','进程管理','demo/flowEditors.jsp','000')";
	    N["60002_demo6"]="T:文件管理;C:L('1','demo5','文件管理','demo/flowEditors.jsp','000')";
	    N["60002_demo7"]="T:监控管理;C:L('1','demo5','监控管理','demo/flowEditors.jsp','000')";
	    
		N["60000_60003"]="T:受控端管理;";
	    N["60003_demo8"]="T:后台命令编辑;C:L('1','demo4','后台命令编辑','demo/flowManage.jsp','000')";
	  
	}
$('#node<%=parentNode%>').html(tree<%=parentNode%>.toString());
</script>