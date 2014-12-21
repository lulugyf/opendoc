package com.sitech.rom.log.service;

import java.util.Date;
import java.util.List;

import com.sitech.rom.common.dto.RomSysOpLog;

public interface LogSvc {
	public void saveLog(String loginNo,String loginName,String proCode, String funcCode,Date opTime,String opContent,String remarks);
	public List<RomSysOpLog> getOpLogList(RomSysOpLog romSysOpLog);
}
