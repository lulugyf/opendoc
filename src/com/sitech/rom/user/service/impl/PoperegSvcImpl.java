package com.sitech.rom.user.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sitech.rom.common.bo.PoperegBo;
import com.sitech.rom.common.dao.RomSysPopedomDao;
import com.sitech.rom.common.dao.UserDao;
import com.sitech.rom.common.dto.RomOperaCode;
import com.sitech.rom.common.dto.RomSysFunction;
import com.sitech.rom.common.dto.RomSysPopedom;
import com.sitech.rom.user.service.FunctionSvc;
import com.sitech.rom.user.service.PopedomSvc;
import com.sitech.rom.user.service.PoperegSvc;

@Service("poperegSvc")
public class PoperegSvcImpl implements PoperegSvc{
	@Resource
	private PopedomSvc popedomSvc;
	@Resource
	private FunctionSvc functionSvc;
	@Resource
	private RomSysPopedomDao romSysPopedomDao;
	@Resource
	private UserDao userDao;
	/*
	 * 根据functionCode查看对应操作项集合
	 */
	public List<RomOperaCode> getOpersForFunc(String functionCode){
		
		RomSysFunction romSysFunction = new RomSysFunction();
		romSysFunction.setFunctionCode(functionCode);
		romSysFunction=functionSvc.getFunction(romSysFunction);
		
		List<RomOperaCode> opList=null;
		RomOperaCode romOperaCode;
		
		if(romSysFunction!=null){
			
			opList = new ArrayList<RomOperaCode>();
			
			if(romSysFunction.getOperationCode()!=null){
				String[] opers = romSysFunction.getOperationCode().split(";");
				for(String op:opers){
					romOperaCode = new RomOperaCode();
					romOperaCode.setOperaCode(op);
					romOperaCode.setOperaName(popedomSvc.getOperaName(op));
					opList.add(romOperaCode);
				}
			}
			
		}
		
		return opList;
	}

	/*
	 * 获取功能注册信息
	 */
	public PoperegBo getPoperegBo(PoperegBo poperegBo){
		return userDao.queryPoperegBo(poperegBo);
	}
	
	/*
	 * 获取功能注册信息
	 */
	public RomSysPopedom getPopereg(RomSysPopedom romSysPopedom){
		return romSysPopedomDao.queryObject(romSysPopedom);
	}
	
	/*
	 * 获取功能注册列表
	 */
	public List<RomSysPopedom> getPoperegList(RomSysPopedom romSysPopedom){
		return romSysPopedomDao.queryList(romSysPopedom);
	}
	
	/*
	 * 功能注册新增
	 */
	public boolean addPopereg(RomSysPopedom romSysPopedom){
		return romSysPopedomDao.add(romSysPopedom);
	}
	
	/*
	 * 功能注册修改
	 */
	public boolean updatePopereg(RomSysPopedom romSysPopedom, RomSysPopedom param){
		return romSysPopedomDao.update(romSysPopedom, param);
	}

	/*
	 * 功能注册删除
	 */
	public boolean delPopereg(RomSysPopedom romSysPopedom){
		return romSysPopedomDao.delete(romSysPopedom);
	}
}
