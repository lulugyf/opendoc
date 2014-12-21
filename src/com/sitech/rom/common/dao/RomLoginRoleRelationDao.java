package com.sitech.rom.common.dao;
 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomLoginRoleRelation;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.exception.BusiException;
 
@SuppressWarnings("unchecked")
@Repository("romLoginRoleRelationDao")
public class RomLoginRoleRelationDao extends BaseService {

	public RomLoginRoleRelation queryObject(RomLoginRoleRelation romLoginRoleRelation){
		return (RomLoginRoleRelation) baseDao.queryForObject("RomLoginRoleRelation.selectRomLoginRoleRelation", romLoginRoleRelation);
	}
	
	public List<RomLoginRoleRelation> queryList(RomLoginRoleRelation romLoginRoleRelation){
		return (List<RomLoginRoleRelation>) baseDao.queryForList("RomLoginRoleRelation.selectRomLoginRoleRelation", romLoginRoleRelation);
	}
	
	public Map queryPage(RomLoginRoleRelation romLoginRoleRelation,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomLoginRoleRelation.selectRomLoginRoleRelation", romLoginRoleRelation, page, pageSize);
	}
	
	public boolean add(RomLoginRoleRelation romLoginRoleRelation){
		try {
			baseDao.insert("RomLoginRoleRelation.insertRomLoginRoleRelation", romLoginRoleRelation);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomLoginRoleRelation obj, RomLoginRoleRelation param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomLoginRoleRelation.updateRomLoginRoleRelation", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomLoginRoleRelation romLoginRoleRelation){
		try {
			return baseDao.delete("RomLoginRoleRelation.deleteRomLoginRoleRelation", romLoginRoleRelation)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
 

}