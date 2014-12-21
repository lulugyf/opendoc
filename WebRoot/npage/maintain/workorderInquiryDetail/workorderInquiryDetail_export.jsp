<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.ServletOutputStream"%>
<%@ page import="com.sitech.rom.util.DateFormat" %>
<%@ page import="com.sitech.rom.util.StringUtil" %>
<%@page import="com.sitech.rom.common.dto.WSndCmdDay"%>
<%@ page import="jxl.*"%>
<%@ page import="jxl.write.*"%>
<%@ page import="jxl.format.*"%>
<%@ page import="java.sql.*"%>
<% 
    String opTimeStart = request.getParameter("opTimeStart");
	String opTimeEnd = request.getParameter("opTimeEnd");
	
	int pageCount = 10000;//分页行数
	boolean isHasBorder = true; //是否有边框
	String title= "工单明细查询结果表";
	String excelFileName = title+"_"+com.sitech.rom.util.DateFormat.ymdhmsDate(new java.util.Date()) + ".xls";//导出文件名称
	
	int tLength = 0; //表头行数	
	List theadList = new ArrayList();//导出数据表头
	theadList.add("网元编码");
	theadList.add("智能卡号");
	theadList.add("用户证号");
	theadList.add("工单流水");
	theadList.add("发送时间");
	theadList.add("业务编码");
	theadList.add("指令内容");
	theadList.add("指令状态");
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
	
	List dataList = (List)request.getAttribute("workorderInquiryDetaillist"); //获取数据集
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
			sheet.setColumnView(1,20);
			sheet.setColumnView(2,25);
			sheet.setColumnView(3,25);
			sheet.setColumnView(4,25);
			sheet.setColumnView(5,25);
			sheet.setColumnView(6,25);
			sheet.setColumnView(7,30);
			sheet.setColumnView(8,20);
			
			
			
			label = new Label(1, 1, title, hFormat);
			sheet.mergeCells( 1 , 1 , 8 , 1 ); 
			sheet.addCell(label);
			
			sheet.mergeCells(1 , 2 , 8 , 2 );
			label = new Label(1, 2, "查询起止时间："+ opTimeStart + " -- " + opTimeEnd , dFormat);
			sheet.mergeCells(1 , 2 , 8 , 2 ); 
			sheet.addCell(label);
			
			// 每个sheet页都加表头
			if (tLength > 0) {
				for (int t = 1; t <= theadList.size(); t++) {
					label = new Label(t,3, theadList.get(t-1).toString(), tFormat);
					sheet.addCell(label);
				}
			}
			
			label = new Label(1, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((WSndCmdDay) dataList.get(i)).getHlrCode()).toString(), wcf);
			sheet.addCell(label);
			label = new Label(2, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((WSndCmdDay) dataList.get(i)).getImsiNo()).toString(), wcf);
			sheet.addCell(label);
			label = new Label(3, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((WSndCmdDay) dataList.get(i)).getIdNo()).toString(), wcf);
			sheet.addCell(label);
			label = new Label(4, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((WSndCmdDay) dataList.get(i)).getLoginAccept()).toString(), wcf);
			sheet.addCell(label);
			label = new Label(5, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((WSndCmdDay) dataList.get(i)).getSendTime()).toString(), wcf);
			sheet.addCell(label);			
			label = new Label(6, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((WSndCmdDay) dataList.get(i)).getOpCode()).toString(), wcf);
			sheet.addCell(label);
			label = new Label(7, i - (sheetCount - 1) * pageCount + tLength, StringUtil.safeValue(((WSndCmdDay) dataList.get(i)).getOtherChar()).toString(), wcf);
			sheet.addCell(label);
			String ackCode = StringUtil.safeValue(((WSndCmdDay) dataList.get(i)).getAckCode());
			if(ackCode.equals("0") || ackCode.equals("0000")){
			   label = new Label(8, i - (sheetCount - 1) * pageCount + tLength, "成功", wcf);
			   sheet.addCell(label);
			}else{
			   label = new Label(8, i - (sheetCount - 1) * pageCount + tLength, "失败", eFormat);
			   sheet.addCell(label);
			}
			row++;
		}

	}
	wb.write();
	wb.close();
%>



