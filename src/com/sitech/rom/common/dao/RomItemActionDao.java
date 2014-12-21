package com.sitech.rom.common.dao;

 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomItemAction;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.exception.BusiException;
 
@SuppressWarnings("unchecked")
@Repository("romItemActionDao")
public class RomItemActionDao extends BaseService {

	public RomItemAction queryObject(RomItemAction romItemAction){
		return (RomItemAction) baseDao.queryForObject("RomItemAction.selectRomItemAction", romItemAction);
	}
	
	public List<RomItemAction> queryList(RomItemAction romItemAction){
		return (List<RomItemAction>) baseDao.queryForList("RomItemAction.selectRomItemAction", romItemAction);
	}
	
	public Map queryPage(RomItemAction romItemAction,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomItemAction.selectRomItemAction", romItemAction, page, pageSize);
	}
	
	public boolean add(RomItemAction romItemAction){
		try {
			baseDao.insert("RomItemAction.insertRomItemAction", romItemAction);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomItemAction obj, RomItemAction param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomItemAction.updateRomItemAction", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomItemAction romItemAction){
		try {
			return baseDao.delete("RomItemAction.deleteRomItemAction", romItemAction)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
 

}