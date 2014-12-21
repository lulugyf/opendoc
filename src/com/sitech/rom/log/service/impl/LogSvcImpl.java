package com.sitech.rom.log.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
 
import com.sitech.rom.common.dao.RomSysOpLogDao;
import com.sitech.rom.common.dto.RomSysOpLog;
import com.sitech.rom.log.service.LogSvc;

@Service("logSvc")
public class LogSvcImpl implements LogSvc{

	@Resource 
	private RomSysOpLogDao romSysOpLogDao;
	
	@Override
	public void saveLog(String loginNo, String loginName, String proCode, String funcCode,
			Date opTime, String opContent, String remarks) {
		// TODO Auto-generated method stub
		RomSysOpLog romSysOpLog=new RomSysOpLog();
		
		 SimpleDateFormat ymDate= new SimpleDateFormat("yyyyMMdd");
		 String yyyymmdd=ymDate.format(opTime);
 
		romSysOpLog.setOpDate(yyyymmdd);
		romSysOpLog.setOpStaff(loginNo);
		romSysOpLog.setStaffName(loginName);	
		romSysOpLog.setProCode(proCode);
		romSysOpLog.setFunctionCode(funcCode);
		romSysOpLog.setOpTime(opTime);
		romSysOpLog.setOpContent(opContent);
		romSysOpLog.setRemarks(remarks);
		
		romSysOpLogDao.add(romSysOpLog);
	}
	
	@Override
	public List<RomSysOpLog> getOpLogList(RomSysOpLog romSysOpLog){
		return romSysOpLogDao.queryOpLogList(romSysOpLog);
	}
}
