package com.sitech.rom.common.dao;
 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.dao.BaseDao;
import com.sitech.jcf.core.exception.BusiException;
 
@Repository("romSysRoleDao")
public class RomSysRoleDao extends BaseService {

	public RomSysRole queryObject(RomSysRole romSysRole){
		return (RomSysRole) baseDao.queryForObject("RomSysRole.selectRomSysRole", romSysRole);
	}
	
	public List<RomSysRole> queryList(RomSysRole romSysRole){
		return (List<RomSysRole>) baseDao.queryForList("RomSysRole.selectRomSysRole", romSysRole);
	}
	
	public Map queryPage(RomSysRole romSysRole,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomSysRole.selectRomSysRole", romSysRole, page, pageSize);
	}
	
	public boolean add(RomSysRole romSysRole){
		try {
			baseDao.insert("RomSysRole.insertRomSysRole", romSysRole);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomSysRole obj, RomSysRole param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomSysRole.updateRomSysRole", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomSysRole romSysRole){
		try {
			return baseDao.delete("RomSysRole.deleteRomSysRole", romSysRole)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
 

}