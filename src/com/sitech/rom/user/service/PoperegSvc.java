package com.sitech.rom.user.service;

import java.util.List;
import java.util.Map;

import com.sitech.rom.common.bo.PoperegBo;
import com.sitech.rom.common.dto.RomOperaCode;
import com.sitech.rom.common.dto.RomSysPopedom;

public interface PoperegSvc {
	public List<RomOperaCode> getOpersForFunc(String functionCode);
	public RomSysPopedom getPopereg(RomSysPopedom romSysPopedom);
	public List<RomSysPopedom> getPoperegList(RomSysPopedom romSysPopedom);
	public boolean addPopereg(RomSysPopedom romSysPopedom);
	public boolean updatePopereg(RomSysPopedom romSysPopedom, RomSysPopedom param);
	public boolean delPopereg(RomSysPopedom romSysPopedom);
	public PoperegBo getPoperegBo(PoperegBo poperegBo);
}
