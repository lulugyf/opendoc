package com.sitech.rom.common.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sitech.jcf.core.dao.BaseDao;
import com.sitech.rom.common.bo.LoginProBo;
import com.sitech.rom.common.bo.PopedomBo;
import com.sitech.rom.common.bo.PoperegBo;
import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomSysFunction;
import com.sitech.rom.common.dto.RomSysPopedom;
  
@SuppressWarnings("unchecked")
@Repository("userDao")
public class UserDao extends BaseService {
	
	@Autowired
	private BaseDao baseDao;
	
	public String getMaxLoginnoNum(){
		return (String) baseDao.queryForObject("suser.getMaxLoginnoNum");
	}
	
	public String getMaxProductNum(){
		return (String) baseDao.queryForObject("suser.getMaxProductNum");
	}
	
	public List<RomSysFunction> queryFuncListByLoginPro(LoginProBo loginProBo){
		return (List<RomSysFunction>) baseDao.queryForList("spopedom.qryFunctionByLoginPro", loginProBo);
	}

	public List<PopedomBo> queryPopedomInfo(PopedomBo popedomBo){
		return (List<PopedomBo>)baseDao.queryForList("spopedom.qryPopedomInfo", popedomBo);
	}

	public List<PopedomBo> queryPopedomList(PopedomBo popedomBo){
		return (List<PopedomBo>)baseDao.queryForList("spopedom.qryPopedomInfo", popedomBo);
	}
	
	public PoperegBo queryPoperegBo(PoperegBo poperegBo){
		return (PoperegBo) baseDao.queryForObject("spopereg.qryPopereg", poperegBo);
	}
	
	public List<PoperegBo> queryPoperegList(PoperegBo poperegBo){
		return (List<PoperegBo>) baseDao.queryForList("spopereg.qryPopereg", poperegBo);
	}
	
}