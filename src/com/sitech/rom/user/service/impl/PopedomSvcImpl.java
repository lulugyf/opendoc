package com.sitech.rom.user.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sitech.rom.common.bo.PopedomBo;
import com.sitech.rom.common.dao.RomOperaCodeDao;
import com.sitech.rom.common.dao.UserDao;
import com.sitech.rom.common.dto.RomOperaCode;
import com.sitech.rom.common.dto.RomSysFunction;
import com.sitech.rom.common.dto.RomSysProFunction;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.common.dto.RomSysRoleFunction;
import com.sitech.rom.user.service.FunctionSvc;
import com.sitech.rom.user.service.PopedomSvc;
import com.sitech.rom.user.service.ProFunctionSvc;
import com.sitech.rom.user.service.ProductSvc;
import com.sitech.rom.user.service.RoleFunctionSvc;
import com.sitech.rom.util.StringUtil;
import com.sitech.rom.util.Constants;

@Service("popedomSvc")
public class PopedomSvcImpl implements PopedomSvc{
	@Resource
	private UserDao userDao;
	@Resource
	private RomOperaCodeDao romOperaCodeDao;
	@Resource
	private RoleFunctionSvc roleFunctionSvc;
	@Resource
	private FunctionSvc functionSvc;
	@Resource
	private ProFunctionSvc proFunctionSvc;
	
	private String opersForPage; //涓虹晫闈㈣繑鍥炴搷浣滈泦鍚堬紝鎺у埗鎸夐挳鏄剧ず闅愯棌
	public String getOpersForPage() {
		return opersForPage;
	}
	public void setOpersForPage(String opersForPage) {
		this.opersForPage = opersForPage;
	}
	
	/*
	 * 閫氳繃鎿嶄綔浠ｇ爜鑾峰彇鎿嶄綔瀵硅薄
	 */
	public String getOperaName(String operaCode){
		
		if("".equals(operaCode))return "";
		
		RomOperaCode romOperaCode = new RomOperaCode();
		romOperaCode.setOperaCode(operaCode);
		romOperaCode = romOperaCodeDao.queryObject(romOperaCode);
		
		String operaName="";
		if(romOperaCode!=null){
			operaName=romOperaCode.getOperaName();
		}
		
		return operaName;
	}
	
	/*
	 * 灏嗗姛鑳戒俊鎭腑鐨刼perationCode涓巓perationName缁勬垚瀛楃涓�
	 */
	public List<PopedomBo> getPopedomBoList(RomSysRole romSysRole){
		
		List<PopedomBo> popedomBoList = new ArrayList<PopedomBo>();
		PopedomBo popedomBo;
		
		//閫氳繃瑙掕壊琛ㄤ腑浜у搧瀛楁杩囨护浜у搧鍔熻兘鍏崇郴锛氳秴绾х鐞嗗憳浜у搧缂栫爜涓虹┖锛屽垯鏌ヨ鎵�湁浜у搧瀵瑰簲鍔熻兘
		RomSysProFunction romSysProFunction = new RomSysProFunction(); 
		romSysProFunction.setProCode(romSysRole.getProCode());
		List<RomSysProFunction> proFuncList = proFunctionSvc.getProFunctionList(romSysProFunction);
		
		RomSysFunction romSysFunction;
		String[] opers;
		for(RomSysProFunction pf: proFuncList){
			romSysFunction=new RomSysFunction();
			romSysFunction.setFunctionCode(pf.getFunctionCode());
			//romSysFunction.setNodeType(Constants.FUNC_SHOW); //鍙鍔熻兘
			romSysFunction=functionSvc.getFunction(romSysFunction);
			if(romSysFunction!=null){
				String operStr = "";
				popedomBo = new PopedomBo();
				popedomBo.setFunctionCode(romSysFunction.getFunctionCode());
				popedomBo.setFunctionName(romSysFunction.getFunctionName());
				popedomBo.setParentCode(romSysFunction.getParentCode());
				
				if(StringUtil.notNull(romSysFunction.getOperationCode())){
					opers = romSysFunction.getOperationCode().split(";");
					for(String oper: opers){
						if(!"".equals(getOperaName(oper))){ //绀轰緥code1_name1;code2_name2
							operStr=operStr+oper+"_"+getOperaName(oper)+";";
						}
					}
				}
				
				popedomBo.setOperArr(operStr);
				popedomBoList.add(popedomBo);
			}
		}
		
		return popedomBoList;
	}
	
	/*
	 * 璁剧疆宸ュ彿瀵瑰簲瑙掕壊鐨勬潈闄�
	 * funcs=String[] functionCode
	 * func_opers=String[] functionCode+"_"+operationCode
	 */
	public void setPopedomRole(String roleId, String[] funcs, String[] func_opers){
		
		if(roleId!=null &&!"".equals(roleId)){
			RomSysRoleFunction rf = new RomSysRoleFunction();
			rf.setRoleId(roleId);
			roleFunctionSvc.deleteSysRoleFunction(rf); //鍒犻櫎瑙掕壊瀵瑰簲鐨勬潈闄�
			
			if(funcs!=null){
				for(String func:funcs){
					if(!"".equals(func)){
						rf.setFunctionCode(func);
						
						String operationCode = "";
						if(func_opers!=null){
							for(String func_oper:func_opers){
								if(func_oper.indexOf("_")>-1 && func.equals(func_oper.substring(0, func_oper.indexOf("_")))){
									operationCode=operationCode+func_oper.substring(func_oper.indexOf("_")+1)+";";
								}
							}
						}
						
						if("".equals(operationCode)){
							operationCode=Constants.OPER_NULL;
						}
						rf.setOperationCode(operationCode);
						
						roleFunctionSvc.addSysRoleFunction(rf);
					}
				}
			}
			
		}
		
	}

