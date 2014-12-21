/**     
 * @{#} EfPersonService.java Create on 2012-1-9 ����04:34:12     
 *     
 * Copyright (c) 2012 by JCF.SITECH.     
 */ 
package com.sitech.jcf.sample.service.impl;

//import com.sitech.crmpd.core.dao.IBaseDao;
import com.sitech.jcf.sample.dto.Person;
import com.sitech.jcf.sample.service.IEfPersonSevice;

/**
 *
 * ��������
 * �����ˣ�licl
 * ����ʱ�䣺2012-1-9 ����04:34:12
 * �޸��ˣ�
 * �޸�ʱ�䣺
 * �޸ı�ע��
 * @version
 * @see
 * @since iJCF2.0
 *
 */
public class EfPersonService implements IEfPersonSevice {
//	private IBaseDao baseDao;
//
//	public IBaseDao getBaseDao() {
//		return baseDao;
//	}
//
//	public void setBaseDao(IBaseDao baseDao) {
//		this.baseDao = baseDao;
//	}
	
 
	public void savePerson(int i){
		Person p = new Person();
		p.setId(1);
		p.setName("licl");
//		baseDao.insert("order.PersonMapper.insert", p);
	}
	
}
