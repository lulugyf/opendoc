package com.sitech.rom.rpt;

import java.util.Hashtable;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.sitech.rom.rpt.base.IMyBaseDao;
import com.sitech.rom.rpt.bo.ParamUser;

@Service("reportDocParamSvc")
public class ParamService {
	@Resource
	private IMyBaseDao dao;
	
	public int updateParamUser(int typeid, String login_no, String newsel, String morelogins){
		if(morelogins != null){
			morelogins = morelogins + login_no;
		}else{
			morelogins = login_no;
		}
		String[] sel_n = newsel.split("\\,");
		int affected = 0;

		ParamUser pu = new ParamUser();
		
		for(String lg: morelogins.split("\\,")){
			if("".equals(lg))
				continue;
			pu.setLoginno(lg);
			pu.setTypeid(typeid);
			dao.delete("rptparam.delParamUser", pu);
	
			for(String n: sel_n){
				if("".equals(n)) continue;
				
				pu.setParamid(Integer.parseInt(n));
				dao.insert("rptparam.addParamUser", pu);
				affected ++;
			}
		}
		
		return affected;
	}
	
	public int updateParamUserEx(int typeid, String login_no, int docid, String incl, String excl){
		ParamUser pu = new ParamUser();
		pu.setLoginno(login_no);
		pu.setTypeid(typeid);
		pu.setDocid(docid);
		
		dao.delete("rptparam.delParamUserEx", pu);
		int ret = 0;
		
		pu.setEx_flag("1");
		for(String n: incl.split("\\,")){
			if("".equals(n)) continue;
			pu.setParamid(Integer.parseInt(n));
			dao.insert("rptparam.addParamUserEx", pu);
			ret ++;
		}
		pu.setEx_flag("0");
		for(String n: excl.split("\\,")){
			if("".equals(n)) continue;
			pu.setParamid(Integer.parseInt(n));
			dao.insert("rptparam.addParamUserEx", pu);
			ret ++;
		}
		return ret;
	}
}
