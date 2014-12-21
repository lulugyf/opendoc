package com.sitech.rom.common.dao;

 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomSysPopedom;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.exception.BusiException;
 
@SuppressWarnings("unchecked")
@Repository("romSysPopedomDao")
public class RomSysPopedomDao extends BaseService {

	public RomSysPopedom queryObject(RomSysPopedom romSysPopedom){
		return (RomSysPopedom) baseDao.queryForObject("RomSysPopedom.selectRomSysPopedom", romSysPopedom);
	}
	
	public List<RomSysPopedom> queryList(RomSysPopedom romSysPopedom){
		return (List<RomSysPopedom>) baseDao.queryForList("RomSysPopedom.selectRomSysPopedom", romSysPopedom);
	}
	
	public Map queryPage(RomSysPopedom romSysPopedom,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomSysPopedom.selectRomSysPopedom", romSysPopedom, page, pageSize);
	}
	
	public boolean add(RomSysPopedom romSysPopedom){
		try {
			baseDao.insert("RomSysPopedom.insertRomSysPopedom", romSysPopedom);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomSysPopedom obj, RomSysPopedom param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomSysPopedom.updateRomSysPopedom", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomSysPopedom romSysPopedom){
		try {
			return baseDao.delete("RomSysPopedom.deleteRomSysPopedom", romSysPopedom)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
 

}