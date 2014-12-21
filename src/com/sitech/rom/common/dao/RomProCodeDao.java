package com.sitech.rom.common.dao;

 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.exception.BusiException;
 
@SuppressWarnings("unchecked")
@Repository("romProCodeDao")
public class RomProCodeDao extends BaseService {

	public RomProCode queryById(java.lang.String id){
		return (RomProCode) baseDao.queryForObject("RomProCode.selectRomProCodeById", id);
	}
	
	public RomProCode queryObject(RomProCode romProCode){
		return (RomProCode) baseDao.queryForObject("RomProCode.selectRomProCode", romProCode);
	}
	
	public List<RomProCode> queryList(RomProCode romProCode){
		return (List<RomProCode>) baseDao.queryForList("RomProCode.selectRomProCode", romProCode);
	}
	
	public Map queryPage(RomProCode romProCode,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomProCode.selectRomProCode", romProCode, page, pageSize);
	}
	
	public boolean add(RomProCode romProCode){
		try {
			baseDao.insert("RomProCode.insertRomProCode", romProCode);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomProCode obj, RomProCode param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomProCode.updateRomProCode", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean deleteById(java.lang.String id){
		try {
			return baseDao.delete("RomProCode.deleteRomProCodeById", id)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
	
	public boolean delete(RomProCode romProCode){
		try {
			return baseDao.delete("RomProCode.deleteRomProCode", romProCode)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
	
 

}