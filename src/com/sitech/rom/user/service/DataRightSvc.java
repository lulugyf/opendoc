package com.sitech.rom.user.service;

import java.util.List;

import com.sitech.rom.common.bo.DataRightBo;
import com.sitech.rom.common.dao.RomTellcorpCodeDao;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomTellcorpCode;
import com.sitech.rom.common.dto.Seq;

public interface DataRightSvc {
	public List<DataRightBo> getRightProvinceTellcorpList(String loginNo,String proCode,String functionCode);
	public List<DataRightBo> getProvinceTellcorpNoLimit(String loginNo);
}
