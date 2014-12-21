<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>  
<html>
<head>
<title>任务配置管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
	<form name="srchFrm" target="ifm" method=post>
		<input type=hidden name="opCode" id="opCode" value="<%=opCode%>">
		<input type=hidden name="proId" id="proId" value="<%=proId%>">
<div id="operation">
		<%@ include file="/npage/include/header.jsp"%>
</div>	 
				<table class="myoptable">
					<tr>
						<td colspan="4" style="text-align:center; align:left">
							<input type="button" class="b_foot" value="删 除 " /> &nbsp;&nbsp; 
							<input type="button" class="b_foot" id="add" style="display:none" value="新 增" onclick="addM()"/>
					  </td>
					</tr>
				</table>

<table id="datatable" class="display" width="100%" cellspacing="0">
    <thead>
        <tr>
            <th>First name</th>
            <th>Last name</th>
            <th>Position</th>
        </tr>
    </thead>
 
    <!-- <tfoot>
        <tr>
            <th>First name</th>
            <th>Last name</th>
            <th>Position</th>
        </tr>
    </tfoot>  -->
</table>

<%@ include file="/npage/include/footer.jsp" %>
		
	</form>
<link href="<%=request.getContextPath()%>/nresources/table/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/nresources/table/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/nresources/table/js/jquery.dataTables.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    var table = $('#datatable').dataTable( {
        "processing": true,
        "serverSide": true,
        "language": {
			 "paginate": {
			      "first": "第一页",
			      "last":"最后一页",
			      "next":"下一页",
			      "previous":"上一页"
			 },
			 "info": "记录从  _START_ 到  _END_ ",
			 "search":"搜 索",
			 "lengthMenu": '每页显示记录数   <select>'+
			             '<option value="10">10</option>'+
			             '<option value="20">20</option>'+
			             '</select>'
        },
        "ajax": {
            "url": "<%=request.getContextPath()%>/tasklist.do",
            "type": "POST",
            "data":{"opCode": "<%=opCode%>", "proId":"<%=proId%>"}
        }
    } );
    
    $('#datatable tbody').on( 'click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
            table.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    } );
 
    $('#button').click( function () {
        table.row('.selected').remove().draw( false );
    } );
} );
</script>
					
</body>
<!-- 自动补全引入js -->
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/actb/myactb.js"></script>



<script language="javascript" type="text/javascript">
/***********显示隐藏功能权限对应按钮 begin***************/
$(document).ready(function () {
    getOpersForPage();
});

var param='?';
function getOpersForPage(){
	var opersForPage = '${opersForPage}';
    if(opersForPage!='' && opersForPage!='NULL'){
        var opers = opersForPage.split(':')[1].split(';');
        for(var i=0; i<opers.length; i++){
            if(opers[i]=='1'){
                $('#add').css('display','');
            }else if(opers[i]=='2'){
                param=param+'edit=Y&';
            }else if(opers[i]=='3'){
                param=param+'del=Y&';
            }else if(opers[i]=='4'){
                param=param+'pope=Y&';
            }
        }
    }
}
/***********显示隐藏功能权限对应按钮 end***************/

//查询表单提交
function doSrchSubmit(){
    document.forms['srchFrm'].action="<%=request.getContextPath()%>/dbconnsList.do"+param;
    document.forms['srchFrm'].submit();
}
//增加关联模块，打开弹出窗口
function addM(){
	openDivWin("<%=request.getContextPath()%>/gotoAddTask.do?proId=<%=proId%>&opCode=<%=opCode%>","新增数据库配置","800","300");
}



</script>
</html>