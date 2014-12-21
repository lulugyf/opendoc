<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/uif.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/validate.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/system/system.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/moduleGrade.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/My97DatePicker/WdatePicker.js"></script>
<script language="javascript">
$(document).ready(function(){
  btnHover();//主按钮鼠标经过样式
  //chgInputStyle();//控制文本框变色样式
  //getInitGrade();
  
  /* 模块关联
    * relArr：关联模块数组
    * relId默认：oRelation
    */	
	var arr = new Array();
	arr[0]="<a href=javascript:top.L('1','demo1','布局管理','demo/layoutManage.jsp','000')>布局管理</a>";
	arr[1]="<a href=javascript:top.L('1','demo10','数据校验','demo/validate.jsp','000')>数据校验</a>";
	arr[2]="<a href=javascript:top.L('1','demo11','模态框&蒙版&滑框','demo/MessageDialog.jsp','000')>模态框</a>";
	arr[3]="<a href=javascript:top.L('1','demo13','表格导出','demo/tableToExcel_new.jsp','000')>表格导出</a>";
	arr[4]="<a href=javascript:top.L('1','demo14','表格排序','demo/sortTable_demo.jsp','000')>表格排序</a>";
			
	uif.relModule.relArr = arr;
	uif.relModule.showRelModule();
  
});

/************************************************** 
面包屑导航
    参数说明： 
    navArr：导航显示顺序数组
    pageNavShowId默认：pageNavShowId
*************************************************/
uif.pageNav.pageNavShowId='breadcrumb'; //可无
uif.pageNav.defaultPrefix='您的位置：'; //可无
uif.pageNav.navSplit=' >> ';
uif.pageNav.navArr=['用户界面框架','基本功能','<a href="#this"><%=opName%></a>'];
uif.pageNav.showPageNav();

</script>
<!--div style="margin-top:20px;margin-right:10px;margin-left:10px;padding-bottom:20px;">
	<div style="background-color:#D9EBF9;font-weight:bold;color:#FF8A00">&nbsp;关联模块 </div>
	<div id="oRelation"></div>
</div-->
<!--OBJECT ID="AddBarLimitCtrl" CLASSID="CLSID:F75FB9B2-C75A-4953-9663-CCA5AF1F79EB" CODEBASE="/ocx/IELimit.dll" style="DISPLAY: none"></OBJECT-->