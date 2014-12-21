package com.sitech.rom.common.dao;
 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomOperaCode;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.exception.BusiException;
 
@SuppressWarnings("unchecked")
@Repository("romOperaCodeDao")
public class RomOperaCodeDao extends BaseService {

	public RomOperaCode queryObject(RomOperaCode romOperaCode){
		return (RomOperaCode) baseDao.queryForObject("RomOperaCode.selectRomOperaCode", romOperaCode);
	}
	
	public List<RomOperaCode> queryList(RomOperaCode romOperaCode){
		return (List<RomOperaCode>) baseDao.queryForList("RomOperaCode.selectRomOperaCode", romOperaCode);
	}
	
	public Map queryPage(RomOperaCode romOperaCode,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomOperaCode.selectRomOperaCode", romOperaCode, page, pageSize);
	}
	
	public boolean add(RomOperaCode romOperaCode){
		try {
			baseDao.insert("RomOperaCode.insertRomOperaCode", romOperaCode);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomOperaCode obj, RomOperaCode param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomOperaCode.updateRomOperaCode", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomOperaCode romOperaCode){
		try {
			return baseDao.delete("RomOperaCode.deleteRomOperaCode", romOperaCode)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
	
 

}