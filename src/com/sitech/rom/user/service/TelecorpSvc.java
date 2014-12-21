package com.sitech.rom.user.service;

import java.util.List;

import com.sitech.rom.common.bo.HostBo;
import com.sitech.rom.common.dao.RomTellcorpCodeDao;
import com.sitech.rom.common.dto.RomTellcorpCode;

public interface TelecorpSvc {
	public List<RomTellcorpCode> getTellcorpList();
	public List<HostBo> qryAllTellByLoginNo(String loginNo);
}
