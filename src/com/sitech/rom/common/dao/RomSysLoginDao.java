package com.sitech.rom.common.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sitech.jcf.core.dao.BaseDao;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.rom.common.bo.LoginBo;
import com.sitech.rom.common.bo.RoleBo;
import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomSysLogin;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.util.JavaMapChange;
  
@SuppressWarnings("unchecked")
@Repository("romSysLoginDao")
public class RomSysLoginDao extends BaseService {
	
	public RomSysLogin queryObject(RomSysLogin romSysLogin){
		return (RomSysLogin) baseDao.queryForObject("RomSysLogin.selectRomSysLogin", romSysLogin);
	}
	
	public List<RomSysLogin> queryList(RomSysLogin romSysLogin){
		return (List<RomSysLogin>) baseDao.queryForList("RomSysLogin.selectRomSysLogin", romSysLogin);
	}
	
	public Map queryPage(RomSysLogin romSysLogin,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomSysLogin.selectRomSysLogin", romSysLogin, page, pageSize);
	}
	
	public boolean add(RomSysLogin romSysLogin){
		try {
			baseDao.insert("RomSysLogin.insertRomSysLogin", romSysLogin);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomSysLogin obj, RomSysLogin param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomSysLogin.updateRomSysLogin", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomSysLogin romSysLogin){
		try {
			return baseDao.delete("RomSysLogin.deleteRomSysLogin", romSysLogin)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
	
	public List<RoleBo> qryRomRoleInfo(RomSysRole romSysRole){
		return (List<RoleBo>)baseDao.queryForList("srole.qryRomRoleInfo",romSysRole);
	}

	public List<LoginBo> qryLoginTree(LoginBo loginBo){
		return (List<LoginBo>)baseDao.queryForList("slogin.qryLoginTreeInfo",loginBo);
	}
}