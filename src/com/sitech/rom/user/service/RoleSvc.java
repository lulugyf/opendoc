package com.sitech.rom.user.service;

import java.util.List;

import com.sitech.rom.common.dto.RomProvinceCode;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.common.dto.RomTellcorpCode;

public interface RoleSvc {

	public boolean addRole(RomSysRole romSysRole);
	public RomSysRole getSysRole(RomSysRole romSysRole);
	public List<RomSysRole> getSysRoleList(RomSysRole romSysRole);
	public boolean updateRole(RomSysRole obj);
	public boolean delRole(RomSysRole obj);
}
