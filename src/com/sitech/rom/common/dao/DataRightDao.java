package com.sitech.rom.common.dao; 
 
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sitech.jcf.core.dao.BaseDao;
import com.sitech.rom.common.bo.DataRightBo;
import com.sitech.rom.common.busi.BaseService;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomTellcorpCode;
 
@Repository("dataRightDao")
public class DataRightDao  extends BaseService 
{ 

	@Autowired
	private BaseDao baseDao;
	
 
	public List<RomProCode> getRightProvinceList(String loginNo,String proCode,String functionCode){
		Map m=new HashMap();
		m.put("loginNo", loginNo);
		m.put("proCode", proCode);
		m.put("functionCode", functionCode);
		return (List<RomProCode>) baseDao.queryForList("sdataright.getRightProvinceList", m);
	}
	
	public List<RomTellcorpCode> getRightTellcorpList(String loginNo,String proCode,String functionCode){
		Map m=new HashMap();
		m.put("loginNo", loginNo);
		m.put("proCode", proCode);
		m.put("functionCode", functionCode);
		return (List<RomTellcorpCode>) baseDao.queryForList("sdataright.getRightTellcorpList", m);
	}

	public List<DataRightBo> getRightProvinceTellcorpList(String loginNo,String proCode,String functionCode){
		Map m=new HashMap();
		m.put("loginNo", loginNo);
		m.put("proCode", proCode);
		m.put("functionCode", functionCode);
		return (List<DataRightBo>) baseDao.queryForList("sdataright.getRightProvinceTellcorpList", m);
	}

	public List<DataRightBo> getProvinceTellcorpNoLimit(String loginNo){
		Map m=new HashMap();
		m.put("loginNo", loginNo);
		return (List<DataRightBo>) baseDao.queryForList("sdataright.getProvinceTellcorpNoLimit", m);
	}
}
