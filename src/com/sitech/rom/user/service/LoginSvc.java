package com.sitech.rom.user.service;

import java.util.List;

import com.sitech.rom.common.bo.LoginBo;
import com.sitech.rom.common.bo.RoleBo;
import com.sitech.rom.common.dto.RomLoginRoleRelation;
import com.sitech.rom.common.dto.RomSysLogin;
import com.sitech.rom.common.dto.RomSysRole;

public interface LoginSvc {

	public boolean addSysLogin(RomSysLogin romSysLogin);
	public boolean delSysLogin(String loginNo);
	public boolean updateSysLogin(RomSysLogin obj,String loginNoOld);
	
	public boolean validUserPwd(String loginNo,String pwd);
	public RomSysLogin queryRomSysLogin(String loginNo);
	public RomSysLogin queryRomSysLogin(String loginNo, String loginPwd);
	public void updateLoginPass(RomSysLogin romSysLogin);
	
	public List<RoleBo> getRomRoleInfo(RomSysRole romSysRole);
	public List<RomLoginRoleRelation> getLoginRoleList(RomLoginRoleRelation romLoginRoleRelation);
	public void setLoginRole(String loginNo,String[] roles);
	
	public List<LoginBo> getLoginTree(LoginBo loginBo);
}
