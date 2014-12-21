package com.sitech.rom.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sitech.rom.common.dao.RomSysRoleFunctionDao;
import com.sitech.rom.common.dto.RomSysRoleFunction;
import com.sitech.rom.user.service.RoleFunctionSvc;

@Service("roleFunctionSvc")
public class RoleFunctionSvcImpl implements RoleFunctionSvc{

	@Resource
	private RomSysRoleFunctionDao romSysRoleFunctionDao;
	
	public List<RomSysRoleFunction> getSysRoleFunctionList(RomSysRoleFunction romSysRoleFunction){
		return romSysRoleFunctionDao.queryList(romSysRoleFunction);
	}
	
	public boolean deleteSysRoleFunction(RomSysRoleFunction romSysRoleFunction){
		return romSysRoleFunctionDao.delete(romSysRoleFunction);
	}

	public boolean addSysRoleFunction(RomSysRoleFunction romSysRoleFunction){
		return romSysRoleFunctionDao.add(romSysRoleFunction);
	}
}
