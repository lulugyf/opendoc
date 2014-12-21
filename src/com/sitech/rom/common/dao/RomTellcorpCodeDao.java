package com.sitech.rom.common.dao;
 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.sitech.rom.common.bo.HostBo;
import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomTellcorpCode;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.dao.BaseDao;
import com.sitech.jcf.core.exception.BusiException;
 
@SuppressWarnings("unchecked")
@Repository("romTellcorpCodeDao")
public class RomTellcorpCodeDao extends BaseService {

	public RomTellcorpCode queryObject(RomTellcorpCode romTellcorpCode){
		return (RomTellcorpCode) baseDao.queryForObject("RomTellcorpCode.selectRomTellcorpCode", romTellcorpCode);
	}
	
	public List<RomTellcorpCode> queryList(RomTellcorpCode romTellcorpCode){
		return (List<RomTellcorpCode>) baseDao.queryForList("RomTellcorpCode.selectRomTellcorpCode", romTellcorpCode);
	}
	
	public Map queryPage(RomTellcorpCode romTellcorpCode,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomTellcorpCode.selectRomTellcorpCode", romTellcorpCode, page, pageSize);
	}
	
	public boolean add(RomTellcorpCode romTellcorpCode){
		try {
			baseDao.insert("RomTellcorpCode.insertRomTellcorpCode", romTellcorpCode);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomTellcorpCode obj, RomTellcorpCode param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomTellcorpCode.updateRomTellcorpCode", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomTellcorpCode romTellcorpCode){
		try {
			return baseDao.delete("RomTellcorpCode.deleteRomTellcorpCode", romTellcorpCode)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
	
	public List<HostBo> qryAllTellByLoginNo(String loginNo) {
		return baseDao.queryForList("shost.qryAllTellByLoginNo",loginNo);
	}
	
}