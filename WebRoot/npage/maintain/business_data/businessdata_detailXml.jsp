<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<html>
<head>
<title>交易报文</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
</head>
<body>
   <div id="operation">
	<div id="operation_table">
		<form action="" method="post" name="hostForm">
		
			<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
			<div class="input">
				<table>
  				
					<tr>
						<th>交易报文：</th>
						<td>
						    <textarea id="cmdResult" name="cmdResult" style="width:99%;color:orange;font-size:12px" rows="22" readonly="true"></textarea>
						</td>
					</tr>				
					
				</table>
			</div>
			<div id="operation_button">
				<input type="button" name="close" onClick="parent.removeDivWin('divWin');" class="b_foot" value="关闭"/>
			</div>
		</form>
	</div>
</div>
<%@ include file="/npage/include/footer.jsp"%>
<script>
$(document).ready(function () {
	var transXml = decodeURIComponent('<%=request.getParameter("transXml")%>');
	transXml=transXml.replace(/<\/(.+?)>/ig,'</$1>%%');
	transXml=toTxt(transXml);
	transXml=transXml.replace(/%%/ig,'<br/>');
	$('#cmdResult').html(transXml);
 	$('#cmdResult').unbind( "blur" ); //规避校验
});

function toTxt(str){    
    var RexStr = /\<|\>|\"|\'|\&/g   
    str = str.replace(RexStr,   
        function(MatchStr){   
            switch(MatchStr){   
                case "<":   
                    return "&lt;";   
                    break;   
                case ">":   
                    return "&gt;";   
                    break;   
                case "\"":   
                    return "&quot;";   
                    break;   
                case "'":   
                    return "&#39;";   
                    break;   
                case "&":   
                    return "&amp;";   
                    break;   
                default :   
                    break;   
            }   
        }   
    )   
    return str;   
}    

</script>
</body>
</html>
