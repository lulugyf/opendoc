package com.sitech.rom.common.dao;
 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomSysFunction;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.exception.BusiException;
 
@SuppressWarnings("unchecked")
@Repository("romSysFunctionDao")
public class RomSysFunctionDao extends BaseService {

	public RomSysFunction queryObject(RomSysFunction romSysFunction){
		return (RomSysFunction) baseDao.queryForObject("RomSysFunction.selectRomSysFunction", romSysFunction);
	}
	
	public List<RomSysFunction> queryList(RomSysFunction romSysFunction){
		return (List<RomSysFunction>) baseDao.queryForList("RomSysFunction.selectRomSysFunction", romSysFunction);
	}

	public List<RomSysFunction> queryListOrdName(String proCode){
		return (List<RomSysFunction>) baseDao.queryForList("sfunction.qryFunctionByProCode", proCode);
	}
	
	public Map queryPage(RomSysFunction romSysFunction,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomSysFunction.selectRomSysFunction", romSysFunction, page, pageSize);
	}
	
	public boolean add(RomSysFunction romSysFunction){
		try {
			baseDao.insert("RomSysFunction.insertRomSysFunction", romSysFunction);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomSysFunction obj, RomSysFunction param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomSysFunction.updateRomSysFunction", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomSysFunction romSysFunction){
		try {
			return baseDao.delete("RomSysFunction.deleteRomSysFunction", romSysFunction)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
 

}