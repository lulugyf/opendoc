package com.sitech.rom.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sitech.rom.common.dao.RomSysProFunctionDao;
import com.sitech.rom.common.dto.RomSysProFunction;
import com.sitech.rom.user.service.ProFunctionSvc;

@Service("proFunctionSvc")
public class ProFunctionSvcImpl implements ProFunctionSvc{
	@Resource
	private RomSysProFunctionDao romSysProFunctionDao;
	
	public List<RomSysProFunction> getProFunctionList( RomSysProFunction romSysProFunction){
		return romSysProFunctionDao.queryList(romSysProFunction);
	}
	
	public boolean delProFunction(RomSysProFunction romSysProFunction){
		return romSysProFunctionDao.delete(romSysProFunction);
	}
	
	public boolean addProFunction(RomSysProFunction romSysProFunction){
		return romSysProFunctionDao.add(romSysProFunction);
	}
}
