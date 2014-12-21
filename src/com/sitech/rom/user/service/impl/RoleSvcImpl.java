package com.sitech.rom.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.sitech.rom.common.dao.RomProvinceCodeDao;
import com.sitech.rom.common.dao.RomSysLoginDao;
import com.sitech.rom.common.dao.RomSysRoleDao;
import com.sitech.rom.common.dao.RomTellcorpCodeDao;
import com.sitech.rom.common.dao.SeqDao;
import com.sitech.rom.common.dao.UserDao;
import com.sitech.rom.common.dto.RomProvinceCode;
import com.sitech.rom.common.dto.RomSysLogin;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.common.dto.RomTellcorpCode;
import com.sitech.rom.user.service.RoleSvc;
import com.sitech.rom.util.Constants;
import com.sitech.rom.util.Digests;

@Service("roleSvc")
public class RoleSvcImpl implements RoleSvc{

	@Resource 
	private RomSysRoleDao romSysRoleDao;
	
	public boolean addRole(RomSysRole romSysRole){
		return romSysRoleDao.add(romSysRole);	
	}
	
	public RomSysRole getSysRole(RomSysRole romSysRole){
		return romSysRoleDao.queryObject(romSysRole);
	}
	
	public List<RomSysRole> getSysRoleList(RomSysRole romSysRole){
		return romSysRoleDao.queryList(romSysRole);
	}
	
	public boolean updateRole(RomSysRole obj){
		RomSysRole param=new RomSysRole();
		param.setRoleId(obj.getRoleId());
		return romSysRoleDao.update(obj, param);
	}
	
	public boolean delRole(RomSysRole obj){
		RomSysRole param=new RomSysRole();
		param.setRoleId(obj.getRoleId());		
		return romSysRoleDao.update(obj, param);
	}	
 
}
