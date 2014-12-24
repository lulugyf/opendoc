package com.sitech.rom.rpt;

import java.util.Enumeration;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sitech.rom.rpt.base.DaoUtil;
import com.sitech.rom.rpt.base.IMyBaseDao;
import com.sitech.rom.rpt.bo.Doc;
import com.sitech.rom.rpt.bo.DocParam;
import com.sitech.rom.rpt.bo.ParamUser;
import com.crystaldecisions.sdk.exception.SDKException;
import com.crystaldecisions.sdk.framework.CrystalEnterprise;
import com.crystaldecisions.sdk.framework.IEnterpriseSession;

@Controller
public class DocController {
	@Resource
	private IMyBaseDao dao;
	
	private final Logger log = Logger.getLogger(getClass());

	@RequestMapping(value = "rptdoc_main.do")
	public String rptdoc_main(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) 
	{
		String func = request.getParameter("opCode");
		String login_no = (String)session.getAttribute("loginNo");
		Doc doc = (Doc)dao.queryForObject("rptconf.qryDocByFunc", func);
		request.setAttribute("doc", doc);
		
		List<DocParam> plist = (List<DocParam>)dao.queryForList("rptconf.qryDocParam", doc.getDocid());
		//如果参数中有不允许修改的， 则需要把选定的关联数据取出来(包括 t_paramuser_rel 和 t_paramuser_rel_ex)， 如果没有， 则是应用默认值
		// 取出的值存放在 default_value 字段中, 多个值以，分隔
		int paramcount = 0; //允许修改值的参数个数, 如果为0， 则页面下载完后直接打开报表页面
		for(DocParam dp: plist){
			//System.out.printf("%s: [%s]  %s\n", dp.getParam(), dp.getAllowchange(), "1".equals(dp.getAllowchange()));
			if(dp.getAllowchange() == 1){
				paramcount ++;
				continue;
			}
			if(dp.getTypeid() == 0)
				continue; //手工输入的类型， 直接使用默认值
			ParamUser pu = new ParamUser();
			pu.setDocid(doc.getDocid());
			pu.setLoginno(login_no);
			pu.setTypeid(dp.getTypeid());
			List<ParamUser> l1 = (List<ParamUser>)dao.queryForList("rptconf.qryParamData", pu);
			List<ParamUser> l2 = (List<ParamUser>)dao.queryForList("rptconf.qryParamDataEx", pu);
			StringBuilder sb = new StringBuilder();
			for(ParamUser p: l1){
				boolean found_excl = false;
				for(ParamUser p1: l2){ //need to check if it excluded
					if(p.getParamid() == p1.getParamid()){
						if("0".equals(p1.getEx_flag())){
							found_excl = true;
						}
					}
				}
				if(!found_excl)
					sb.append(p.getParamValue()).append(',');
			}
			for(ParamUser p: l2){
				sb.append(p.getParamValue()).append(',');
			}
			if(sb.length() > 0){
				sb.deleteCharAt(sb.length()-1);
				dp.setDefault_value(sb.toString());
			}
		}
		
		request.setAttribute("paramlist", plist);
		request.setAttribute("login_no", login_no);
		request.setAttribute("paramCount", paramcount);
		request.setAttribute("serSession", getsersess(request, session));
		return "rpt/rptdoc_main";
	}
	
	public String getsersess(HttpServletRequest request, HttpSession session){
		String serSession = "";
		try{
			ServletContext ctx = session.getServletContext();
			Object tt = ctx.getAttribute("sersess_time");
			
			if(tt == null || System.currentTimeMillis()-((Long)tt).longValue() > 30*60*1000){
				// 暂定30分钟内有效
				
				if(request.getRealPath("path").indexOf(":\\worksrc\\ws2") > 0){
					//for test purpose
					serSession = "---";
				}else{
					String user = DaoUtil.getParameter(dao, "sap.user");
					String pass = DaoUtil.getParameter(dao, "sap.password");
					String cmsport = DaoUtil.getParameter(dao, "sap.cmsport");
					IEnterpriseSession sess = CrystalEnterprise.getSessionMgr().logon (user, pass, cmsport, "secEnterprise");
	//						"test", "1qaz2wsx", "redtree1:6400", "secEnterprise"); //"username", "password", "<cms>:<port>", "secEnterprise");
					serSession =  sess.getSerializedSession();
				}
				ctx.setAttribute("sersess_time", System.currentTimeMillis());
				ctx.setAttribute("sersess", serSession);
			}else{
				serSession = (String)ctx.getAttribute("sersess");
				ctx.setAttribute("sersess_time", System.currentTimeMillis()); //每次取也更新一下时间
			}
			
		}catch(Throwable e){
			log.error("get sersess failed", e);
			serSession = "";
		}

		return serSession;
	}
}
