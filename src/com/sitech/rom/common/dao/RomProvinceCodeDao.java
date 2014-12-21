package com.sitech.rom.common.dao;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.sitech.jcf.core.dao.BaseDao;

import com.sitech.rom.common.bo.HostBo;
import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomProvinceCode;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.exception.BusiException;

@SuppressWarnings("unchecked")
@Repository("romProvinceCodeDao")
public class RomProvinceCodeDao extends BaseService {
	
	public RomProvinceCode queryObject(RomProvinceCode romProvinceCode){
		return (RomProvinceCode) baseDao.queryForObject("RomProvinceCode.selectRomProvinceCode", romProvinceCode);
	}
	
	public List<RomProvinceCode> queryList(RomProvinceCode romProvinceCode){
		return (List<RomProvinceCode>) baseDao.queryForList("RomProvinceCode.selectRomProvinceCode", romProvinceCode);
	}
	
	public Map queryPage(RomProvinceCode romProvinceCode,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomProvinceCode.selectRomProvinceCode", romProvinceCode, page, pageSize);
	}
	
	public boolean add(RomProvinceCode romProvinceCode){
		try {
			baseDao.insert("RomProvinceCode.insertRomProvinceCode", romProvinceCode);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomProvinceCode obj, RomProvinceCode param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomProvinceCode.updateRomProvinceCode", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomProvinceCode romProvinceCode){
		try {
			return baseDao.delete("RomProvinceCode.deleteRomProvinceCode", romProvinceCode)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
	
	public List<HostBo> qryAllProvinceByLoginNo(String loginNo) {
		return baseDao.queryForList("shost.qryAllProvinceByLoginNo",loginNo);
	}
	
}