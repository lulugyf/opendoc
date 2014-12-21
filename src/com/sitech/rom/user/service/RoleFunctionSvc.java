package com.sitech.rom.user.service;
import java.util.List;

import com.sitech.rom.common.dto.RomSysRoleFunction;

public interface RoleFunctionSvc {
	public List<RomSysRoleFunction> getSysRoleFunctionList(RomSysRoleFunction romSysRoleFunction);
	public boolean deleteSysRoleFunction(RomSysRoleFunction romSysRoleFunction);
	public boolean addSysRoleFunction(RomSysRoleFunction romSysRoleFunction);
	
}
