package com.sitech.rom.common.dao;
 
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.sitech.rom.common.bo.HostBo;
import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomHostInfo;
import com.sitech.rom.common.dto.RomUserInfo;
import com.sitech.rom.util.JavaMapChange;
import com.sitech.jcf.core.exception.BusiException;
 
@SuppressWarnings("unchecked")
@Repository("romUserInfoDao")
public class RomUserInfoDao extends BaseService {

	public RomUserInfo queryObject(RomUserInfo romUserInfo){
		return (RomUserInfo) baseDao.queryForObject("RomUserInfo.selectRomUserInfo", romUserInfo);
	}
	
	public List<RomUserInfo> queryList(RomUserInfo romUserInfo){
		return (List<RomUserInfo>) baseDao.queryForList("RomUserInfo.selectRomUserInfo", romUserInfo);
	}
	
	public Map queryPage(RomUserInfo romUserInfo,Integer page, Integer pageSize){
		return baseDao.queryForPagingList("RomUserInfo.selectRomUserInfo", romUserInfo, page, pageSize);
	}
	
	public boolean add(RomUserInfo romUserInfo){
		try {
			baseDao.insert("RomUserInfo.insertRomUserInfo", romUserInfo);
			return true;
		} catch (RuntimeException e) {
			throw new  BusiException("1000",e.getMessage());
		}
	}
	
	public boolean update(RomUserInfo obj, RomUserInfo param){
		try {
			Map map=JavaMapChange.dtoToMap(obj,"_","");
			map.putAll(JavaMapChange.dtoToMap(param,"",""));
			return baseDao.update("RomUserInfo.updateRomUserInfo", map)>0;
		} catch (RuntimeException e) {
			throw new  BusiException("1001",e.getMessage());
		}
	}
	
	public boolean delete(RomUserInfo romUserInfo){
		try {
			return baseDao.delete("RomUserInfo.deleteRomUserInfo", romUserInfo)>0;
		} catch (RuntimeException e) {
			throw new BusiException("1002",e.getMessage());
		}
	}
	
	public HostBo getUserHostInfo(HostBo hostBo){
		return (HostBo)baseDao.queryForObject("shost.qryRomHostInfo", hostBo);
	}

}