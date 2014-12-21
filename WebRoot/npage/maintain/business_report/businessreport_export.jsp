<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.ServletOutputStream"%>
<%@ page import="com.sitech.rom.common.bo.BusinessDataBo"%>
<%@ page import="jxl.*"%>
<%@ page import="jxl.write.*"%>
<%@ page import="jxl.format.*"%>
<%@ page import="java.sql.*"%>
<%
	String provinceName=request.getParameter("provinceName");
	String hostName=request.getParameter("hostName");
	String createDateStart=request.getParameter("createDateStart");
	String createDateEnd=request.getParameter("createDateEnd");
	String busiId=request.getParameter("busiId");
	String transId=request.getParameter("transId");
	String chartType=request.getParameter("chartType");
	if("hour".equals(chartType)){
		chartType="时";
	}else if("day".equals(chartType)){
		chartType="天";
	}else{
		chartType="月";
	}
	
	int pageCount = 10000;//分页行数
	boolean isHasBorder = false; //是否有边框
	String excelFileName = "业务监控报表"+com.sitech.rom.util.DateFormat.ymdhmsDate(new java.util.Date()) + ".xls";//导出文件名称
	
	int tLength = 0; //表头行数	
	List theadList = new ArrayList();//导出数据表头
	theadList.add("监控时间");
	theadList.add("业务功能代码");
	theadList.add("交易代码");
	theadList.add("交易总量");
	theadList.add("成功交易量");
	theadList.add("用户方原因失败交易量");
	theadList.add("非用户原因失败交易量");
	theadList.add("超时失败交易量");
	theadList.add("响应不及时交易量");
	tLength = 5;
	pageCount = pageCount - tLength;
	
	String userAgent = request.getHeader("User-Agent");
    byte[] bytes = excelFileName.getBytes("GBK");
    excelFileName = new String(bytes,"ISO-8859-1"); 
	
	response.reset();
	response.setContentType("application/vnd.ms-excel");
	response.setContentType("charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
	response.setHeader("Content-Disposition", "attachment; filename=" + excelFileName);

	ServletOutputStream oo = response.getOutputStream();
	out.clear();
	out = pageContext.pushBody();

	WritableWorkbook wb = Workbook.createWorkbook(oo);
	WritableSheet sheet = wb.createSheet("Sheet1", 0);
	
	List dataList = (List)request.getAttribute("dataList"); //导出数据集
	if (dataList != null) {

		jxl.write.Label label;
		int row = 1;
		int sheetCount = 1;

		// 定义表格格式  
		WritableFont wfont = new WritableFont(WritableFont.TIMES, 12);
		WritableCellFormat wcf = new WritableCellFormat(wfont);
		wcf.setAlignment(jxl.format.Alignment.LEFT);
		if (isHasBorder)
			wcf.setBorder(jxl.format.Border.ALL,
			jxl.format.BorderLineStyle.THIN);

		// List类型数据处理
		for (int i = 0; i < dataList.size(); i++) {
			// 分页
			if (row > pageCount) {
				row = row - pageCount;
				sheet = wb.createSheet("Sheet"
				+ String.valueOf(sheetCount + 1),
				sheetCount);
				sheetCount++;
			}
			//设置列宽
			sheet.setColumnView(0,21);
			sheet.setColumnView(1,15);
			sheet.setColumnView(2,11);
			sheet.setColumnView(3,11);
			sheet.setColumnView(4,13);
			sheet.setColumnView(5,24);
			sheet.setColumnView(6,24);
			sheet.setColumnView(7,17);
			sheet.setColumnView(8,19);
			
			WritableFont font1 = new WritableFont(WritableFont.TIMES, 14 ); 
			WritableCellFormat format1 = new WritableCellFormat(font1); 
			
			label = new Label(0, 0, "业务监控报表"+"（"+chartType+"）", format1);
			format1.setAlignment(jxl.format.Alignment.CENTRE); 
			sheet.mergeCells( 0 , 0 , 8 , 0 ); 
			sheet.addCell(label);
			
			label = new Label(0, 1, "省份运营商："+provinceName, wcf);
			sheet.mergeCells( 0 , 1 , 3 , 1 ); 
			sheet.addCell(label);
			label = new Label(4, 1, "主机："+hostName, wcf);
			sheet.mergeCells( 4 , 1 , 8 , 1 ); 
			sheet.addCell(label);
			
			label = new Label(0, 2, "开始时间："+createDateStart, wcf);
			sheet.mergeCells( 0 , 2 , 3 , 2 ); 
			sheet.addCell(label);
			label = new Label(4, 2, "结束时间："+createDateEnd, wcf);
			sheet.mergeCells( 4 , 2 , 8 , 2 ); 
			sheet.addCell(label);
			
			label = new Label(0, 3, "业务功能代码："+busiId, wcf);
			sheet.mergeCells( 0 , 3 , 3 , 3 ); 
			sheet.addCell(label);
			label = new Label(4, 3, "交易代码："+transId, wcf);
			sheet.mergeCells( 4 , 3 , 8 , 3 ); 
			sheet.addCell(label);
			// 每个sheet页都加表头
			if (tLength > 0) {
				for (int t = 0; t < theadList.size(); t++) {
					label = new Label(t,4, theadList.get(t).toString(), wcf);
					sheet.addCell(label);
				}
			}
			
			// 写cell
			/*
			for (int j = 0; j < ((List) dataList.get(i)).size(); j++) {
				label = new Label(j, i - (sheetCount - 1)
				* pageCount + tLength, ((List) dataList
				.get(i)).get(j).toString(), wcf);
				sheet.addCell(label);
			}
			*/
			
			label = new Label(0, i - (sheetCount - 1) * pageCount + tLength, ((BusinessDataBo) dataList.get(i)).getCreateMinute().toString(), wcf);
			sheet.addCell(label);
			label = new Label(1, i - (sheetCount - 1) * pageCount + tLength, ((BusinessDataBo) dataList.get(i)).getItemDesc().toString(), wcf);
			sheet.addCell(label);
			label = new Label(2, i - (sheetCount - 1) * pageCount + tLength, ((BusinessDataBo) dataList.get(i)).getTransId().toString(), wcf);
			sheet.addCell(label);
			label = new Label(3, i - (sheetCount - 1) * pageCount + tLength, ((BusinessDataBo) dataList.get(i)).getTradeTotal().toString(), wcf);
			sheet.addCell(label);
			label = new Label(4, i - (sheetCount - 1) * pageCount + tLength, ((BusinessDataBo) dataList.get(i)).getTradeSucc().toString(), wcf);
			sheet.addCell(label);
			label = new Label(5, i - (sheetCount - 1) * pageCount + tLength, ((BusinessDataBo) dataList.get(i)).getFailForUser().toString(), wcf);
			sheet.addCell(label);
			label = new Label(6, i - (sheetCount - 1) * pageCount + tLength, ((BusinessDataBo) dataList.get(i)).getFailNotForUser().toString(), wcf);
			sheet.addCell(label);
			label = new Label(7, i - (sheetCount - 1) * pageCount + tLength, ((BusinessDataBo) dataList.get(i)).getFailTimeout().toString(), wcf);
			sheet.addCell(label);
			label = new Label(8, i - (sheetCount - 1) * pageCount + tLength, ((BusinessDataBo) dataList.get(i)).getFailDelay().toString(), wcf);
			sheet.addCell(label);
			
			row++;
		}

	}
	wb.write();
	wb.close();
%>



