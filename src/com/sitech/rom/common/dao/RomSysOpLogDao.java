package com.sitech.rom.common.dao;

 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomSysOpLog;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.exception.BusiException;
 
@SuppressWarnings("unchecked")
@Repository("romSysOpLogDao")
public class RomSysOpLogDao extends BaseService {

	public RomSysOpLog queryObject(RomSysOpLog romSysOpLog){
		return (RomSysOpLog) baseDao.queryForObject("RomSysOpLog.selectRomSysOpLog", romSysOpLog);
	}
	
	public List<RomSysOpLog> queryList(RomSysOpLog romSysOpLog){
		return (List<RomSysOpLog>) baseDao.queryForList("RomSysOpLog.selectRomSysOpLog", romSysOpLog);
	}
	
	public List<RomSysOpLog> queryOpLogList(RomSysOpLog romSysOpLog){
		return (List<RomSysOpLog>) baseDao.queryForList("slog.selectOpLog", romSysOpLog);
	}
	
	public Map queryPage(RomSysOpLog romSysOpLog,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomSysOpLog.selectRomSysOpLog", romSysOpLog, page, pageSize);
	}
	
	public boolean add(RomSysOpLog romSysOpLog){
		try {
			baseDao.insert("RomSysOpLog.insertRomSysOpLog", romSysOpLog);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomSysOpLog obj, RomSysOpLog param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomSysOpLog.updateRomSysOpLog", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomSysOpLog romSysOpLog){
		try {
			return baseDao.delete("RomSysOpLog.deleteRomSysOpLog", romSysOpLog)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
	
 

}