	/*
	 * 鑾峰彇鏉冮檺瀛楃闆嗭紝涓虹晫闈heckbox璧嬪�
	 */
	public String getPopedomChkList(String roleId){
		RomSysRoleFunction rf = new RomSysRoleFunction();
		rf.setRoleId(roleId);
		
		String rtn = "";
		List<RomSysRoleFunction> rfList= roleFunctionSvc.getSysRoleFunctionList(rf);
		for(RomSysRoleFunction rsItem: rfList){
			rtn=rtn+rsItem.getFunctionCode()+";";
			
			for(String oper:rsItem.getOperationCode().split(";")){
				if(!Constants.OPER_NULL.equals(rsItem.getOperationCode())){
					rtn=rtn+rsItem.getFunctionCode()+"_"+oper+";";
				}
			}
		}
		
		return rtn;
	}
	
	/*
	 * 楠岃瘉鍔熻兘銆佹搷浣滄潈闄�
	 */
	public boolean validPopedom(String loginNo, String actionName, String proCode, String opCode, String provinceCode, String tellType){
		
		if(loginNo==null || actionName==null || proCode==null || opCode==null )
			return false;
		
		PopedomBo param = new PopedomBo();
		param.setLoginNo(loginNo);
		param.setActionName(actionName);
		param.setProCode(proCode);
		param.setOpCode(opCode);
		
		if("-1".equals(provinceCode)){ //鑿滃崟鏍�
			List<PopedomBo> boList = userDao.queryPopedomInfo(param);
			String opersAttr="";
			String ops="";
			boolean flag=false;
			
			Map map=new HashMap();
			String key="";
			String value="";
			boolean keyRepeat=false;
			
			for(PopedomBo popedomBo : boList){
				ops = popedomBo.getOperArr().equals(Constants.OPER_NULL)?"":popedomBo.getOperArr();
				//鐩稿悓鐪佷唤杩愯惀鍟嗙殑鎿嶄綔鍚堝苟 011_1:1;2;,011_1:2;3;, 
				for (Iterator iterator = map.keySet().iterator(); iterator.hasNext();) {
					key = (String) iterator.next();
					if(key.equals(popedomBo.getProvinceCode()+"_"+popedomBo.getTellType())){
						keyRepeat=true;
						String[] operArr = ops.split(";");
						String newValue="";
						
						for(String p : operArr){
							value = map.get(key).toString(); 
							if(value.indexOf(p)<0){
								if(value.lastIndexOf(";")==value.length()-1){
									newValue=value+p+";";
								}else{
									newValue=value+";"+p+";";
								}
								map.put(popedomBo.getProvinceCode()+"_"+popedomBo.getTellType(), newValue);
							}
						}
					}
				}
				
				if(keyRepeat==false){
					map.put(popedomBo.getProvinceCode()+"_"+popedomBo.getTellType(), ops);
				}
				
				
				//涓昏彍鍗曞苟涓嶆槸鎵�湁鎿嶄綔閮芥槸鏌ヨ
				if(popedomBo.getOper()==null){
					flag = true;
				}else{ 
					String oper = popedomBo.getOper();
					String[] operArr = ops.split(";");
					
					for(String p : operArr){
						if(oper.equals(p)){
							flag = true;
						}
					}
				}
			}
			
			for (Iterator iterator = map.keySet().iterator(); iterator.hasNext();) {
				key = iterator.next().toString();
				value = map.get(key).toString();
				
				opersAttr = opersAttr+key+":"+value+",";
			}
			
			setOpersForPage(opersAttr); //椤甸潰鎸夐挳鏄剧ず闅愯棌
			return flag;
			
		}else{

			if(!Constants.PROD_SYSTEM.equals(proCode) && !Constants.PROD_HOSTCHECK.equals(proCode)){ //闈炵郴缁熷姛鑳絧rovinceCode鍜宼ellType涓嶈兘涓虹┖
				if(provinceCode==null || tellType==null)
					return false;
				param.setProvinceCode(provinceCode);
				param.setTellType(tellType);
			}
			
			List<PopedomBo> boList = userDao.queryPopedomInfo(param);
			
			for(PopedomBo popedomBo : boList){
				String ops = popedomBo.getOperArr();
				
				if(popedomBo.getOper()==null){ //涓昏彍鍗曢〉闈�-鏌ヨ
					return true;
				}else{ //鏂板淇敼鍒犻櫎绛�
					String oper = popedomBo.getOper();
					if(ops.indexOf(oper)>-1){
						return true;
					}
				}
			}
		}
		
		return false;
	}
	
}
