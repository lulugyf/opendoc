package com.sitech.rom.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.sitech.rom.common.dao.RomProvinceCodeDao;
import com.sitech.rom.common.dao.RomSysLoginDao;
import com.sitech.rom.common.dao.RomSysRoleDao;
import com.sitech.rom.common.dao.RomTellcorpCodeDao;
import com.sitech.rom.common.dao.SeqDao;
import com.sitech.rom.common.dao.UserDao;
import com.sitech.rom.common.dto.RomProvinceCode;
import com.sitech.rom.common.dto.RomSysLogin;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.common.dto.RomTellcorpCode;
import com.sitech.rom.common.dto.Seq;
import com.sitech.rom.user.service.RoleSvc;
import com.sitech.rom.user.service.SeqSvc;
import com.sitech.rom.util.Constants;
import com.sitech.rom.util.Digests;

@Service("seqSvc")
public class SeqSvcImpl implements SeqSvc{

	@Resource
	private SeqDao seqDao;
	
	public Long getSeq(Seq seq){
		return seqDao.getSeq(seq);
	}
}
