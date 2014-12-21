package com.sitech.rom.user.service;

import java.util.List;

import com.sitech.rom.common.bo.FunctionBo;
import com.sitech.rom.common.bo.LoginProBo;
import com.sitech.rom.common.dto.RomSysFunction;

public interface FunctionSvc {
	public List<RomSysFunction> getFunctionListByLoginPro(LoginProBo loginProBo);
	public List<RomSysFunction> getFunctionList(RomSysFunction romSysFunction);
	public List<RomSysFunction> getFunctionOrdNameList(String proCode);
	public RomSysFunction getFunction(RomSysFunction romSysFunction);
	public FunctionBo getFunctionBoDetail(FunctionBo functionBo);
	public String getOperaArr();
	public boolean addFunction(RomSysFunction romSysFunction);
	public boolean updateFunction(RomSysFunction romSysFunction);
	public boolean delFunction(RomSysFunction romSysFunction);
}
