package com.sitech.rom.user.service;

import java.util.List;

import com.sitech.rom.common.bo.HostBo;
import com.sitech.rom.common.dto.RomProvinceCode;

public interface ProvinceSvc {
	public List<RomProvinceCode> getProvinceList();
	public List<HostBo> qryAllProvinceByLoginNo(String loginNo);
}
