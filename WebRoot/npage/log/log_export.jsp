<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.ServletOutputStream"%>
<%@ page import="com.sitech.rom.common.dto.RomSysOpLog"%>
<%@ page import="com.sitech.rom.util.DateFormat" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@ page import="jxl.*"%>
<%@ page import="jxl.write.*"%>
<%@ page import="jxl.format.*"%>
<%@ page import="java.sql.*"%>
<%
	String opStaff = request.getParameter("opStaff").trim();
    String proName = request.getParameter("proName").trim();
    String functionName = request.getParameter("functionName").trim();
    String opTimeStart = request.getParameter("opTimeStart");
    String opTimeEnd = request.getParameter("opTimeEnd");
	
	int pageCount = 10000;//分页行数
	boolean isHasBorder = false; //是否有边框
	String excelFileName = "工号日志"+com.sitech.rom.util.DateFormat.ymdhmsDate(new java.util.Date()) + ".xls";//导出文件名称
	
	int tLength = 0; //表头行数	
	List theadList = new ArrayList();//导出数据表头
	theadList.add("操作时间");
	theadList.add("操作人员");
	theadList.add("产品名称");
	theadList.add("模块名称");
	theadList.add("操作内容");
	theadList.add("备注");
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
	
	List dataList = (List)request.getAttribute("logList"); //导出数据集
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
			sheet.setColumnView(1,10);
			sheet.setColumnView(2,20);
			sheet.setColumnView(3,20);
			sheet.setColumnView(4,50);
			sheet.setColumnView(5,10);
			
			WritableFont font1 = new WritableFont(WritableFont.TIMES, 14 ); 
			WritableCellFormat format1 = new WritableCellFormat(font1); 
			
			label = new Label(0, 0, "工号日志", format1);
			format1.setAlignment(jxl.format.Alignment.CENTRE); 
			sheet.mergeCells( 0 , 0 , 5 , 0 ); 
			sheet.addCell(label);
			sheet.mergeCells( 3 , 1 , 5 , 1 ); 
			
			label = new Label(0, 1, "操作人工号："+opStaff, wcf);
			sheet.mergeCells( 0 , 1 , 2 , 1 ); 
			sheet.addCell(label);
			
			label = new Label(0, 2, "产品名称："+proName, wcf);
			sheet.mergeCells( 0 , 2 , 2 , 2 ); 
			sheet.addCell(label);
			label = new Label(3, 2, "模块名称："+functionName, wcf);
			sheet.mergeCells( 3 , 2 , 5 , 2 ); 
			sheet.addCell(label);
			
			label = new Label(0, 3, "操作时间起："+opTimeStart, wcf);
			sheet.mergeCells( 0 , 3 , 2 , 3 ); 
			sheet.addCell(label);
			label = new Label(3, 3, "操作时间止："+opTimeEnd, wcf);
			sheet.mergeCells( 3 , 3 , 5 , 3 ); 
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
			
			label = new Label(0, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(DateFormat.longDate(((RomSysOpLog) dataList.get(i)).getOpTime())), wcf);
			sheet.addCell(label);
			label = new Label(1, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((RomSysOpLog) dataList.get(i)).getOpStaff()), wcf);
			sheet.addCell(label);
			label = new Label(2, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((RomSysOpLog) dataList.get(i)).getProCode()), wcf);
			sheet.addCell(label);
			label = new Label(3, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((RomSysOpLog) dataList.get(i)).getFunctionCode()), wcf);
			sheet.addCell(label);
			label = new Label(4, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((RomSysOpLog) dataList.get(i)).getOpContent()), wcf);
			sheet.addCell(label);
			label = new Label(5, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((RomSysOpLog) dataList.get(i)).getRemarks()), wcf);
			sheet.addCell(label);
			
			row++;
		}

	}
	wb.write();
	wb.close();
%>



