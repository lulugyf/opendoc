package com.sitech.rom.rpt;

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
		Doc doc = (Doc)dao.queryForObject("rptconf.qryDocByFunc", func);
		request.setAttribute("doc", doc);
		
		List<DocParam> plist = (List<DocParam>)dao.queryForList("rptconf.qryDocParam", doc.getDocid());
		request.setAttribute("paramlist", plist);
		request.setAttribute("login_no", session.getAttribute("loginNo"));
		request.setAttribute("serSession", getsersess(session));
		return "rpt/rptdoc_main";
	}
	
	public String getsersess( HttpSession session){
		String serSession = "";
		try{
			ServletContext ctx = session.getServletContext();
			Object tt = ctx.getAttribute("sersess_time");
			
			if(tt == null || System.currentTimeMillis()-((Long)tt).longValue() > 30*60*1000){
				// 暂定30分钟内有效
				String user = DaoUtil.getParameter(dao, "sap.user");
				String pass = DaoUtil.getParameter(dao, "sap.password");
				String cmsport = DaoUtil.getParameter(dao, "sap.cmsport");
				//IEnterpriseSession sess = CrystalEnterprise.getSessionMgr().logon (user, pass, cmsport, "secEnterprise");
				//		"test", "1qaz2wsx", "redtree1:6400", "secEnterprise"); //"username", "password", "<cms>:<port>", "secEnterprise");
				//serSession =  sess.getSerializedSession(); //"---";
				serSession = "---";
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
