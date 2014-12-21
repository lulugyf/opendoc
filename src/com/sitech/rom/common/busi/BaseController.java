package com.sitech.rom.common.busi;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
 
import com.sitech.rom.common.bo.DataRightBo;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomTellcorpCode;
import com.sitech.rom.log.service.LogSvc;
import com.sitech.rom.user.service.DataRightSvc;

public abstract class BaseController {
 
	@Resource
	private DataRightSvc dataRightSvc; 
	@Resource
	private LogSvc logSvc; 	

	public void getRightProvinceTellcorpList(HttpServletRequest request,String loginNo,String proCode,String functionCode){
		List<DataRightBo> list=dataRightSvc.getRightProvinceTellcorpList(loginNo, proCode, functionCode);
		request.setAttribute("provinceTellcorpList", list);		
	}
	
	public void getProvinceTellcorpNoLimit(HttpServletRequest request,String loginNo){
		List<DataRightBo> list=dataRightSvc.getProvinceTellcorpNoLimit(loginNo);
		request.setAttribute("provinceTellcorpList", list);		
	}
	
	public void saveLog(HttpSession session,String proCode, String funcCode,Date opTime,String opContent,String remarks){
		String loginNo=session.getAttribute("loginNo").toString();
		String loginName=session.getAttribute("loginName").toString();
		logSvc.saveLog(loginNo, loginName, proCode, funcCode, opTime, opContent, remarks);
	}
}
