<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.ServletOutputStream"%>
<%@ page import="com.sitech.rom.util.DateFormat" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@page import="com.sitech.rom.common.bo.HostCheckResultBo"%>
<%@ page import="jxl.*"%>
<%@ page import="jxl.write.*"%>
<%@ page import="jxl.format.*"%>
<%@ page import="java.sql.*"%>
<% 
    String checkTimeEnd = request.getParameter("checkTimeEnd");
	String checkTimeStart = request.getParameter("checkTimeStart");
	String provinceName = request.getParameter("provinceTell");
	String tellName = request.getParameter("tellType");
	String provinceTellName = request.getParameter("provinceTellName");
	
	int pageCount = 10000;//分页行数
	boolean isHasBorder = true; //是否有边框
	String title= provinceTellName + "分支日常运行维护检查表";
	String excelFileName = title+"_"+com.sitech.rom.util.DateFormat.ymdhmsDate(new java.util.Date()) + ".xls";//导出文件名称
	
	int tLength = 0; //表头行数	
	List theadList = new ArrayList();//导出数据表头
	theadList.add("序号");
	theadList.add("项目");
	theadList.add("检查内容");
	theadList.add("多维数据内容");
	theadList.add("检查结果(KPI_value)");
	theadList.add("检查周期");
	theadList.add("备注说明");
	theadList.add("KPI_ID");
	tLength = 4;
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
	
	List dataList = (List)request.getAttribute("hostCheckResultList"); //获取数据集
	if (dataList != null) {

		jxl.write.Label label;
		int row = 1;
		int sheetCount = 1;

		// 定义表格格式  
		WritableFont wfont = new WritableFont(WritableFont.TIMES, 10);
		WritableCellFormat wcf = new WritableCellFormat(wfont);
		wcf.setAlignment(jxl.format.Alignment.LEFT);
		wcf.setWrap(true);
		// 定义异常数据表格格式  
		WritableFont efont = new WritableFont(WritableFont.TIMES, 10,WritableFont.BOLD,false,jxl.format.UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.RED);
		WritableCellFormat eFormat = new WritableCellFormat(efont);
		eFormat.setAlignment(jxl.format.Alignment.LEFT);
		eFormat.setWrap(true);
		//定义标题格式
		WritableFont hfont = new WritableFont(WritableFont.TIMES, 16, WritableFont.BOLD,false ); 
		WritableCellFormat hFormat = new WritableCellFormat(hfont); 
		hFormat.setAlignment(jxl.format.Alignment.CENTRE); 	
		hFormat.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);		
		//定义列名格式
		WritableFont tfont = new WritableFont(WritableFont.TIMES, 11, WritableFont.BOLD,false ); 
		WritableCellFormat tFormat = new WritableCellFormat(tfont); 
		tFormat.setAlignment(jxl.format.Alignment.CENTRE);	
		tFormat.setVerticalAlignment(jxl.format.VerticalAlignment.BOTTOM);
		tFormat.setBackground(jxl.format.Colour.SKY_BLUE);
		tFormat.setWrap(true);
		//定义日期格式
		WritableFont dfont = new WritableFont(WritableFont.TIMES, 10, WritableFont.BOLD,false ); 
		WritableCellFormat dFormat = new WritableCellFormat(dfont); 
		dFormat.setAlignment(jxl.format.Alignment.RIGHT);	
			
		if (isHasBorder){
			wcf.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
			tFormat.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
			dFormat.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
			dFormat.setBorder(jxl.format.Border.RIGHT,jxl.format.BorderLineStyle.MEDIUM);
			dFormat.setBorder(jxl.format.Border.LEFT,jxl.format.BorderLineStyle.MEDIUM);
			eFormat.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
			hFormat.setBorder(jxl.format.Border.TOP,jxl.format.BorderLineStyle.MEDIUM);
			hFormat.setBorder(jxl.format.Border.LEFT,jxl.format.BorderLineStyle.MEDIUM);
			hFormat.setBorder(jxl.format.Border.RIGHT,jxl.format.BorderLineStyle.MEDIUM);
		}

		// List类型数据处理
		for (int i = 0; i < dataList.size(); i++) {
			// 分页
			if (row > pageCount) {
				row = row - pageCount;
				sheet = wb.createSheet("Sheet"+ String.valueOf(sheetCount + 1),
				sheetCount);
				sheetCount++;
			}
			//设置列宽
			sheet.setColumnView(0,9);
			sheet.setColumnView(1,9);
			sheet.setColumnView(2,25);
			sheet.setColumnView(3,32);
			sheet.setColumnView(4,18);
			sheet.setColumnView(5,18);
			sheet.setColumnView(6,13);
			sheet.setColumnView(7,19);
			sheet.setColumnView(8,16);
			
			
			
			label = new Label(1, 1, title, hFormat);
			sheet.mergeCells( 1 , 1 , 7 , 1 ); 
			sheet.addCell(label);
			
			sheet.mergeCells(1 , 2 , 7 , 2 );
			label = new Label(1, 2, "检查日期："+ checkTimeStart.split("\\s")[0].replace("-", ""), dFormat);
			sheet.mergeCells(1 , 2 , 7 , 2 ); 
			sheet.addCell(label);
			
		
			
			// 每个sheet页都加表头
			if (tLength > 0) {
				for (int t = 1; t <= theadList.size(); t++) {
					label = new Label(t,3, theadList.get(t-1).toString(), tFormat);
					sheet.addCell(label);
				}
			}
			
			label = new Label(1, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((HostCheckResultBo) dataList.get(i)).getId()).toString(), wcf);
			sheet.addCell(label);
			label = new Label(2, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((HostCheckResultBo) dataList.get(i)).getFatherSection()).toString(), wcf);
			sheet.addCell(label);
			label = new Label(3, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((HostCheckResultBo) dataList.get(i)).getChildSection()).toString(), wcf);
			sheet.addCell(label);
			label = new Label(4, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((HostCheckResultBo) dataList.get(i)).getMulSectionName()).toString(), wcf);
			sheet.addCell(label);
			if("1".equals(((HostCheckResultBo) dataList.get(i) ).getErrFlag()))
			{
			   label = new Label(5, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((HostCheckResultBo) dataList.get(i)).getCheckValue()).toString(), eFormat);
			   sheet.addCell(label);
			   label = new Label(7, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((HostCheckResultBo) dataList.get(i)).getRemark()).toString(), eFormat);
			   sheet.addCell(label);
			}else{
			   label = new Label(5, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((HostCheckResultBo) dataList.get(i)).getCheckValue()).toString(), wcf);
			   sheet.addCell(label);
			   label = new Label(7, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((HostCheckResultBo) dataList.get(i)).getRemark()).toString(), wcf);
			   sheet.addCell(label);
			}
			
			label = new Label(6, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((HostCheckResultBo) dataList.get(i)).getCheckCycle()).toString(), wcf);
			sheet.addCell(label);			
			label = new Label(8, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((HostCheckResultBo) dataList.get(i)).getKpiId()).toString(), wcf);
			sheet.addCell(label);
			
			row++;
		}

	}
	wb.write();
	wb.close();
%>



