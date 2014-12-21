package com.sitech.rom.common.dao;

 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomSysProFunction;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.exception.BusiException;
 
@SuppressWarnings("unchecked")
@Repository("romSysProFunctionDao")
public class RomSysProFunctionDao extends BaseService {

	public RomSysProFunction queryObject(RomSysProFunction romSysProFunction){
		return (RomSysProFunction) baseDao.queryForObject("RomSysProFunction.selectRomSysProFunction", romSysProFunction);
	}
	
	public List<RomSysProFunction> queryList(RomSysProFunction romSysProFunction){
		return (List<RomSysProFunction>) baseDao.queryForList("RomSysProFunction.selectRomSysProFunction", romSysProFunction);
	}
	
	public Map queryPage(RomSysProFunction romSysProFunction,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomSysProFunction.selectRomSysProFunction", romSysProFunction, page, pageSize);
	}
	
	public boolean add(RomSysProFunction romSysProFunction){
		try {
			baseDao.insert("RomSysProFunction.insertRomSysProFunction", romSysProFunction);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomSysProFunction obj, RomSysProFunction param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomSysProFunction.updateRomSysProFunction", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomSysProFunction romSysProFunction){
		try {
			return baseDao.delete("RomSysProFunction.deleteRomSysProFunction", romSysProFunction)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
 

}