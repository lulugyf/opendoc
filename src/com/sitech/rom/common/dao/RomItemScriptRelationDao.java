package com.sitech.rom.common.dao;
 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.sitech.rom.common.bo.ProgressBo;
import com.sitech.rom.common.bo.ProgressInfoBo;
import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomItemScriptRelation;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.exception.BusiException;
 
@SuppressWarnings("unchecked")
@Repository("romItemScriptRelationDao")
public class RomItemScriptRelationDao extends BaseService {

	public RomItemScriptRelation queryObject(RomItemScriptRelation romItemScriptRelation){
		return (RomItemScriptRelation) baseDao.queryForObject("RomItemScriptRelation.selectRomItemScriptRelation", romItemScriptRelation);
	}
	
	public List<RomItemScriptRelation> queryList(RomItemScriptRelation romItemScriptRelation){
		return (List<RomItemScriptRelation>) baseDao.queryForList("RomItemScriptRelation.selectRomItemScriptRelation", romItemScriptRelation);
	}
	
	public Map queryPage(RomItemScriptRelation romItemScriptRelation,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomItemScriptRelation.selectRomItemScriptRelation", romItemScriptRelation, page, pageSize);
	}
	
	public boolean add(RomItemScriptRelation romItemScriptRelation){
		try {
			baseDao.insert("RomItemScriptRelation.insertRomItemScriptRelation", romItemScriptRelation);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomItemScriptRelation obj, RomItemScriptRelation param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomItemScriptRelation.updateRomItemScriptRelation", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomItemScriptRelation romItemScriptRelation){
		try {
			return baseDao.delete("RomItemScriptRelation.deleteRomItemScriptRelation", romItemScriptRelation)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
 
	public List<ProgressInfoBo> getItemScriptListByItemId(String itemId){
		return (List<ProgressInfoBo>) baseDao.queryForList("sprocessInfo.getItemScriptListByItemId", itemId);
	}
	
	public Long getCountByItemAction(ProgressBo progressBo){
		return (Long)baseDao.queryForObject("sprocess.getCountByItemAction",progressBo);
	}
	
	public List<ProgressBo> qryItemActionScriptsInfo(ProgressBo progressBo){
		return (List<ProgressBo>)baseDao.queryForList("sprocess.qryItemActionScriptsInfo",progressBo);
	}
		

}