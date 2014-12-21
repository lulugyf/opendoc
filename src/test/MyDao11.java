package test;

import java.util.List;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

import com.sitech.jcf.core.dao.IBaseDao;
import com.sitech.rom.common.dto.RomSysLogin;

public class MyDao11 implements ApplicationContextAware{

	private IBaseDao baseDao;
	private static ApplicationContext applicationContext = null;
	
	public List<RomSysLogin> queryList(RomSysLogin romSysLogin){
		return (List<RomSysLogin>) baseDao.queryForList("RomSysLogin.selectRomSysLogin", romSysLogin);
	}

	@Override
	public void setApplicationContext(ApplicationContext arg0)
			throws BeansException {
		applicationContext = arg0;
		baseDao = (IBaseDao)applicationContext.getBean("baseDao");
		
	}

}
