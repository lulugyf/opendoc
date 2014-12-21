package com.sitech.rom.user.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.sitech.rom.common.dao.RomProCodeDao;
import com.sitech.rom.common.dao.RomSysProFunctionDao;
import com.sitech.rom.common.dao.UserDao;
import com.sitech.rom.common.dto.RomProCode;
import com.sitech.rom.common.dto.RomSysProFunction;
import com.sitech.rom.common.dto.RomSysRoleFunction;
import com.sitech.rom.user.service.ProFunctionSvc;
import com.sitech.rom.user.service.ProductSvc;

@Service("productSvc")
public class ProductSvcImpl implements ProductSvc{
	@Resource
	private RomProCodeDao romProCodeDao;
	
	@Resource
	private ProFunctionSvc proFunctionSvc;
	
	@Resource 
	private UserDao userDao;
	
	public List<RomProCode> getProList(RomProCode romProCode){
		return romProCodeDao.queryList(romProCode);
	}

	@Override
	public RomProCode getPro(RomProCode romProCode) {
		return romProCodeDao.queryObject(romProCode);
	}

	@Override
	public void setProductFunction(String productCode, String[] funcs) {
		// TODO Auto-generated method stub
		RomSysProFunction pf = new RomSysProFunction();
		pf.setProCode(productCode);
		proFunctionSvc.delProFunction(pf); //删除角色对应的权限
		
		RomProCode romProCode=new RomProCode();
		if(funcs!=null){
			for(String func:funcs){
				pf.setProCode(productCode);
				pf.setFunctionCode(func);
				pf.setRemarks("设置产品功能");
				proFunctionSvc.addProFunction(pf);
			}
		}
		
	}

	@Override
	public boolean addProduct(RomProCode romProCode) {
		
		String proCode=this.createProductCode();
		romProCode.setProCode(proCode);
		
		return romProCodeDao.add(romProCode);
	}
	
	/**
	 * 简单的产品代码生成规则:共4位,第一位是字母"P",后面是3位是数字,数字递增.
	 * @return
	 */
	public String createProductCode(){
		String maxLoginnoNum=userDao.getMaxProductNum();
		long num=0;
		if(StringUtils.isEmpty(maxLoginnoNum)){
			num=0;
		}else{
			num=Long.parseLong(maxLoginnoNum);
		}
		num=num+1;
				
		java.text.DecimalFormat format = new java.text.DecimalFormat("000"); 
		String snum=format.format(num);
		return "P"+snum;
	}

	@Override
	public boolean updateProduct(RomProCode romProCode){
		RomProCode param=new RomProCode();
		param.setProCode(romProCode.getProCode());
		
		return romProCodeDao.update(romProCode, param);
	}

	@Override
	public boolean delProduct(RomProCode romProCode) {
		return romProCodeDao.delete(romProCode);
	}
	
	
}
