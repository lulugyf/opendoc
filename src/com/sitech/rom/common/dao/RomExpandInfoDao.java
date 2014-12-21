package com.sitech.rom.common.dao;

import java.util.List;
import org.springframework.stereotype.Repository;

import com.sitech.jcf.core.exception.BusiException;
import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomExpandInfo;

@SuppressWarnings("unchecked")
@Repository("romExpandInfoDao")
public class RomExpandInfoDao extends BaseService {
	
	public List<RomExpandInfo> queryList(RomExpandInfo romExpandInfo){
		return (List<RomExpandInfo>) baseDao.queryForList("RomExpandInfo.selectRomExpandInfo", romExpandInfo);		
	}
	
	public boolean add(RomExpandInfo romExpandInfo){
		try {
			baseDao.insert("RomExpandInfo.insertRomExpandInfo", romExpandInfo);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
		
	public boolean delete(RomExpandInfo romExpandInfo){
		try {
			return baseDao.delete("RomExpandInfo.deleteRomExpandInfo", romExpandInfo)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
	
	public boolean update(RomExpandInfo romExpandInfo){
		try {
			return baseDao.update("RomExpandInfo.updateRomExpandInfo", romExpandInfo)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}	
	
	
	
}
