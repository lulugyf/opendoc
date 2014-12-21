package com.sitech.rom.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sitech.rom.common.bo.DataRightBo;
import com.sitech.rom.common.dao.DataRightDao;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomTellcorpCode;
import com.sitech.rom.user.service.DataRightSvc;

 

@Service("dataRightSvc")
public class DataRightSvcImpl implements DataRightSvc{

	@Resource
	private DataRightDao dataRightDao;
	
	@Override
	public List<DataRightBo> getRightProvinceTellcorpList(String loginNo,
			String proCode, String functionCode) {
		return dataRightDao.getRightProvinceTellcorpList(loginNo, proCode, functionCode);
	}	
	
	@Override
	public List<DataRightBo> getProvinceTellcorpNoLimit(String loginNo) {
		return dataRightDao.getProvinceTellcorpNoLimit(loginNo);
	}	
}
