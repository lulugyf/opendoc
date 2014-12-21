package com.sitech.rom.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sitech.rom.common.bo.HostBo;
import com.sitech.rom.common.dao.RomTellcorpCodeDao;
import com.sitech.rom.common.dto.RomTellcorpCode;
import com.sitech.rom.user.service.TelecorpSvc;

@Service("telecorpSvc")
public class TelecorpSvcImpl implements TelecorpSvc{
	@Resource
	private RomTellcorpCodeDao romTellcorpCodeDao;

	public List<RomTellcorpCode> getTellcorpList(){
		return romTellcorpCodeDao.queryList(null);
	}
	public List<HostBo> qryAllTellByLoginNo(String loginNo) {
		return romTellcorpCodeDao.qryAllTellByLoginNo(loginNo);
	}
}
