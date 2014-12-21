package com.sitech.rom.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sitech.rom.common.bo.FunctionBo;
import com.sitech.rom.common.bo.LoginProBo;
import com.sitech.rom.common.dao.RomOperaCodeDao;
import com.sitech.rom.common.dao.RomSysFunctionDao;
import com.sitech.rom.common.dao.UserDao;
import com.sitech.rom.common.dto.RomOperaCode;
import com.sitech.rom.common.dto.RomSysFunction;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.user.service.FunctionSvc;
import com.sitech.rom.user.service.PopedomSvc;
import com.sitech.rom.util.Constants;

@Service("functionSvc")
public class FunctionSvcImpl implements FunctionSvc{
	@Resource
	private UserDao userDao;
	@Resource
	private RomSysFunctionDao romSysFunctionDao;
	@Resource
	private PopedomSvc popedomSvc;
	@Resource
	private RomOperaCodeDao romOperaCodeDao;
	
	/*
	 * 通过工号获取权限功能列表
	 */
	public List<RomSysFunction> getFunctionListByLoginPro(LoginProBo loginProBo){
		return userDao.queryFuncListByLoginPro(loginProBo);
	}
	
	/*
	 * 功能查看页面展示对象FunctionBo
	 */
	public FunctionBo getFunctionBoDetail(FunctionBo functionBo){
		
		RomSysFunction romSysFunction = new RomSysFunction();
		romSysFunction.setFunctionCode(functionBo.getFunctionCode());
		romSysFunction=getFunction(romSysFunction);
		
		String operNames="";
		if(romSysFunction!=null){
			
			functionBo.setFunctionName(romSysFunction.getFunctionName());
			functionBo.setParentCode(romSysFunction.getParentCode());
			functionBo.setNodeType(romSysFunction.getNodeType());
			functionBo.setActionName(romSysFunction.getActionName());
			functionBo.setNoteSeq(romSysFunction.getNoteSeq());
			functionBo.setOpenType(romSysFunction.getOpenType());
			
			if(romSysFunction.getOperationCode()!=null){
				String[] opers = romSysFunction.getOperationCode().split(";");
				for(String op:opers){
					operNames=operNames+op+"_"+popedomSvc.getOperaName(op)+";";
				}
				functionBo.setOperationName(operNames);
			}
			

			if(functionBo.getParentCode().equals(Constants.TREE_PARENT)){ //根节点
				functionBo.setParentName(Constants.TREE_PARENT_NAME);
			}else{
				romSysFunction = new RomSysFunction();
				romSysFunction.setFunctionCode(functionBo.getParentCode());
				romSysFunction=getFunction(romSysFunction);
				if(romSysFunction!=null){
					functionBo.setParentName(romSysFunction.getFunctionName());
				}
			}
			
		}
		
		return functionBo;
	}
	
	/*
	 * 功能新增页面展示对象FunctionBo
	 */
	public String getOperaArr(){
		
		String rtn="";
		List<RomOperaCode> operaList = romOperaCodeDao.queryList(null);
		for(RomOperaCode opera:operaList){
			rtn=rtn+opera.getOperaCode()+"_"+opera.getOperaName()+";";
		}
		
		return rtn;
	}
	/*
	 * 获取功能信息
	 */
	public RomSysFunction getFunction(RomSysFunction romSysFunction){
		return romSysFunctionDao.queryObject(romSysFunction);
	}
	
	/*
	 * 获取功能列表
	 */
	public List<RomSysFunction> getFunctionList(RomSysFunction romSysFunction){
		return romSysFunctionDao.queryList(romSysFunction);
	}
	
	/*
	 * 获取功能列表 order by functionName
	 */
	public List<RomSysFunction> getFunctionOrdNameList(String proCode){
		return romSysFunctionDao.queryListOrdName(proCode);
	}
	
	/*
	 * 功能新增
	 */
	public boolean addFunction(RomSysFunction romSysFunction){
		return romSysFunctionDao.add(romSysFunction);
	}
	
	/*
	 * 功能修改
	 */
	public boolean updateFunction(RomSysFunction romSysFunction){
		RomSysFunction param = new RomSysFunction();
		param.setFunctionCode(romSysFunction.getFunctionCode());
		return romSysFunctionDao.update(romSysFunction, param);
	}

	/*
	 * 功能删除
	 */
	public boolean delFunction(RomSysFunction romSysFunction){
		return romSysFunctionDao.delete(romSysFunction);
	}
}
