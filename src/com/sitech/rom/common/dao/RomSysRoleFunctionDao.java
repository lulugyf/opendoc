package com.sitech.rom.common.dao;

 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomSysRoleFunction;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.exception.BusiException;
 
@SuppressWarnings("unchecked")
@Repository("romSysRoleFunctionDao")
public class RomSysRoleFunctionDao extends BaseService {

	public RomSysRoleFunction queryObject(RomSysRoleFunction romSysRoleFunction){
		return (RomSysRoleFunction) baseDao.queryForObject("RomSysRoleFunction.selectRomSysRoleFunction", romSysRoleFunction);
	}
	
	public List<RomSysRoleFunction> queryList(RomSysRoleFunction romSysRoleFunction){
		return (List<RomSysRoleFunction>) baseDao.queryForList("RomSysRoleFunction.selectRomSysRoleFunction", romSysRoleFunction);
	}
	
	public Map queryPage(RomSysRoleFunction romSysRoleFunction,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomSysRoleFunction.selectRomSysRoleFunction", romSysRoleFunction, page, pageSize);
	}
	
	public boolean add(RomSysRoleFunction romSysRoleFunction){
		try {
			baseDao.insert("RomSysRoleFunction.insertRomSysRoleFunction", romSysRoleFunction);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomSysRoleFunction obj, RomSysRoleFunction param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomSysRoleFunction.updateRomSysRoleFunction", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomSysRoleFunction romSysRoleFunction){
		try {
			return baseDao.delete("RomSysRoleFunction.deleteRomSysRoleFunction", romSysRoleFunction)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
	
 
}