package com.sitech.rom.log.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sitech.rom.common.bo.TransGroupBo;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomSysFunction;
import com.sitech.rom.common.dto.RomSysOpLog;
import com.sitech.rom.log.service.LogSvc;
import com.sitech.rom.user.service.FunctionSvc;
import com.sitech.rom.user.service.ProductSvc;
import com.sitech.rom.util.DateFormat;
import com.sitech.rom.util.StringUtil;

@Controller
public class LogController {
	@Resource
	private ProductSvc productSvc;
	@Resource
	private FunctionSvc functionSvc;
	@Resource
	private LogSvc logSvc;
	
	@RequestMapping(value = "logMain.do")
	public String logMain(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		request.setAttribute("productList", productSvc.getProList(new RomProCode()));
		//request.setAttribute("functionList", functionSvc.getFunctionOrdNameList(null));
		
		return "log/log_main";		
	}
	
	//级联
	@ResponseBody
	@RequestMapping(value = "getFunctionByProCode.do")
	public String getFunctionByProCode(HttpServletRequest request,
			HttpServletResponse response, HttpSession session , String proCode) {
		
		List<RomSysFunction> fList = functionSvc.getFunctionOrdNameList(proCode);
		String funcStr="";
		for(RomSysFunction func:fList){
			funcStr=funcStr+func.getFunctionCode()+"_"+StringUtil.encodeUrI(func.getFunctionName())+",";
		}
		if(funcStr.length()>0)funcStr=funcStr.substring(0,funcStr.length()-1);
		
		return funcStr;		
	}

	@RequestMapping(value = "logReportExport.do")
	public String logReportExport(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		String opStaff = request.getParameter("opStaff").trim();
	    String opTimeStart = request.getParameter("opTimeStart");
	    String opTimeEnd = request.getParameter("opTimeEnd");
	    String proCode = request.getParameter("proCode").trim();
	    String functionCode = request.getParameter("functionCode").trim();
	    
	    RomSysOpLog romSysOpLog = new RomSysOpLog();
    	if(StringUtil.notNull(opStaff))romSysOpLog.setOpStaff(opStaff);
    	if(StringUtil.notNull(proCode))romSysOpLog.setProCode(proCode);
    	if(StringUtil.notNull(functionCode))romSysOpLog.setFunctionCode(functionCode);
	    if(StringUtil.notNull(opTimeStart))romSysOpLog.setOpTimeStart(DateFormat.tolongDate(opTimeStart));
	    if(StringUtil.notNull(opTimeEnd))romSysOpLog.setOpTimeEnd(DateFormat.tolongDate(opTimeEnd)); 
		
	    request.setAttribute("logList",logSvc.getOpLogList(romSysOpLog));
	    
		return "log/log_export";		
	}
}
