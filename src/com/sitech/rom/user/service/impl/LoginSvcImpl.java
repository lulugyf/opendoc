package com.sitech.rom.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.sitech.rom.common.bo.LoginBo;
import com.sitech.rom.common.bo.RoleBo;
import com.sitech.rom.common.dao.RomLoginRoleRelationDao;
import com.sitech.rom.common.dao.RomSysLoginDao;
import com.sitech.rom.common.dao.UserDao;
import com.sitech.rom.common.dto.RomLoginRoleRelation;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomSysLogin;
import com.sitech.rom.common.dto.RomSysProFunction;
import com.sitech.rom.common.dto.RomSysRole;
import com.sitech.rom.user.service.LoginSvc;
import com.sitech.rom.util.Constants;
import com.sitech.rom.util.Digests;
@Service("loginSvc")
public class LoginSvcImpl implements LoginSvc{
	
	@Resource
	private RomSysLoginDao romSysLoginDao;
	
	@Resource
	private UserDao userDao;
	
	@Resource
	private RomLoginRoleRelationDao romLoginRoleRelationDao;
	
	/**
	 * 增加工号
	 */
	@Override
	public boolean addSysLogin(RomSysLogin romSysLogin) {
		// TODO Auto-generated method stub
		//MD5加密工号密码
		String hashstr= Digests.md5Hex(Digests.md5Hex(romSysLogin.getLoginPwd())+Constants.ROM_SALT);
		
		romSysLogin.setLoginPwd(hashstr);
			
		return romSysLoginDao.add(romSysLogin);
	}
    
	/**
	 * 修改工号
	 * @param obj 修改的对象
	 */
	public boolean updateSysLogin(RomSysLogin obj,String loginNoOld) {
 		
		RomSysLogin param=new RomSysLogin();
		param.setLoginNo(loginNoOld);
		
		return romSysLoginDao.update(obj, param);		
	}	
	
	/**
	 * 删除工号
	 */
	public boolean delSysLogin(String loginNo) {
		RomSysLogin obj=new RomSysLogin();
		obj.setUseFlg(Constants.INVALID);
		
		RomSysLogin param=new RomSysLogin();
		param.setLoginNo(loginNo);
		
		return romSysLoginDao.update(obj, param);		
	}
	
	/**
	 * 通过工号查询对应的dto对象
	 */
	public RomSysLogin queryRomSysLogin(String loginNo){
		RomSysLogin qryObj=new RomSysLogin();
		qryObj.setLoginNo(loginNo);
		
		return romSysLoginDao.queryObject(qryObj);
	}
	
	/**
	 * 通过工号&密码查询对应的dto对象
	 */
	public RomSysLogin queryRomSysLogin(String loginNo, String loginPwd){
		String hashstr= Digests.md5Hex(Digests.md5Hex(loginPwd)+Constants.ROM_SALT);
		RomSysLogin param=new RomSysLogin();
		param.setLoginNo(loginNo);
		param.setLoginPwd(hashstr);
		
		return romSysLoginDao.queryObject(param);
	}
	
	/**
	 * 修改工号密码
	 */
	public void updateLoginPass(RomSysLogin romSysLogin) {
		//MD5加密工号密码
		String hashstr= Digests.md5Hex(Digests.md5Hex(romSysLogin.getLoginPwd())+Constants.ROM_SALT);
		romSysLogin.setLoginPwd(hashstr);
		
		RomSysLogin param=new RomSysLogin();
		param.setLoginNo(romSysLogin.getLoginNo());
		
		romSysLoginDao.update(romSysLogin, param);		
	}	
	
	/**
	 * 
	 * @param loginNo 工号
	 * @param pwd 未加密的密码
	 * @return true:验证通过 false:验证不通过
	 */
	public boolean validUserPwd(String loginNo,String pwd){
		RomSysLogin qryObj=new RomSysLogin();
		qryObj.setLoginNo(loginNo);
		qryObj.setUseFlg(Constants.VALID); //有效工号
		RomSysLogin resultObj=romSysLoginDao.queryObject(qryObj);
		
		if(null==resultObj)return false;//无此工号
		
		String hashstr= Digests.md5Hex(Digests.md5Hex(pwd)+Constants.ROM_SALT);
		if(hashstr.equals(resultObj.getLoginPwd())){
			return true;
		}else{
			return false;
		}
		
	}
	
	/**
	 * 简单的工号生成规则:共6位,第一位是字母"a",后面是5位是数字,数字递增.
	 * @return
	 */
	public String createLoginNo(){
		String maxLoginnoNum=userDao.getMaxLoginnoNum();
		long num=0;
		if(StringUtils.isEmpty(maxLoginnoNum)){
			num=0;
		}else{
			num=Long.parseLong(maxLoginnoNum);
		}
		num=num+1;
				
		java.text.DecimalFormat format = new java.text.DecimalFormat("00000"); 
		String snum=format.format(num);
		return "a"+snum;
	}
	
	public static void main(String[] args) {
		java.text.DecimalFormat format = new java.text.DecimalFormat("00000");   
		int number1=11;
        System.out.println(format.format(number1));  
	}

	@Override
	public List<RoleBo> getRomRoleInfo(RomSysRole romSysRole) {
		// TODO Auto-generated method stub
		return romSysLoginDao.qryRomRoleInfo(romSysRole);
	}

	@Override
	public List<RomLoginRoleRelation> getLoginRoleList(
			RomLoginRoleRelation romLoginRoleRelation) {
		return romLoginRoleRelationDao.queryList(romLoginRoleRelation);
	}

	@Override
	public void setLoginRole(String loginNo, String[] roles) {
		RomLoginRoleRelation o = new RomLoginRoleRelation();
		o.setLoginNo(loginNo);
		romLoginRoleRelationDao.delete(o); //删除角色对应的权限
		
		RomLoginRoleRelation lrr=new RomLoginRoleRelation();
		if(roles!=null){
			for(String roleid:roles){
				lrr.setLoginNo(loginNo);
				lrr.setRoleId(Long.parseLong(roleid));
				lrr.setRemarks("设置工号角色关系");
				romLoginRoleRelationDao.add(lrr);
			}
		}		
	}
	
	@Override
	public List<LoginBo> getLoginTree(LoginBo loginBo){
		return romSysLoginDao.qryLoginTree(loginBo);
	}
}
