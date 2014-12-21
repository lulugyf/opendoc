package com.sitech.rom.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sitech.rom.common.bo.HostBo;
import com.sitech.rom.common.dao.RomProvinceCodeDao;
import com.sitech.rom.common.dto.RomProvinceCode;
import com.sitech.rom.user.service.ProvinceSvc;

@Service("provinceSvc")
public class ProvinceSvcImpl implements ProvinceSvc{
	@Resource
	private RomProvinceCodeDao romProvinceCodeDao;
	
	public List<RomProvinceCode> getProvinceList(){
		return romProvinceCodeDao.queryList(null);
	}
	public List<HostBo> qryAllProvinceByLoginNo(String loginNo) {
		return romProvinceCodeDao.qryAllProvinceByLoginNo(loginNo);
	}
	
}
