<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.ServletOutputStream"%>
<%@ page import="jxl.*"%>
<%@ page import="jxl.write.*"%>
<%@ page import="jxl.format.*"%>
<%@ page import="java.sql.*"%>
<%
	Object excelFileNameObj = request.getAttribute("excelFileName"); //导出文件名称
	Object pageCountObj = request.getAttribute("pageCount"); //分页行数
	Object theadObj = request.getAttribute("thead"); //导出数据表头
	Object dataObj = request.getAttribute("data"); //导出数据集
	Object isHasBorderObj = request.getAttribute("isHasBorder"); //是否有边框

	String excelFileName = excelFileNameObj == null ? "exportExcel.xls"
			: excelFileNameObj.toString() + ".xls";
	String pageCountStr = pageCountObj == null ? "65536" : pageCountObj
			.toString();
	String isHasBorderStr = isHasBorderObj == null ? "true"
			: isHasBorderObj.toString();

	int tLength = 0; //表头行数	
	int pageCount = 65536;
	try {
		pageCount = Integer.parseInt(pageCountStr);
		pageCount = pageCount > 65536 ? 65536 : pageCount;
		pageCount = pageCount < 1 ? 1 : pageCount;
	} catch (Exception e) {
	}

	List theadList = new ArrayList();
	if (theadObj instanceof List) {
		theadList = (List) theadObj;
		tLength = 1;
		pageCount = pageCount - tLength;
	}

	boolean isHasBorder = true;
	try {
		isHasBorder = java.lang.Boolean.valueOf(isHasBorderStr)
		.booleanValue();
	} catch (Exception e) {
	}
	
	String userAgent = request.getHeader("User-Agent");
    byte[] bytes = userAgent.contains("MSIE")?excelFileName.getBytes("GBK"):excelFileName.getBytes("UTF-8");
    excelFileName = new String(bytes,"ISO-8859-1"); 
	
	response.reset();
	response.setContentType("application/vnd.ms-excel");
	response.setContentType("charset=GBK");
	request.setCharacterEncoding("GBK");
	response.setHeader("Content-Disposition", "attachment; filename=" + excelFileName);

	ServletOutputStream oo = response.getOutputStream();
	out.clear();
	out = pageContext.pushBody();

	WritableWorkbook wb = Workbook.createWorkbook(oo);
	WritableSheet sheet = wb.createSheet("Sheet1", 0);

	if (dataObj != null) {

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
		if (dataObj instanceof List) {

			List dataList = (List) dataObj;
			for (int i = 0; i < dataList.size(); i++) {
		// 分页
		if (row > pageCount) {
			row = row - pageCount;
			sheet = wb.createSheet("Sheet"
			+ String.valueOf(sheetCount + 1),
			sheetCount);
			sheetCount++;
		}
		// 每个sheet页都加表头
		if (row == 1) {
			if (tLength > 0) {
				for (int t = 0; t < theadList.size(); t++) {
			label = new Label(t, 0, theadList.get(t)
					.toString(), wcf);
			sheet.addCell(label);
				}
			}
		}
		// 写cell
		for (int j = 0; j < ((List) dataList.get(i)).size(); j++) {
			label = new Label(j, i - (sheetCount - 1)
			* pageCount + tLength, ((List) dataList
			.get(i)).get(j).toString(), wcf);
			sheet.addCell(label);
		}
		row++;
			}
		}
		// ResultSet类型数据处理
		else if (dataObj instanceof ResultSet) {

			ResultSet result = (ResultSet) dataObj;
			ResultSetMetaData rsmd = result.getMetaData();
			int cCount = rsmd.getColumnCount();
			int i = 0;
			while (result.next()) {
		if (row > pageCount) {
			row = row - pageCount;
			sheet = wb.createSheet("Sheet"
			+ String.valueOf(sheetCount + 1),
			sheetCount);
			sheetCount++;
		}
		if (row == 1) {
			if (tLength > 0) {
				for (int t = 0; t < theadList.size(); t++) {
			label = new Label(t, 0, theadList.get(t)
					.toString(), wcf);
			sheet.addCell(label);
				}
			}
		}
		for (int j = 1; j <= cCount; j++) {
			label = new Label(j - 1, i - (sheetCount - 1)
			* pageCount + tLength, result.getString(j),
			wcf);
			sheet.addCell(label);
		}
		i++;
		row++;
			}
		}

	}
	wb.write();
	wb.close();
%>



