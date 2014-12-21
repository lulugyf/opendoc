package com.sitech.rom.common.busi;

import org.springframework.beans.factory.annotation.Autowired;

import com.sitech.jcf.core.dao.BaseDao;
import com.sitech.jcf.core.dao.IBaseDao;

public abstract class BaseService {
	@Autowired
	protected IBaseDao baseDao = null;
	public IBaseDao getBaseDao() {
		return baseDao;
	}
	public void setBaseDao(IBaseDao baseDao) {
		this.baseDao = baseDao;
	}
}
