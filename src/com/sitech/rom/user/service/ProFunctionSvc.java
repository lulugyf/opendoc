package com.sitech.rom.user.service;

import java.util.List;

import com.sitech.rom.common.dto.RomSysProFunction;

public interface ProFunctionSvc {
	public List<RomSysProFunction> getProFunctionList( RomSysProFunction romSysProFunction);
	public boolean delProFunction(RomSysProFunction romSysProFunction);
	public boolean addProFunction(RomSysProFunction romSysProFunction);
}
