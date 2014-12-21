package com.sitech.rom.user.service;

import java.util.List;

import com.sitech.rom.common.bo.LoginProBo;
import com.sitech.rom.common.bo.PopedomBo;
import com.sitech.rom.common.dto.RomSysFunction;
import com.sitech.rom.common.dto.RomSysRole;

public interface PopedomSvc {
	public String getOpersForPage();
	public void setOpersForPage(String opersForPage);
	public String getOperaName(String operaCode);
	public List<PopedomBo> getPopedomBoList(RomSysRole romSysRole);
	public String getPopedomChkList(String roleId);
	public void setPopedomRole(String loginNo, String[] funcs, String[] func_opers);
	public boolean validPopedom(String loginNo, String actionName, String proCode, String opCode, String provinceCode, String tellType);
}
